#!/usr/bin/env python3
import yaml
import sys

def generate_brewfile(profile='all'):
    with open('packages.yaml', 'r') as f:
        config = yaml.safe_load(f)

    brewfile_content = []

    # Add brew packages
    for pkg in config['brew_packages']:
        if profile == 'all' or profile in pkg['profiles']:
            brewfile_content.append(f'brew "{pkg["name"]}"')

    # Add cask packages
    for pkg in config['brew_cask_packages']:
        if profile == 'all' or profile in pkg['profiles']:
            brewfile_content.append(f'cask "{pkg["name"]}"')

    return '\n'.join(brewfile_content)

if __name__ == "__main__":
    profile = sys.argv[1] if len(sys.argv) > 1 else 'personal'
    print(generate_brewfile(profile))
