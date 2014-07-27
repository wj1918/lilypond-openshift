#!/bin/sh
#
# install required tools 
#
# from source code or prebuild package 
# http://mirror.centos.org/centos/6/os/x86_64/Packages
# http://dl.fedoraproject.org/pub/epel/6/x86_64/
# 

install_centos_rpm()
{
    RPM=$1
    cd $RUN_DIR
    curl -0 http://mirror.centos.org/centos/6/os/x86_64/Packages/$RPM > $RPM
    rpm2cpio $RPM | cpio -idmv
    rm $RPM
}

install_epel_rpm()
{
    RPM=$1
    curl -0 http://dl.fedoraproject.org/pub/epel/6/x86_64/$RPM > $RPM
    rpm2cpio $RPM | cpio -idmv
    rm $RPM
}

fix_pkgconfig()
{
    PCDIR=usr/lib64/pkgconfig
    cd $PCDIR
    newdir=$(echo $RUN_DIR |sed 's/\//\\\//g')usr
    sed -i "s/=\/usr/=$newdir/g" *.pc
    cd ../../..
}


fix_texlive()
{
    sed -i 's/=\ \/usr/= $RUN_DIR\/usr/g;s/=\ \/var/= $RUN_DIR\/var/g;s/=\ \/etc/= $RUN_DIR\/etc/g;s/=\ \$HOME/= $RUN_DIR/g' $TEXMFCNF/texmf.cnf
}

install_libtool()
{
    #build libtool
    cd  $RUN_DIR/build
    rm  libtool-2.4.2.tar.gz 
    wget  http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz 
    tar xfz libtool-2.4.2.tar.gz 
    cd libtool-2.4.2 
    ./configure --prefix=$RUN_DIR/usr
    make
    make install
}

install_guile()
{
    #build guile
    cd  $RUN_DIR/build
    rm  guile-1.8.8.tar.gz
    wget ftp://ftp.gnu.org/gnu/guile/guile-1.8.8.tar.gz
    tar xfz guile-1.8.8.tar.gz 
    cd guile-1.8.8
    ./configure --prefix=$RUN_DIR/usr LDFLAGS=-L$RUN_DIR/usr/lib CPPFLAGS=-I$RUN_DIR/usr/include
    make
    make install
}

install_lilypond()
{
    #build guile
    cd  $RUN_DIR/build
    rm  lilypond-2.18.2.tar.gz
    wget http://download.linuxaudio.org/lilypond/sources/v2.18/lilypond-2.18.2.tar.gz
    tar xfz lilypond-2.18.2.tar.gz
    cd lilypond-2.18.2
    ./configure --prefix=$RUN_DIR/usr LDFLAGS=-L$RUN_DIR/usr/lib CPPFLAGS=-I$RUN_DIR/usr/include
    make
    make install
}

install_fontforge()
{
    cd  $RUN_DIR/build
    rm  fontforge_full-20120731-b.tar.bz2
    wget http://superb-dca3.dl.sourceforge.net/project/fontforge/fontforge-source/fontforge_full-20120731-b.tar.bz2 
    tar xfj fontforge_full-20120731-b.tar.bz2
    cd fontforge-20120731-b
    ./configure --prefix=$RUN_DIR/usr --enable-double
    make
    make install
}


cleanup()
{
    if [[ -r build ]] ; then
	rm -rf build
    fi
    mkdir build
    rm -rf usr lib64 etc
}


install_rpms()
{
    	install_centos_rpm glib2-2.26.1-3.el6.x86_64.rpm
    	install_centos_rpm glib2-devel-2.26.1-3.el6.x86_64.rpm
#	install_centos_rpm fontconfig-2.8.0-3.el6.x86_64.rpm
	install_centos_rpm freetype-2.3.11-14.el6_3.1.x86_64.rpm
	install_centos_rpm pango-1.28.1-7.el6_3.x86_64.rpm
  	install_centos_rpm pango-devel-1.28.1-7.el6_3.x86_64.rpm
	install_centos_rpm flex-2.5.35-8.el6.x86_64.rpm
	install_centos_rpm bison-2.4.1-5.el6.x86_64.rpm
	install_centos_rpm gettext-0.17-16.el6.x86_64.rpm
	install_centos_rpm texinfo-4.13a-8.el6.x86_64.rpm
        install_centos_rpm texinfo-tex-4.13a-8.el6.x86_64.rpm
        install_centos_rpm fontforge-20090622-3.1.el6.x86_64.rpm
	install_centos_rpm fontforge-devel-20090622-3.1.el6.x86_64.rpm 
	install_centos_rpm texi2html-1.82-5.1.el6.noarch.rpm

	install_centos_rpm kpathsea-2007-57.el6_2.x86_64.rpm
	install_centos_rpm kpathsea-devel-2007-57.el6_2.x86_64.rpm
	install_centos_rpm libspiro-20071029-3.1.el6.x86_64.rpm
	install_centos_rpm libspiro-devel-20071029-3.1.el6.x86_64.rpm
	install_centos_rpm libuninameslist-20080409-3.1.el6.x86_64.rpm
	install_centos_rpm libuninameslist-devel-20080409-3.1.el6.x86_64.rpm
        
	install_epel_rpm t1utils-1.37-1.el6.x86_64.rpm  


	# for build guile
	install_centos_rpm gmp-4.3.1-7.el6_2.2.i686.rpm
	install_centos_rpm gmp-devel-4.3.1-7.el6_2.2.x86_64.rpm

	install_centos_rpm fontconfig-devel-2.8.0-3.el6.x86_64.rpm
	install_centos_rpm freetype-devel-2.3.11-14.el6_3.1.x86_64.rpm
	install_centos_rpm pango-devel-1.28.1-7.el6_3.x86_64.rpm

    # install texlive
        
    install_centos_rpm texlive-texmf-errata-2007-7.1.el6.noarch.rpm
    install_centos_rpm texlive-texmf-2007-38.el6.noarch.rpm
    install_centos_rpm netpbm-10.47.05-11.el6.x86_64.rpm
    install_centos_rpm netpbm-progs-10.47.05-11.el6.x86_64.rpm
    install_centos_rpm texlive-texmf-errata-dvips-2007-7.1.el6.noarch.rpm
    install_centos_rpm texlive-texmf-dvips-2007-38.el6.noarch.rpm
    install_centos_rpm texlive-texmf-errata-latex-2007-7.1.el6.noarch.rpm
    install_centos_rpm texlive-texmf-errata-fonts-2007-7.1.el6.noarch.rpm
    install_centos_rpm texlive-texmf-fonts-2007-38.el6.noarch.rpm
    install_centos_rpm texlive-2007-57.el6_2.x86_64.rpm
    install_centos_rpm texlive-dvips-2007-57.el6_2.x86_64.rpm
    install_centos_rpm texlive-utils-2007-57.el6_2.x86_64.rpm
    install_centos_rpm texlive-texmf-latex-2007-38.el6.noarch.rpm
    install_centos_rpm texlive-latex-2007-57.el6_2.x86_64.rpm
    install_centos_rpm tex-preview-11.85-10.el6.noarch.rpm
    
} 


. $OPENSHIFT_DATA_DIR/server.conf
cleanup

install_rpms
fix_pkgconfig

ORIGINAL_PATH=/var/lib/openshift/53cb39a94382ecf35700075f/python//virtenv/bin:/var/lib/openshift/53cb39a94382ecf35700075f/python//bin:/opt/rh/python27/root/usr/bin:/bin:/usr/bin:/usr/sbin
export PKG_CONFIG_PATH=$RUN_DIR/usr/lib64/pkgconfig
export PATH=$RUN_DIR/usr/bin:$ORIGINAL_PATH
export LD_LIBRARY_PATH=/opt/rh/python27/root/usr/lib64:$RUN_DIR/usr/lib64:$RUN_DIR/usr/lib
export MANPATH=/opt/rh/python27/root/usr/share/man:$RUN_DIR/usr/share/man
export GUILE_LOAD_PATH=$RUN_DIR/usr/share/guile/1.8
export TEXMFCNF=$RUN_DIR/usr/share/texmf/web2c
export BISON_PKGDATADIR=$RUN_DIR/usr/share/bison
export RUN_DIR

fix_texlive

install_libtool
install_guile
install_fontforge
install_lilypond

echo "done."
