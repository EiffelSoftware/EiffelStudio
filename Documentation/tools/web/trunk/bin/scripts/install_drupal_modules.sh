#!/bin/sh

CWD=`pwd`
. `dirname $0`/common.sh

getdrupmod()
{
  $EDOC_SCRIPTSDIR/get_drupal_module.sh $1
}

getdrupmod cck-6.x-2.0-rc9.tar.gz
getdrupmod diff-6.x-2.0.tar.gz
getdrupmod geshifilter-6.x-1.1.tar.gz
getdrupmod image-6.x-1.0-alpha3.tar.gz
getdrupmod imce-6.x-1.1.tar.gz
getdrupmod img_assist-6.x-1.0-beta1.tar.gz
getdrupmod lightbox2-6.x-1.8.tar.gz
getdrupmod pathauto-6.x-1.1.tar.gz
getdrupmod persistent_login-6.x-1.4-beta2.tar.gz
#getdrupmod print-6.x-1.0.tar.gz
getdrupmod print-6.x-1.x-dev.tar.gz
getdrupmod recent_changes-6.x-1.x-dev.tar.gz
getdrupmod tagadelic-6.x-1.0.tar.gz
getdrupmod community_tags-6.x-1.0-beta1.tar.gz
getdrupmod talk-6.x-1.5.tar.gz
getdrupmod textareatabs-6.x-0.1.tar.gz
getdrupmod token-6.x-1.11.tar.gz
getdrupmod trash-6.x-1.x-dev.tar.gz
getdrupmod upload_image-6.x-1.x-dev.tar.gz
getdrupmod views-6.x-2.0-rc4.tar.gz
getdrupmod wikitools-6.x-1.0.tar.gz
getdrupmod fckeditor-6.x-1.3-rc1.tar.gz
getdrupmod opensearchplugin-6.x-1.1.tar.gz
getdrupmod jtooltips-6.x-1.8.tar.gz
getdrupmod captcha-6.x-1.0-rc2.tar.gz
getdrupmod captcha_pack-6.x-1.0-beta2.tar.gz
getdrupmod advanced_help-6.x-1.0.tar.gz
getdrupmod book_access-6.x-1.0-rc1.tar.gz
getdrupmod protected_node-6.x-1.3.tar.gz

#getdrupmod freelinking-6.x-1.4.tar.gz
#getdrupmod pearwiki_filter-6.x-1.0-beta1.tar.gz
#getdrupmod flexifilter-6.x-1.1-rc1.tar.gz
#getdrupmod tableofcontents-6.x-2.2.tar.gz
#getdrupmod xmlcontent-6.x-1.x-dev.tar.gz

#getdrupmod nice_menus-6.x-1.1.tar.gz
#getdrupmod dhtml_menu-6.x-3.0-beta.tar.gz
getdrupmod jstools-6.x-1.0.tar.gz
getdrupmod activemenu-6.x-1.x-dev.tar.gz
getdrupmod reindex-6.x-1.x-dev.tar.gz
getdrupmod search_files-6.x-1.6.tar.gz



# For development purpose
getdrupmod schema-6.x-1.3.tar.gz
getdrupmod admin_menu-6.x-1.1.tar.gz
getdrupmod devel-6.x-1.11.tar.gz
getdrupmod nodetype-6.x-1.0.tar.gz
getdrupmod plugin_manager-6.x-1.x-dev.tar.gz
getdrupmod masquerade-6.x-1.0-beta1.tar.gz
#getdrupmod coder-6.x-1.x-dev.tar.gz

#TO add and set up to improve SEO
getdrupmod front-6.x-1.2.tar.gz
getdrupmod globalredirect-6.x-1.0.tar.gz
getdrupmod nodewords-6.x-1.0-rc1.tar.gz
getdrupmod page_title-6.x-2.x-dev.tar.gz

cd $CWD
