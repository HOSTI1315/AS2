import argparse
import json
import glob
import os
import math
from typing import Dict, Any

BASE_DIR = os.path.dirname(__file__)

def load_json(path: str) -> Dict[str, Any]:
    with open(path, 'r') as f:
        return json.load(f)

# Load data tables
traits = load_json(os.path.join(BASE_DIR, 'Shared', 'Traits', 'Traits.json'))
relics = load_json(os.path.join(BASE_DIR, 'Shared', 'Relics', 'Relics.json'))
accessories = load_json(os.path.join(BASE_DIR, 'Shared', 'Accessories', 'Accessories.json'))
talent_stats = load_json(os.path.join(BASE_DIR, 'Shared', 'Talent_Stats', 'Talent_Stats.json'))
forge_stats = load_json(os.path.join(BASE_DIR, 'Shared', 'Forge_Stats', 'Forge_Stats.json'))
achievements = load_json(os.path.join(BASE_DIR, 'Shared', 'Achievements', 'Achievements.json'))

RARITY_DAMAGE = {
    "Common": 1,
    "Rare": 2,
    "Epic": 3,
    "Legendary": 4.5,
    "Mythical": 8,
    "Secret": 15,
    "Exclusive": 7,
}

def boosts_damage(player: Dict[str, Any]) -> float:
    value = 1
    if player.get('Potions_Used', {}).get('DamagePotion'):
        value += 1
    for ach, active in player.get('Achievements', {}).items():
        if active:
            data = achievements.get(ach)
            if data:
                for perk, val in data.get('Perks', {}).items():
                    if perk == 'Damage':
                        value += val
    return value

def calculate_stats(base: Dict[str, Any], _) -> float:
    return RARITY_DAMAGE.get(base.get('Rarity'), 1)

def calculate_stats_with_multiplier(player: Dict[str, Any], base: Dict[str, Any], unit: Dict[str, Any], rarity_mult: float, boost_mult: float) -> float:
    dmg = base.get('Damage', 0)
    level_mult = 3 ** (unit.get('Level', 1) / 10)
    trait_data = traits.get(unit.get('Trait'), {})
    trait_mult = 1 + trait_data.get('Perks', {}).get('DMG', 0)

    relic_mult = 1
    if unit.get('Relic') and unit['Relic'] in player.get('Relics', {}):
        relic_name = player['Relics'][unit['Relic']]['Name']
        relic_data = relics.get(relic_name, {})
        relic_mult += relic_data.get('Perks', {}).get('Damage', 0)

    accessory_mult = 1
    if unit.get('Accessory') and unit['Accessory'] in player.get('Accessories', {}):
        acc_info = player['Accessories'][unit['Accessory']]
        acc_data = accessories.get(acc_info['Name'], {})
        acc_bonus = acc_data.get('Perks', {}).get('Damage', 0)
        accessory_mult += acc_bonus
        accessory_mult += acc_bonus * forge_stats.get(acc_info.get('Rank', 'E'), 0)

    talent_mult = 1 + talent_stats['DamageHit'].get(unit.get('DamageHit', 'E'), 0)

    asc = unit.get('Ascension', 0)
    if asc >= 3:
        asc_mult = 1.3
    elif asc >= 2:
        asc_mult = 1.15
    elif asc >= 1:
        asc_mult = 1.05
    else:
        asc_mult = 1

    total = dmg * level_mult * trait_mult * relic_mult * accessory_mult * asc_mult * talent_mult
    if unit.get('Shiny'):
        total *= 1.75
    total *= rarity_mult * boost_mult

    log_val = math.log10(total)
    floor_val = math.floor(log_val) - 1
    power = max(floor_val, 0)
    final = total / 10 ** power + 0.3
    return math.floor(final) * 10 ** power

def get_damage(player: Dict[str, Any], base: Dict[str, Any], unit: Dict[str, Any]) -> float:
    mult = boosts_damage(player)
    mult = max(mult, 1)
    if not base or not base.get('Rarity'):
        return 0
    return calculate_stats_with_multiplier(player, base, unit, calculate_stats(base, unit), mult)

def format_line(name: str, dmg: float, dps: float, args: argparse.Namespace) -> str:
    parts = [
        name,
        f"Trait:{args.trait or 'None'}",
        f"Relic:{args.relic or 'None'}",
        f"Accessory:{args.accessory or 'None'}",
        f"Rank:{args.accessory_rank if args.accessory else '-'}",
        f"Ascension:{args.ascension}",
        f"Level:{args.level}",
        f"DamageHit:{args.damage_hit}",
        f"Shiny:{args.shiny}",
        f"DMG:{dmg}",
        f"DPS:{dps}"
    ]
    return " | ".join(parts)

def main():
    parser = argparse.ArgumentParser(description="Compute top characters by damage")
    parser.add_argument('--level', type=int, default=1)
    parser.add_argument('--trait', default=None)
    parser.add_argument('--relic', default=None)
    parser.add_argument('--accessory', default=None)
    parser.add_argument('--accessory-rank', default='E')
    parser.add_argument('--ascension', type=int, default=0)
    parser.add_argument('--shiny', action='store_true')
    parser.add_argument('--damage-hit', default='E')
    parser.add_argument('--damage-potion', action='store_true')
    parser.add_argument('--achievement', action='append', default=[])

    args = parser.parse_args()

    player = {
        'Potions_Used': {'DamagePotion': args.damage_potion},
        'Achievements': {name: True for name in args.achievement},
        'Relics': {},
        'Accessories': {}
    }
    unit = {
        'Level': args.level,
        'Trait': args.trait,
        'Relic': None,
        'Accessory': None,
        'Ascension': args.ascension,
        'DamageHit': args.damage_hit,
        'Shiny': args.shiny
    }
    if args.relic:
        player['Relics']['selected'] = {'Name': args.relic}
        unit['Relic'] = 'selected'
    if args.accessory:
        player['Accessories']['selected'] = {'Name': args.accessory, 'Rank': args.accessory_rank}
        unit['Accessory'] = 'selected'

    shadows: Dict[str, Dict[str, Any]] = {}
    for path in glob.glob(os.path.join(BASE_DIR, 'Shared', 'Shadows', '*', '*.json')):
        data = load_json(path)
        for key, value in data.items():
            shadows[key] = value

    results = []
    for name, data in shadows.items():
        dmg = get_damage(player, data, unit)
        dps = dmg / data.get('SPA', 1)
        results.append({'name': name, 'dmg': dmg, 'dps': dps})

    by_dmg = sorted(results, key=lambda x: x['dmg'], reverse=True)
    by_dps = sorted(results, key=lambda x: x['dps'], reverse=True)

    with open('top_characters.txt', 'w') as f:
        f.write('Top 10 by DMG:\n')
        for entry in by_dmg[:10]:
            f.write(format_line(entry['name'], entry['dmg'], entry['dps'], args) + '\n')
        f.write('\nTop 10 by DPS:\n')
        for entry in by_dps[:10]:
            f.write(format_line(entry['name'], entry['dmg'], entry['dps'], args) + '\n')
        f.write('\nFull Table:\n')
        for entry in by_dmg:
            f.write(format_line(entry['name'], entry['dmg'], entry['dps'], args) + '\n')

if __name__ == '__main__':
    main()
