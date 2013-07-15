git-backup
==========

A ruby script used to maintain an offsite backup of git repositories.

Usage
=====

Mirror
-----
Creare a directory for your backup repositories

    mkdir /home/myuser/mybackups
    
Modify `baseRepoDir` and `baseBackupDir` to match the full path to the directory

Run `./mirror.rb` to create your mirrors

Backup
-----

Modify `baseDir` to match the full path to the directory

Run `./backup.rb`

Automation
-----

Add it to cron via `crontab -e` for scheduled backups
