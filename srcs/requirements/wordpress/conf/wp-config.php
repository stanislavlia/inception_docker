<?php

define('DB_NAME', isset($_ENV['MYSQL_DATABASE']) ? $_ENV['MYSQL_DATABASE'] : 'wordpress_db');
define('DB_USER', trim(file_get_contents('/run/secrets/db_user')));
define('DB_PASSWORD', trim(file_get_contents('/run/secrets/db_password')));
define('DB_HOST', 'mariadb:3306');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Authentication Unique Keys and Salts
define('AUTH_KEY',         trim(file_get_contents('/run/secrets/wp_auth_key')));
define('SECURE_AUTH_KEY',  trim(file_get_contents('/run/secrets/wp_secure_auth_key')));
define('LOGGED_IN_KEY',    trim(file_get_contents('/run/secrets/wp_logged_in_key')));
define('NONCE_KEY',        trim(file_get_contents('/run/secrets/wp_nonce_key')));
define('AUTH_SALT',        trim(file_get_contents('/run/secrets/wp_auth_salt')));
define('SECURE_AUTH_SALT', trim(file_get_contents('/run/secrets/wp_secure_auth_salt')));
define('LOGGED_IN_SALT',   trim(file_get_contents('/run/secrets/wp_logged_in_salt')));
define('NONCE_SALT',       trim(file_get_contents('/run/secrets/wp_nonce_salt')));

$table_prefix = 'wp_';

define('WP_DEBUG', false);

define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_CACHE', true);

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
