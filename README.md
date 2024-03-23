# devenv.sh environment for OpenMage development

<table><tr><td align=center>
<strong>If you find my work valuable, please consider sponsoring</strong><br />
<a href="https://github.com/sponsors/fballiano" target=_blank title="Sponsor me on GitHub"><img src="https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#white" alt="Sponsor me on GitHub" /></a>
<a href="https://www.buymeacoffee.com/fballiano" target=_blank title="Buy me a coffee"><img src="https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="Buy me a coffee" /></a>
<a href="https://www.paypal.com/paypalme/fabrizioballiano" target=_blank title="Donate via PayPal"><img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" alt="Donate via PayPal" /></a>
</td></tr></table>

[devenv](https://devenv.sh) it's a powerful development environment based on [NixOS](https://nixos.org).  
It allows you to have containerized environments without containers or hypervisor or emulation, with native performance on any platform.  
This is by far the fasted Magento/Openmage development environment I've ever worked with and it's more than worth of the time to learn it.

This repo has a basic (and yet complete) [OpenMage](https://github.com/OpenMage/magento-lts) project installed via composer and all of the necessary software stack:
- PHP 8.2 (managed by PHP-FPM and served by [Caddy](https://caddyserver.com))
- MySQL 8.0
- redis 7.0
- Xdebug 3.2
- [MailHog](https://github.com/mailhog/MailHog) for email testing
- n98-magerun

# Install the environment

1. If you don't have devenv/NixOS installed please follow [devenv's installation guide](https://devenv.sh/getting-started), it's actually pretty easy and straightforward.
2. Then clone this repository to have all the configuration files on your machine

# Startup the environment

1. Enter the cloned repo's directory
2. run `devenv up`, this will start all the software stack (and also run composer install for you)

At the moment the project is configured with `http://openmage.test` as the main domain name (you can change it in the `devenv.nix` file) and you don't even have to add it to your hosts file manually since it's automatically managed through hostctl. You'll just have to open your browser to `http://openmage.test` and continue the installation through the web installer.

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
```

## Notes about email testing

MailHog is chatching all the emails, but:
- you'll have to install `aschroder/smtp_pro` or any other SMTP module for OpenMage (SMTP runs on port `1025`)
- to read the emails and verify what's been sent access the MailHog web interface at `http://127.0.0.1:8025`

## Notes about composer.lock

At the moment this project doesn't have a `composer.lock` file in the repo, because it differ based on the PHP version, this makes it a bit easier to change PHP version if you need to. Anyway I think it's a minor detail and may change in the future.
