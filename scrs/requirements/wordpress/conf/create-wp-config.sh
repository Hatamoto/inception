#!/bin/sh

if [ ! -f "/var/www/wp-config.php" ]; then
cat << EOF > /var/www/wp-config.php
define('DB_NAME', 'database_name_here');
define('DB_USER', 'username_here');
define('DB_PASSWORD', 'password_here');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('AUTH_KEY',         ',VZ?E`V3P,I3t-}+8/-@:( KADO]0K2WH_$TlPIC<CE~2$AOhhZ%:(!w@(a#)d1 ');
define('SECURE_AUTH_KEY',  '}z~FxEZ~L*+eYmeuu|Gv7Rp?I.X8[c5:SY5A!Gd]hmvXP1jy_pB)|Kl; +b[)4r$');
define('LOGGED_IN_KEY',    'n#Q+K&M=mk+.)w3!S?}^|r|t,8s4hFSVCR4O@vtF*9q4rU5,cg-1WE?-(m|#EH_#');
define('NONCE_KEY',        '[m98+.g^(r3{0+:<,cSX!sgE{(Jx3+748|N7#g(LY9U||i!{K*zfmZ~gnaVX+TE>');
define('AUTH_SALT',        'w@5xUG;g^MIJ 9%oM#:(A:_$~DI4~8!(G{|mRp >ee$3q3PSDHp99[#u!4;j,jE?');
define('SECURE_AUTH_SALT', '+3[mxpGG~V@Q}nSC_(-3vrqBlr-NPWc*vQhP&+7oOnKYqN$gEJLmowLFr6Ncx7YK');
define('LOGGED_IN_SALT',   'o!7[b*n@V]SXk1.[/C*)B.w37<0Q+qL2zj%[nNq%_X[m-~+[ESEY|P7?QMuCWaCO');
define('NONCE_SALT',       'd|Ier3GvS|F98(}xC]hBtG].#`vf x:4@DUn9uF__d9AD*D(1u=38bdUkVG NvVh');
$table_prefix = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
 define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');
EOF
fi
