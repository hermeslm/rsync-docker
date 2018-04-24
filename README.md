**Rsync Docker Container useful for named volume copy and backup.**

Using Rsync to copy container named volume data, very useful to make volume backups, this could be achieved using cp from inside a container or even docker cp, but I decided by rsync for some reasons:

* It is incredibly fast
* It’s more reliable to copy large files or directories and it allows stop and resumes if needed.
* It provides proper progress information (with --info=progress2).

You can check this post: http://blog.diovani.com/technology/2017/06/24/moving-docker-containers-data.html 

### How to build as you own image

```
docker build --rm=true --no-cache=true  --force-rm=true -t your_image_name:tag .
```
### How to use

In the source code, you can get a backup.sh script and the syntax is very simple:

```
./backup.sh container_name volume_path_to_backup output_path
```
### Explaining The Command

* *container_name*: This option you must to specify the container name you want to make the backup,  It is supposed to be the original data container.
* *volume_path_to_backup*: Path in the volume where you store the container data.
* *output_path*: Local data backup directory where you will save your data backups, we use a date pattern at the end of this path.

### Example

```
./backup.sh mysql_1 /var/lib/mysql /backup/mysql
```
You will have in /backup/mysql a folder with a name using today date and inside it all your mysql volume data.
