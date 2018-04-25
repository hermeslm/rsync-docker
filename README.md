**Rsync Docker Container useful for named volume backup and restore.**

Using rsync to copy container named volume data, very useful to make volume backups, this could be achieved using cp from inside a container or even docker cp, but I decided by rsync for some reasons:

* It is incredibly fast
* It’s more reliable to copy large files or directories and it allows stop and resumes if needed.
* It provides proper progress information (with --info=progress2).
* Only sync differences.

I taked from this useful post: http://blog.diovani.com/technology/2017/06/24/moving-docker-containers-data.html
from this repo too: https://github.com/loomchild/volume-backup and I did a merge in one solution, creating a simple
backup and restore docker container using rsync. 
 

### How to build as you own image
Download this repo and build using this command:

```
docker build --rm=true --no-cache=true  --force-rm=true -t your_image_name:tag .
```
### How to use

###### Volume backup:

```
docker run -v [volume_name]:/volume -v [output_dir]:/backup --rm onedsol/rsync backup
```
###### Volume restore:

```
docker run -v [volume_name]:/volume -v [source_dir]:/backup --rm onedsol/rsync restore
```

### Explaining The Command

* *volume_name*: This option you must to specify the volume name you want to make the backup, first this must to exist!!!.
* *source_dir*: Local data backup where from you will restore into data volume.
* *output_path*: Local data directory where you will save your data volume, 
we use a date pattern at the end of this path, very useful if you want to make backups per days.
* *backup/restore*: Those options specify the operation you want to make (backup or restore)

### Note:

Very important note, take care of output and source paths because this script delete all data in restore process and 
overwrite data in backup process.