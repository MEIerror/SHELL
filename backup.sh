#!/bin/bash
BACKUP_DIR='/var/opt/gitlab/backups'
#Backup  completed and sent to the remote host.
/opt/gitlab/bin/gitlab-rake gitlab:backup:create && scp  ${BACKUP_DIR}/*$(date +%Y_%m_%d)* root@192.168.1.81:/var/opt/gitlab/backups/116.backup

#Clear the backup file two days ago.
NEW_BACKUP=`ls ${BACKUP_DIR}/*$(date +%Y_%m_%d)*`
if [ ${NEW_BACKUP} ];then
    rm -fr ${BACKUP_DIR}/*$(date +%Y_%m_%d -d "-2 days")*
fi

:<<!
Backup database at 23:00 every night.
crontab -l:
00 23 * * *  /var/opt/gitlab/backups/backup.sh
!