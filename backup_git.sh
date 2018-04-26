#!/bin/bash
BACKUP_DIR='/var/opt/gitlab/backups'
/opt/gitlab/bin/gitlab-rake gitlab:backup:create && scp  ${BACKUP_DIR}/*$(date +%Y_%m_%d)* root@192.168.1.81:/var/opt/gitlab/backups/116.backup

NEW_BACKUP=`ls ${BACKUP_DIR}/*$(date +%Y_%m_%d)*`
if [ ${NEW_BACKUP} ];then
    rm -fr ${BACKUP_DIR}/*$(date +%Y_%m_%d -d "-2 days")*
fi