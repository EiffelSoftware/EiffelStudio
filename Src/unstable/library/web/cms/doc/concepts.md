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

> Current Theme design [Work in Progress]

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


> CMS block design [To be completed]
