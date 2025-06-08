# AS2 Data Export

This repository contains a collection of Roblox `ModuleScript` files stored in the
`Shared/` directory. The `export_json.py` script converts each module into a JSON
file placed next to the original Lua source.

## Usage

1. Install Python requirements:
   ```sh
   pip install lupa luaparser
   ```

2. Run the exporter from the repository root:
   ```sh
   python3 export_json.py
   ```
   This creates `.json` files alongside each `.lua` module, e.g.
   `Shared/Accessories/Accessories.json`.

The script emulates a minimal Roblox environment using `lupa` (LuaJIT bindings)
to execute the modules and capture the returned tables. Functions are serialized
as the string `"<function>"` in the resulting JSON.
