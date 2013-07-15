#!/usr/bin/ruby
# == Synopsis 
#    Mirror all of your git repositories
# 
# == Usage
#    1) create a directory (baseBackupDir) to hold your backups
#    2) in this file, modify 'baseRepoDir' to match the actual repository directory on your server
#    3) ./mirror.rb
#    4) cron it up for scheduled backups (use '[server]$ which ruby' to find ruby on your server, mine is in /usr/bin)
#       
#       [server]$ crontab -e
#       0 0 * * * /usr/bin/ruby /home/myuser/mybackups/mirror.rb
#    5) Now anytime a new repository shows is created, the next time this is run, the repository will get detected and mirrored to backups
#
# == Dependencies
#    ruby, git
#
# == Author
#    Matt Sylvia
#    msylvia@nukefile.net
#
# == Based on code by Origional Author
#    Patrick Reynolds
#    patrick@vunction.com

require 'fileutils'
require 'date'

def directory_exists?(directory)
  File.directory?(directory)
end

def run
  start = Time.now
  num = 0
  ignore =  Array.new
  ignore = [
    ".",
    ".."
  ]
  
  ignoreFlag = false
  baseRepoDir = "/home/user/repositories/"
  baseBackupDir = "/media/backup/repositories/"

  print "\n"

  print "REPOSITORY - #{baseRepoDir}\n"
  print "BACKUP     - #{baseBackupDir}\n"
  

  print "\nChecking for new repositories ...\n\n"
  Dir.foreach(baseRepoDir) do |entry|
    num += 1
    if File::directory?(baseRepoDir+entry)
    
      #ignore directories specified up top
      ignore.each do |i|
        if entry == i
          ignoreFlag = true
          break
        else
          ignoreFlag = false
        end
      end
      
      next if ignoreFlag == true
      
      if directory_exists?(baseBackupDir+entry+".git")
        print "Repository #{entry} found. Skipping.\n"
      else
        print "[NEW] Repository #{entry} found. Creating Mirror.\n";
        `git clone --mirror #{baseRepoDir+entry} baseBackupDir`;
      end

    end
 end

 print "\nCompleted #{num} repositories in #{(Time.now-start).round} seconds\n\n"

end

run
