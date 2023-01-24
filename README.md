# devenv.sh environment for OpenMage development

[devenv](https://devenv.sh) it's a powerful development environment based on [NixOS](https://nixos.org).  
It allows you to have containerized environments without containers or hypervisor or emulation, with native performance on any platform.

This is by far the fasted Magento/Openmage development environment I've ever worked with and it's more than worth of the time to learn it.

This repo has a basic (and yet complete) [OpenMage](https://github.com/OpenMage/magento-lts) project installed via composer and all of the necessary software stack:
- PHP 8.1 (managed by PHP-FPM and served by [Caddy](https://caddyserver.com))
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

## Notes about installing OpenMage

When asked for MySQL host/user/password type `127.0.0.1`, `openmage` and `openmage` (you can change the default username/password editing your `devenv.nix` file).

## Configuring OpenMage for redis

redis runs on port 6379, you can enable OpenMage support for it in the usual way, eg:
```xml
<cache>
    <backend>Mage_Cache_Backend_Redis</backend>
    <backend_options>
        <server>127.0.0.1</server>
        <port>6379</port>
        <persistent><![CDATA[cache-db0]]></persistent>
        <database>0</database>
        <password></password>
        <force_standalone>0</force_standalone> <!-- 0 for phpredis, 1 for standalone php -->
        <connect_retries>1</connect_retries>
        <read_timeout>10</read_timeout>
        <automatic_cleaning_factor>0</automatic_cleaning_factor>
        <compress_data>1</compress_data>
        <compress_tags>1</compress_tags>
        <compress_threshold>204800</compress_threshold>
        <compression_lib>gzip</compression_lib>
    </backend_options>
</cache>
'''

## Notes about email testing

MailHog is chatching all the emails, but:
- you'll have to install `aschroder/smtp_pro` or any other SMTP module for OpenMage (SMTP runs on port `1025`)
- to read the emails and verify what's been sent access the MailHog web interface at `http://127.0.0.1:8025`

## Notes about composer.lock

At the moment this project doesn't have a `composer.lock` file in the repo, because it differ based on the PHP version, this makes it a bit easier to change PHP version if you need to. Anyway I think it's a minor detail and may change in the future.

## TODO

I'm working with the NixOS maintainers to [integrate n98-magerun in their repos](https://github.com/NixOS/nixpkgs/pull/212296), they will be soon made available inside the `nix-shell `for use to use without any need to install them, it will be pretty amazing.
