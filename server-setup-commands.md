# Server setup commands

```bash
vi .bashrc

export PS1='\[\033[0;32m\]\h\[\033[0;36m\] \w\[\033[00m\]: '
alias dir="ls -lartF"
alias free="free -m"
alias update="sudo aptitude update"
alias install="sudo aptitude install"
alias upgrade="sudo aptitude safe-upgrade"
alias remove="sudo aptitude remove"
alias a2r="sudo /etc/init.d/apache2 restart"
alias a2rl="sudo /etc/init.d/apache2 reload"
alias ag='sudo apache2ctl graceful'
alias mksite='sudo /srv/tools/a2mksite.sh'
alias mksitelog='sudo /srv/tools/a2mksitelog.sh'
alias cleancache='sudo echo 3 > /proc/sys/vm/drop_caches'

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

---

```bash
hostname --fqdn
echo “karma” > /etc/hostname
hostname -F /etc/hostname
```

---

```bash

vi /etc/hosts

127.0.0.1 localhost.localdomain   localhost
127.0.0.1 karma.DOMAIN_NAME      karma
DOMAIN_IP karma.DOMAIN_NAME  karma
```

---

```bash
timezone
dpkg-reconfigure tzdata
```

---

```bash
aptitude install build-essential
apt-get install subversion
apt-get install libapache2-svn
apt-get install php5-gd
apt-get install git
apt-get install acl
apt-get install subversion
apt-get install libapache2-svn
```

---

```bash
vi /etc/fstab
auto,acl 
mount / -o remount 
```

```bash
vi /etc/php5/apache2/php.ini
```

```ini
sendmail_path = /usr/sbin/sendmail -i  -t
upload_max_filesize = 8M
max_execution_time = 30
memory_limit = 64M  ->htan 32
error_reporting = E_COMPILE_ERROR|E_RECOVERABLE_ERROR|E_ERROR|E_CORE_ERROR -> htan E_ALL & ~E_DEPRECATED
display_errors = Off
log_errors = On
error_log = /var/log/php.log
register_globals = Off
```

---

```bash
a2enmod deflate
a2enmod expires
a2enmod cache
a2enmod headers
a2enmod rewrite
a2enmod ssl
a2enmod auth_digest
a2enmod dav
a2enmod dav_lock
```

---

Apache config

```apacheconf
Timeout 30 -> htan 300
KeepAliveTimeout 5 -> htan 15
```

---

`update vi /etc/apache2/httpd.conf`

---

`vi /etc/group`

---

```bash
aptitude install phpmyadmin

vi /etc/apache2/apache2.conf
```

```apacheconf
# phpMyAdmin default Apache configuration
#Alias dbadmin.paramana.com /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
        Options Indexes FollowSymLinks
        DirectoryIndex index.php
        # For Apache 1.3 and 2.0
        <IfModule mod_auth.c>
            AuthType Basic
            AuthName "phpMyAdmin Setup"
            AuthUserFile /etc/phpmyadmin/htpasswd.setup
        </IfModule>

        # For Apache 2.2
        <IfModule mod_authn_file.c>
            AuthType Basic
            AuthName "phpMyAdmin Setup"
            AuthUserFile /etc/phpmyadmin/htpasswd.setup
        </IfModule>
        Require valid-user
        # Authorize for setup
        <Files setup.php>
                # For Apache 1.3 and 2.0
                <IfModule mod_auth.c>
                        AuthType Basic
                        AuthName "phpMyAdmin Setup"
                        AuthUserFile /etc/phpmyadmin/htpasswd.setup
                </IfModule>

                # For Apache 2.2
                <IfModule mod_authn_file.c>
                        AuthType Basic
                        AuthName "phpMyAdmin Setup"
                        AuthUserFile /etc/phpmyadmin/htpasswd.setup
                </IfModule>
                Require valid-user
        </Files>
        <IfModule mod_php4.c>
                AddType application/x-httpd-php .php
                php_flag magic_quotes_gpc Off
                php_flag track_vars On
                php_flag register_globals Off
                php_value include_path .
        </IfModule>
        <IfModule mod_php5.c>
                AddType application/x-httpd-php .php
                php_flag magic_quotes_gpc Off
                php_flag track_vars On
                php_flag register_globals Off
                php_value include_path .
        </IfModule>
</Directory>
```

`vi /etc/phpmyadmin/config.inc.php`

```php
$cfg['ForceSSL'] = 'true';
```

inside domain public

```bash
ln -s /usr/share/phpmyadmin

/usr/sbin/pma-configure
/usr/sbin/pma-secure

openssl req -new -x509 -days 3650 -nodes -out /etc/ssl/certs/dbadmin.pem -keyout /etc/ssl/certs/dbadmin.key
```

---

```bash

apt-get install fail2ban

vi /etc/fail2ban/jail.local
````

```ini
[DEFAULT]

# "ignoreip" can be an IP address, a CIDR mask or a DNS host
ignoreip = 127.0.0.1 DOMAIN_IP 87.210.33.8 91.132.48.220 82.95.179.89 90.184.8.80
bantime  = 21600 
maxretry = 5

# "backend" specifies the backend used to get files modification. Available
# options are "gamin", "polling" and "auto".
# yoh: For some reason Debian shipped python-gamin didn't work as expected
#      This issue left ToDo, so polling is default backend for now
backend = polling

#
# Destination email address used solely for the interpolations in
# jail.{conf,local} configuration files.
destemail = server@emprego.co.mz

# Default action to take: ban only
action = iptables[name=%(__name__)s, port=%(port)s]


[ssh]

enabled = true
port    = ssh
filter  = sshd
logpath  = /var/log/auth.log
maxretry = 5


[apache]

enabled = true
port    = http
filter  = apache-auth
logpath = /var/log/apache*/*error.log
maxretry = 5


[apache-noscript]

enabled = false
port    = http
filter  = apache-noscript
logpath = /var/log/apache*/*error.log
maxretry = 5


[vsftpd]

enabled  = false
port     = ftp
filter   = vsftpd
logpath  = /var/log/auth.log
maxretry = 5


[proftpd]

enabled  = true
port     = ftp
filter   = proftpd
logpath  = /var/log/auth.log
maxretry = 5


[wuftpd]

enabled  = false
port     = ftp
filter   = wuftpd
logpath  = /var/log/auth.log
maxretry = 5


[postfix]

enabled  = false
port     = smtp
filter   = postfix
logpath  = /var/log/mail.log
maxretry = 5


[courierpop3]

enabled  = false
port     = pop3
filter   = courierlogin
logpath  = /var/log/mail.log
maxretry = 5

[pop3d]

enabled  = false
port     = pop3
filter   = pop3d
logpath  = /var/log/mail.log
maxretry = 5

[courierimap]

enabled = false
port = imap2
filter = courierimap
logpath = /var/log/mail.log
maxretry = 5

[sasl]

enabled  = false
port     = smtp
filter   = sasl
logpath  = /var/log/mail.log
maxretry = 5
```

```bash
/etc/init.d/fail2ban restart
```

---

mysql settings

```ini
default-character-set=utf8
default-collation=utf8_general_ci
default-storage_engine = innodb
```

---

https://library.linode.com/email/postfix/postfix2.9.6-dovecot2.0.19-mysql

commands

```bash
postmap /etc/postfix/sender_access

apt-get install opendkim opendkim-tools


openssl genrsa -out private.key 1024
openssl rsa -in private.key -out public.key -pubout -outform PEM
chmod 600 /etc/opendkim/private.key
```