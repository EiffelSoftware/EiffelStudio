This is a quick-and-dirty documentation for the preferences library.

* History:
First designed by Pascal Freund and Christophe Bonnard.
Bug fixes by Arnaud Pichery and Xavier Rousselot.
Big refactoring by Xavier Rousselot.

* Clusters:
gui and interface are the only clusters that clients should use directly.
xml is a common implementation cluster.
registry and xml_implementation are platform-dependent implementation clusters (respectively for Windows and Unix).

The interface cluster provides all low-level functionality, and can be used for console application. It should precompile without Vision2.
The gui cluster provides all the functionality needed in a user interface. It includes definition of graphical resource types (fonts and colors), the preference window that lets users modify the preferences and the discardable dialogs. This cluster relies on Vision2. Note: the SHARED_RESOURCES class in the gui cluster is only a facade for the RESOURCE_STRUCTURE class to be used by graphical applications.

* How to use the library:
The first thing to do is to create an XML file that contains the properties and the default values of the resources that are to be used by the application. This XML file contains folders and resources.
Folders have a name, an icon and can be set as hidden in the preference window.
Resources have a name, a type, a value (in a string representation) and can be set as hidden. On top of that, an optional property indicates whether the application needs to be restarted for the resource value to be taken into account.
For more details on the syntax of this XML file, have a look at the default.xml file used by EiffelStudio.

To initialize the preferences, there are only two steps.
First, register all resource types that the application needs. To help you do so, a `register_basic_types' and a `register_basic_graphical_types' features are provided in the SHARED_RESOURCES class (the `register_basic_types' is also available in the RESOURCE_STRUCTURE, in case you don't want to use the gui cluster). Always start by registering the basic types using one of these features. Then, register all additional types you need using the `register_type' feature of the RESOURCE_STRUCTURE.
Once this is done, call `make_from_location' in RESOURCE_STRUCTURE (or `initialize' in SHARED_RESOURCES). The first parameter is the full path to the default XML file, the second parameter is either a path to the XML where the user preferences are stored, or a path in the registry where they are stored, depending on whether you are using the xml_implementation cluster or the registry cluster.

Resources can be queried and set using either the RESOURCE_STRUCTURE class or the SHARED_RESOURCES one. Note that using the SHARED_RESOURCES one is more convenient since it provides several features to query and modify the preferences simply, without using any other class (resources, resource types etc remain hidden).

An advanced functionality in the preferences library is the use of observers and managers. It is possible to define observers of a given resource, so that they will updated whenever the resource value changes. This is possible by using the RESOURCE_OBSERVATION_MANAGER class, which keeps as a once the observers table. Observers should implement the OBSERVER interface, which defines the `update' feature.
Another advanced functionality is the possibility to let users define resource types themselves very easily. To do so, they just have to implement the RESOURCE_TYPE interface (of the GRAPHICAL_RESOURCE_TYPE one, if the resource type is to be used in graphical applications) and register their types before initializing the RESOURCE_STRUCTURE (the preconditions are there to help in the process).

* What should be improved:
Make a more consistent use of assertions throughout the library, though I already started to do so.
Add the possibility to restore the default value of a single resource at a time. This shouldn't be too hard, since I believe resources keep as an attribute their default value, although I don't think it is used (!)
Add a USER_DEFINED_RESOURCE_TYPE as a basic type, to let the user define their own resources easily without having to inherit from classes from the library.
A small gotcha: the preference window uses a discardable dialog to warn the user that the application needs to be restarted for the new values to be taken account. This means that clients of the gui cluster need to define the corresponding resource in their default XML file.

