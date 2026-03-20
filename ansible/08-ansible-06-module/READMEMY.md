# my_own_namespace.yandex_cloud_elk Collection

## Contents

### Modules
- `my_own_module` - Creates text files with specified content

### Roles
- `use_my_module` - Wrapper role with defaults

## Usage

```yaml
- hosts: all
  roles:
    - role: my_own_namespace.yandex_cloud_elk.use_my_module
      vars:
        my_module_path: /etc/myapp/config.txt
        my_module_content: "key=value"
