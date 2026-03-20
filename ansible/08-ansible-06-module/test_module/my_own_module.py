#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2024, Anastasia Andryushina <your.email@example.com>
# GNU General Public License v3.0+

from __future__ import absolute_import, division, print_function
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_module

short_description: Creates a text file with specified content on remote host

version_added: "1.0.0"

description:
    - This module creates a text file on the remote host.
    - The file path and content are specified via parameters.
    - Supports idempotency: file is only updated if content differs.

options:
    path:
        description:
            - Full path to the file to create.
            - Parent directories will be created if they don't exist.
        required: true
        type: str
    content:
        description:
            - Content to write to the file.
            - Can be multi-line string.
        required: true
        type: str
    owner:
        description:
            - File owner (username or uid).
        required: false
        type: str
        default: root
    group:
        description:
            - File group (groupname or gid).
        required: false
        type: str
        default: root
    mode:
        description:
            - File permissions in octal notation (e.g., '0644').
        required: false
        type: str
        default: '0644'
    backup:
        description:
            - Create a backup of the existing file if it exists.
        required: false
        type: bool
        default: false

author:
    - Anastasia Andryushina (@Nastil2019)
'''

EXAMPLES = r'''
# Create a simple config file
- name: Create application config
  my_namespace.yandex_cloud_elk.my_own_module:
    path: /etc/myapp/config.txt
    content: |
      server_host=localhost
      server_port=8080
      debug=true

# Create file with specific permissions
- name: Create secure credentials file
  my_namespace.yandex_cloud_elk.my_own_module:
    path: /etc/myapp/secret.txt
    content: "api_key=supersecret123"
    mode: '0600'
    owner: myapp
    group: myapp

# With backup of existing file
- name: Update config with backup
  my_namespace.yandex_cloud_elk.my_own_module:
    path: /etc/myapp/config.txt
    content: "new_config_value=true"
    backup: true
'''

RETURN = r'''
path:
    description: Full path to the created/modified file.
    type: str
    returned: always
    sample: '/etc/myapp/config.txt'
backup_file:
    description: Path to backup file (if backup=true and file existed).
    type: str
    returned: when backup is created
    sample: '/etc/myapp/config.txt.2024-01-15@10:30:45~'
checksum:
    description: SHA256 checksum of the file content.
    type: str
    returned: always
    sample: 'a1b2c3d4e5f6...'
'''

import os
import hashlib
import shutil
from datetime import datetime
from ansible.module_utils.basic import AnsibleModule


def calculate_checksum(content):
    """Calculate SHA256 checksum of content."""
    return hashlib.sha256(content.encode('utf-8')).hexdigest()


def file_exists_and_matches(path, content):
    """Check if file exists and has the same content."""
    if not os.path.exists(path):
        return False
    try:
        with open(path, 'r', encoding='utf-8') as f:
            existing_content = f.read()
        return existing_content == content
    except Exception:
        return False


def create_backup(path):
    """Create timestamped backup of existing file."""
    timestamp = datetime.now().strftime('%Y-%m-%d@%H:%M:%S')
    backup_path = f"{path}.{timestamp}~"
    shutil.copy2(path, backup_path)
    return backup_path


def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True, no_log=False),
        owner=dict(type='str', required=False, default='root'),
        group=dict(type='str', required=False, default='root'),
        mode=dict(type='str', required=False, default='0644'),
        backup=dict(type='bool', required=False, default=False)
    )

    result = dict(
        changed=False,
        path='',
        checksum='',
        backup_file=None
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    path = module.params['path']
    content = module.params['content']
    owner = module.params['owner']
    group = module.params['group']
    mode = module.params['mode']
    backup = module.params['backup']

    result['path'] = path
    result['checksum'] = calculate_checksum(content)

    # Check mode: report what would happen
    if module.check_mode:
        if not file_exists_and_matches(path, content):
            result['changed'] = True
        module.exit_json(**result)

    # Ensure parent directory exists
    parent_dir = os.path.dirname(path)
    if parent_dir and not os.path.exists(parent_dir):
        try:
            os.makedirs(parent_dir, mode=0o755)
            result['changed'] = True
        except Exception as e:
            module.fail_json(msg=f"Failed to create directory {parent_dir}: {str(e)}", **result)

    # Create backup if requested and file exists
    if backup and os.path.exists(path):
        try:
            result['backup_file'] = create_backup(path)
        except Exception as e:
            module.fail_json(msg=f"Failed to create backup: {str(e)}", **result)

    # Write file if content differs or file doesn't exist
    if not file_exists_and_matches(path, content):
        try:
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            # Set permissions
            os.chmod(path, int(mode, 8))
            
            # Set ownership (requires root)
            import pwd, grp
            try:
                uid = pwd.getpwnam(owner).pw_uid if owner.isdigit() == False else int(owner)
                gid = grp.getgrnam(group).gr_gid if group.isdigit() == False else int(group)
                os.chown(path, uid, gid)
            except KeyError as e:
                module.warn(f"Could not set owner/group: {str(e)}")
            
            result['changed'] = True
            
        except Exception as e:
            module.fail_json(msg=f"Failed to write file {path}: {str(e)}", **result)
    else:
        # File exists with same content - ensure permissions are correct
        current_mode = oct(os.stat(path).st_mode)[-4:]
        if current_mode != mode:
            os.chmod(path, int(mode, 8))
            result['changed'] = True

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()