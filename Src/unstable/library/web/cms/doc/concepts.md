CMS Concepts
============
[Work in progress]

##### Table of Contents  
[Theme](#theme)  
[Regions](#regions)  
[Blocks](#blocks)  

<a name="theme"/>
Theme
-----
In a CMS , a theme is a collection of templates files (HTML, CSS, Images, etc ) that determine how a CMS web site looks.  The goal of a theme is to let you change the look and feel of the site.
Eiffel CMS uses the same default regions as Drupal for themes.

#### Important Classes

* [CMS_THEME] (/library/src/theme/cms_theme.e): The deferred class CMS_THEME provides an abstraction to the actual theme.
* [SMARTY_CMS_THEME] (/library/src/theme/smarty_theme/smarty_cms_theme.e): The class SMARTY_CMS_THEME, is a theme implementation using the [Eiffel Smarty library] (https://github.com/eiffelhub/template-smarty).
* [CMS_TEMPLATE] (/library/src/theme/cms_template.e): The deferred CMS_TEMPLATE clas provides an abstraction to describe the theme, the variables to feed it and how to render it as html.  At the moment there is only one implementation [SMARTY_CMS_PAGE_TEMPLATE] (/library/src/theme/smarty_theme/smarty_cms_page_template.e).

<a name="regions"/>
Regions
-------
The layout of a CMS web page has predefined area called **regions**. The Eiffel CMS uses the same default regions as Drupal, so let's see them in the following image.


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

**Regions Hold Blocks**

What goes inside regions?  Generally, regions hold smaller piece of content called blocks.  Blocks hold chunks of content, like the user login form, navigation menu or the information for the footer.

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

