docker exec -it nextcloud /usr/bin/sudo -u www-data php /var/www/html/occ maintenance:mode --on
docker exec -it maria-db mysqldump --single-transaction -h 127.0.0.1 -u nextcloud -pnextcloud ncdb > nextcloud-sqlbkp_`date +"%Y%m%d"`.bak
docker exec -it nextcloud rsync -Aavx 3rdparty/ AUTHORS COPYING .htaccess .user.ini apps/ config/ console.php console.php conv.sh core/ cron.php cron.sh custom_apps/  index.html index.php lib/ occ ocm-provider ocs ocs-provider public.php remote.php resources/ robots.txt scan-files.sh status.php themes/ version.php  data/nextcloud-dirbkp_`date +"%Y%m%d"`/
zip -r9 nextcloud-dirbkp_`date +"%Y%m%d"`.zip /containers/cloud/nextcloud/data/nextcloud-dirbkp_`date +"%Y%m%d"`/
rm -rf /containers/cloud/nextcloud/data/nextcloud-dirbkp_`date +"%Y%m%d"`/
docker exec -it nextcloud /usr/bin/sudo -u www-data php /var/www/html/occ maintenance:mode --off
