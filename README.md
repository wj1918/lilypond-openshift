Django on OpenShift
===================

Running on OpenShift
--------------------

Create an account at http://openshift.redhat.com/

Install the RHC client tools if you have not already done so:
    
    sudo gem install rhc
=======
Openshift + Django + MySQL
==========================

This is a modified version of the original "openshift/django-example" provided by openshift, so it uses the MySQL database instead of SQLite. You can view the original example code here:
https://github.com/openshift/django-example

Run this code on openshift:
---------------------------

Create a python-2.7 application

    rhc app create -a mymccc -t python-2.7

Add the MySQL cartridge.

    rhc cartridge add mysql-5.5 -a mymccc 
    rhc cartridge add phpmyadmin-4 -a mymccc

Add this upstream repo

    cd mymccc 
    git remote add upstream -m master https://github.com/wj1918/mymccc.git
    git pull -s recursive -X theirs upstream master 

Then push the repo upstream
    
    git push

Now you should be able to checkout your site

    http://mymccc-$yournamespace.rhcloud.com

Admin user name and password
----------------------------
To create the admin user and password, access via SSH to your repo on openshift. You can check your SSH info by doing

    rhc ssh 

When you are logged in to the server, do this

	source $VIRTUAL_ENV/bin/activate
	cd $OPENSHIFT_REPO_DIR/wsgi/openshift
	python manage.py createsuperuser

And write the info it asks you for, and that's it (:

