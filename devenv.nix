{ pkgs, config, ... }:

{
  env.MAGE_IS_DEVELOPER_MODE = 1;
  env.DEV_PHP_STRICT = 1;

  packages = [ pkgs.git pkgs.gnupatch ];

  languages.php.enable = true;
  languages.php.package = pkgs.php80.buildEnv {
    extensions = { all, enabled }: with all; enabled ++ [ xdebug redis ];
    extraConfig = ''
      memory_limit = 512m
      opcache.memory_consumption = 256M
      opcache.interned_strings_buffer = 20
    '';
  };
  languages.php.fpm.pools.web = {
    settings = {
      "clear_env" = "no";
      "pm" = "dynamic";
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 5;
    };
  };

  services.mailhog.enable = true;
  services.redis.enable = true;

  services.caddy.enable = true;
  services.caddy.virtualHosts."http://openmage.test:80" = {
    extraConfig = ''
      root * pub
      php_fastcgi unix/${config.languages.php.fpm.pools.web.socket}
      file_server
    '';
  };

  services.mysql.enable = true;
  services.mysql.initialDatabases = [{ name = "openmage"; }];
  services.mysql.ensureUsers = [
    {
      name = "openmage";
      password = "openmage";
      ensurePermissions = { "openmage.*" = "ALL PRIVILEGES"; };
    }
  ];

  enterShell = ''
    composer install
  '';
}
