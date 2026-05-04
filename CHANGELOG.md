# terraform_enterprise CHANGELOG

This file is used to list changes made in each version of the terraform_enterprise cookbook.

## 1.1.0

- Require Chef Infra Client 18 or later.
- Refresh supported platforms to Ubuntu 22.04/24.04, Debian 12, RHEL/Rocky/AlmaLinux 8 and 9; drop EOL Ubuntu 16.04/18.04 from Test Kitchen.
- Replace deprecated `generic/*` Vagrant boxes with `bento/*`.
- Replace backtick `not_if '\`netstat ...\`'` guard with `ss`-based string guard on the `install_ptfe` execute resource (prevents the installer being run during compile and survives platforms without `netstat`).
- Migrate ERB template to dot-string node syntax via `template variables`; drop bracket-symbol attribute access.
- Add attributes for installer URL, private/public addresses, admin console port, and post-install sleep so they are no longer hardcoded.
- Tighten file modes on `/etc/replicated.conf`, `settings.json`, `license.rli` (0644) and mark sensitive content.
- Remove deprecated `.foodcritic` and `.delivery/` artifacts.
- Refresh Cookstyle GitHub Action.

> **Note:** HashiCorp is sunsetting the Replicated installer in favor of Terraform Enterprise Flexible Deployment Options (FDO — Docker, Podman, Nomad, Kubernetes). This cookbook still targets the legacy Replicated path; new deployments should evaluate FDO instead.

## 1.0.0

Initial release.
