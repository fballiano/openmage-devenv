# devenv.sh environment for OpenMage development

[devenv](https://devenv.sh) it's a powerful development environment based on [NixOS](https://nixos.org).  
It allows you to have containerized environments without containers or hypervisor or emulation, with native performance on any platform.

This repo has a basic (and yet complete) [OpenMage](https://github.com/OpenMage/magento-lts) project installed via composer and all of the necessary software stack:
- PHP 8.0 (managed by PHP-FPM and served by [Caddy](https://caddyserver.com))
- MySQL 8.0
- redis 7.0
- Xdebug 3.2
- [MailHog](https://github.com/mailhog/MailHog) for email testing

# Install the environment

1. If you don't have devenv/NixOS installed please follow [devenv's installation guide](https://devenv.sh/getting-started), it's actually pretty easy and straightforward.
2. Then clone this repository to have all the configuration files on your machine

# Startup the environment

1. Enter the cloned repo's directory
2. run `devenv up`, this will start all the software stack (and also run composer install for you)

At the moment the project is configured with `http://openmage.test` as the main domain name (you can change it in the `devenv.nix` file), so you'll have to add `openmage.test`to your `hosts` file first, then you'll be able to open the browser to `http://openmage.test` and continue the installation through the web installer.

## Notes about email testing

MailHog is chatching all the emails, but:
- you'll have to install `aschroder/smtp_pro` or any other SMTP module for OpenMage
- to read the emails and verify what's been sent access the MailHog web interface at `http://127.0.0.1:8025`

## TODO

I'm working with the NixOS maintainers to integrate n98-magerun in their repos, they will be soon made available inside the `nix-shell `for use to use without any need to install them, it will be pretty amazing
