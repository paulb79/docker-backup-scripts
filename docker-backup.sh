#!/bin/bash
# by piscue
# modified by ricky.hewitt <rickyhewitt.dev>
# modifications:
#   - Removal of dropbox (local storage only)
#   - Removed CoreOS support
#   - Unified into a single bash script
#   - Tidier output
# modified by flomine
# modifications:
#   - add config file

# Setting variables
. `dirname $0`/inc-cfg.bash || exit 1


DATE=`date +%Y-%m-%d` 
# Create destination path
mkdir -p $backup_path

#
# Backup images
#
echo -e "Starting docker backup.. \n"
echo -e "Backing up images.. \n"

for i in `docker inspect --format='{{.Name}}' $(docker ps -aq) | cut -f2 -d\/`
        do container_name=$i
        echo -n "$container_name - "
        container_image=`docker inspect --format='{{.Config.Image}}' $container_name`
        mkdir -p $backup_path/$container_name
	#save_file="$backup_path/$container_name/${DATE}_$container_name-image.tar"
	save_file="$backup_path/$container_name/$container_name-image.tar"
	docker save -o $save_file $container_image
        echo "OK"
done



#
# Backup volumes
# 

echo -e "Backing up volumes.. \n"

for i in `docker inspect --format='{{.Name}}' $(docker ps -aq) | cut -f2 -d\/`
        do container_name=$i
        mkdir -p $backup_path/$container_name
        echo -n "$container_name - "
	docker run --rm \
	--volumes-from $container_name \
  	-v ${backup_path}:/backup \
  	-e TAR_OPTS="$tar_opts" \
        flomine/docker-backup \
	#backup "$container_name/${DATE}_$container_name-volume.tar.xz"
	backup "$container_name/$container_name-volume.tar.xz"
	echo "OK"
done
