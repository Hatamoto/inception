<?php
define('DB_NAME', '{{DB_NAME}}');
define('DB_USER', '{{DB_USER}}');
define('DB_PASSWORD', '{{DB_PASSWORD}}');
define('DB_HOST', '{{DB_HOST}}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('WP_HOME', 'https://{{DOMAIN_NAME}}');
define('WP_SITEURL', 'https://{{DOMAIN_NAME}}');
define('FORCE_SSL_ADMIN', true);
$table_prefix = 'wp_';
define('WP_DEBUG', false);
if ( ! defined('ABSPATH') ) {
    define('ABSPATH', dirname(__FILE__) . '/');
}
require_once(ABSPATH . 'wp-settings.php');