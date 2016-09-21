# A simple PostgreSQL database backup script
# You can make this run periodically using cron or other similar tool

# CONFIGURATION

# Where to store the backups
# Use the full absolute path!
BACKUP_DIR=~/getyourdata_backup

# How many backups to keep in the directory
BACKUP_ROTATE_COUNT=10

# File containing the SSH password (necessary onlyif you're using
# password authentication instead of SSH keys, see below)
SSH_PASSWORD_FILE=~/getyourdata_backup_pass

# IP of the server
SERVER_IP=127.0.0.1

# ACTUAL SCRIPT
mkdir -p $BACKUP_DIR;
cd $BACKUP_DIR;

# Use normal scp (uses SSH key authentication)
scp -r -v getyourdatabackup@$SERVER_IP:/home/getyourdatabackup/db_backups/* .

# If you want to use password authentication instead, uncomment the line below
# and comment the normal scp command above
# sshpass -f $SSH_PASSWORD_FILE scp -r -v getyourdatabackup@$SERVER_IP:/home/getyourdatabackup/db_backups/* .

(ls -t|head -n $BACKUP_ROTATE_COUNT;ls)|sort|uniq -u|xargs --no-run-if-empty rm