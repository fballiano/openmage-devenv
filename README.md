# devenv.sh environment for OpenMage development

[devenv](https://devenv.sh) it's a powerful development environment based on [NixOS](https://nixos.org).  
It allows you to have containerized environments without containers or hypervisor or emulation, with native performance on any platform.

This repo has a basic (and yet complete) [OpenMage](https://github.com/OpenMage/magento-lts) project installed via composer and all of the necessary software stack:
- PHP 8.0 (managed by PHP-FPM and served by [Caddy](https://caddyserver.com))
- MySQL 8.0
- redis 7.0
- [MailHog](https://github.com/mailhog/MailHog) for email testing
