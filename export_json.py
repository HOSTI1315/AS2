import os
import json
from lupa import LuaRuntime

BASE_DIR = os.path.dirname(__file__)

lua = LuaRuntime(unpack_returned_tuples=True)
load_func = lua.eval(
    'function(code, env) setmetatable(env, {__index=_G}); local f = load(code, "@", "t", env); return f() end'
)
LuaTable = type(lua.table())
LuaFunction = type(lua.eval('function() end'))

class FakeInstance:
    def __init__(self, path):
        self.path = path
    def WaitForChild(self, name):
        return FakeInstance(os.path.join(self.path, name))
    def GetService(self, name):
        if name == "ReplicatedStorage":
            return FakeInstance(BASE_DIR)
        raise KeyError(name)

class Game:
    def GetService(self, name):
        if name == "ReplicatedStorage":
            return FakeInstance(BASE_DIR)
        raise KeyError(name)

class ModuleScript:
    def __init__(self, path):
        self.path = os.path.abspath(path)
        self.Name = os.path.splitext(os.path.basename(path))[0]
    def IsA(self, name):
        return name == 'ModuleScript'
    def GetChildren(self):
        children = []
        dirpath = os.path.dirname(self.path)
        for name in os.listdir(dirpath):
            subpath = os.path.join(dirpath, name)
            if os.path.isfile(subpath) and name.endswith('.lua') and subpath != self.path:
                children.append(ModuleScript(subpath))
            elif os.path.isdir(subpath):
                for subname in os.listdir(subpath):
                    if subname.endswith('.lua'):
                        children.append(ModuleScript(os.path.join(subpath, subname)))
        return lua.table_from(children), None

def to_py(value):
    if isinstance(value, LuaTable):
        keys = list(value.keys())
        if keys and all(isinstance(k, int) for k in keys):
            return [to_py(value[k]) for k in sorted(keys)]
        else:
            return {str(k): to_py(value[k]) for k in keys}
    elif isinstance(value, LuaFunction):
        return '<function>'
    else:
        return value

cache = {}

def load_module(path):
    path = os.path.abspath(path)
    if path in cache:
        return cache[path]
    env = lua.table_from({})
    env['game'] = Game()
    script_obj = ModuleScript(path)
    env['script'] = script_obj
    env['task'] = lua.table_from({'spawn': lambda f, *a: f(*a)})
    env['warn'] = lambda *a: None

    def req(obj):
        if isinstance(obj, ModuleScript):
            return load_module(obj.path)
        elif isinstance(obj, FakeInstance):
            if os.path.isdir(obj.path):
                cand = os.path.join(obj.path, os.path.basename(obj.path) + '.lua')
                if os.path.exists(cand):
                    return load_module(cand)
            return load_module(obj.path + '.lua')
        elif isinstance(obj, str):
            if not obj.endswith('.lua'):
                obj = obj + '.lua'
            return load_module(os.path.join(os.path.dirname(path), obj))
        else:
            raise TypeError('Unsupported require argument: %r' % (obj,))
    env['require'] = req

    with open(path, 'r', encoding='utf-8') as f:
        code = f.read()
    result = load_func(code, env)
    cache[path] = result
    return result

def export_all(base='Shared'):
    for root, _, files in os.walk(base):
        for file in files:
            if file.endswith('.lua'):
                lua_path = os.path.join(root, file)
                data = load_module(lua_path)
                py_data = to_py(data)
                json_path = os.path.splitext(lua_path)[0] + '.json'
                with open(json_path, 'w', encoding='utf-8') as f:
                    json.dump(py_data, f, indent=2, ensure_ascii=False)
                print('Wrote', json_path)

if __name__ == '__main__':
    export_all('Shared')
