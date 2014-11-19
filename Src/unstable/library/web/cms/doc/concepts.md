CMS Concepts
============
>Current implemented concepts

##### Table of Contents  

1. [**Theme**](#theme)
2. [**Regions**](#regions)
      - [**Default Page Layout**](#page_layout)
      - [**Regions Holds blocks**](#regions_blocks)
3. [**Blocks**](#blocks)
4. [**Modules**](#modules)
5. [**Hooks**](#hooks)


<a name="theme"/>
Theme
-----
In a CMS , a theme is a collection of templates files (HTML, CSS, Images, etc ) that determine how a CMS web site looks.  The goal of a theme is to let you change the look and feel of the site.
Eiffel CMS is inspired by Drupal, and use the same default region names as default drupal theme.

#### Important Classes

* [CMS_THEME] (/library/src/theme/cms_theme.e):  Abstraction defining the interface of a CMS theme.
* [SMARTY_CMS_THEME] (/library/src/theme/smarty_theme/smarty_cms_theme.e): Theme implemented using the [Eiffel Smarty library] (https://github.com/eiffelhub/template-smarty).
* [CMS_TEMPLATE] (/library/src/theme/cms_template.e): Template Abstraction that contains theme, variables needed by template when rendering page as html. At the moment there is only one implementation SMARTY_CMS_PAGE_TEMPLATE.  At the moment there is only one implementation [SMARTY_CMS_PAGE_TEMPLATE] (/library/src/theme/smarty_theme/smarty_cms_page_template.e).

<a name="regions"/>
Regions
-------
The layout of a CMS web page has predefined area called **regions**. The Eiffel CMS uses the same default regions as Drupal, so let's see them in the following image.

<a name="page_layout"/>
![default page layout](http://themery.com/sites/default/files/figure-15-10.png)

```
regions[page_top] = Top
regions[header] = Header
regions[content] = Content
regions[highlighted] = Highlighted
regions[help] = Help
regions[footer] = Footer
regions[first_sidebar] = first sidebar
regions[second_sidebar] = second sidebar
regions[page_bottom] = Bottom
```
<a name="regions_blocks"/>
**A Region holds blocks**

**What goes inside regions?**
Generally, regions hold smaller piece of content called blocks.  Blocks hold chunks of content, like the user login form, navigation menu or the information for the footer.

Regions are defined in a configuration file theme.info.


<a name="blocks"/>
CMS_BLOCK
---------
**What is a cms block?** 
Blocks are chunk of content that can be created to display whatever you want, and then can be placed in various resgions in your template (theme) layout. 

#### Important Classes

* [CMS_BLOCK] (/library/src/kernel/content/cms_block.e): The deferred class CMS_BLOCK provides an abstraction to describe content to be placed inside Regions.
* [CMS_CONTENT_BLOCK] (/library/src/kernel/content/cms_content_block.e): The class CMS_CONTENT_BLOCK describe how to provide generic content. 
* [CMS_MENU_BLOCK](/library/src/kernel/content/cms_menu_block.e): The class CMS_MENU_BLOCK describe how to provides a menu of navigational links.
* [CMS_SMARTY_TEMPLATE_BLOCK] (/library/src/kernel/content/cms_smarty_templateblock.e) The class CMS_SMARTY_TEMPLATE_BLOCK describe how to use a CMS block with smarty template file content.


<a name="modules"/>
CMS_MODULES
-----------
**What is a cms module?**
Modules are piece of code that adds one or more features to your web site. 
Modules can be plugged and combined to provide a web site customized to your needs. There are modules for many purposes, for example Administratiton, Basic Authentication, etc.

#### Important Classes
* [CMS_MODULE] (/library/src/modules/cms_module.e): The deferred class CMS_MODULE provides an abstraction to describe a generic module that add features to your web site.
* [CMS_RESPONSE](/library/src/service/response/cms_response.e). The deferred class CMS_RESPONSE provide an abstraction to builds the content to get process to render the output. 


<a name="hooks">
CMS_HOOK
--------
Hooks is a mechanism which provide a way for modules to interact with each other and extending blocks of the current CMS.

* [CMS_HOOK] (/library/src/hooks/cms_hook.e): The deferred class CMS_HOOK is a marker interface for CMS Hook
* [CMS_HOOK_AUTO_REGISTER] (/library/src/hooks/cms_hook_auto_register.e): The deferred class provides an abstraction that when inheriting from this class, the declared hooks are automatically registered, otherwise, each descendant has to add it to the cms service	itself.
* [CMS_HOOK_BLOCK](/library/src/hooks/cms_hook_block.e): The class CMS_HOOK_BLOCK describe a hook providing a way to alter a generic block.
* [CMS_HOOK_FORM_ALTER](/library/src/hooks/cms_hook_form_alter.e): The class CMS_HOOK_FORM_ATLER describe a hook providing a way to alter a form.
* [CMS_HOOK_MENU_ALTER](/library/src/hooks/cms_hook_menu_alter.e): The class CMS_HOOK_MENU_ATLER describe a hook providing a way to alter a menu.
* [CMS_HOOK_MENU_SYSTEM_ALTER](/library/src/hooks/cms_hook_menu_system_alter.e): The class CMS_HOOK_MENU_SYSTEM_ALTER describe a hook providing a way to alter the CMS menu system.
* [CMS_HOOK_VALUE_TABLE_ALTER](/library/src/hooks/cms_hook_value_table_alter.e):: The class CMS_HOOK_VALUE_TABLE_ALTER describe a hook providing a way to alter the value table for a response.
