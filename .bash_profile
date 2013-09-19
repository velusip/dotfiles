. $HOME/.bashrc
#sudo loadkeys -q ~/.consolevu.map&
#eval `keychain --eval --agents ssh id_rsa`

# Richard Bronosky's BASH script for migrating ACL grants:
# usage:  mygrants --host=sourcehost --user=root --password=secret | grep user_in_transit | mysql --host=desthost --user=root --password=secret
mygrants()
{
    mysql -B -N $@ -e "SELECT DISTINCT CONCAT('SHOW GRANTS FOR ''', user, '''@''', host, ''';') AS query FROM mysql.user" | \
        mysql $@ | \
        sed 's/\(GRANT .*\)/\1;/;s/^\(Grants for .*\)/## \1 ##/;/##/{x;p;x;}'
}

