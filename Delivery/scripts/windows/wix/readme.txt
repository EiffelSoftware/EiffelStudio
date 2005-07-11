<copyright file="mallow.exe" company="Infozoom" author="Stefan Zschocke">
    You must not remove this notice, or any other, from this software.
    Otherwise do with it whatever you want.
    infoZoom may not be made liable for any damages whatsoever 
    (including, without limitation, damages for loss of business profits, 
    business interruption, loss of business information or other pecuniary loss)
    arising out of use of or inability to use the Software
</copyright>

Usage:

Use mallow to generate a wxs file containing Directory, 
Component and File elements of a given Source directory.

After that you can edit this wxs file, for example 
change the component ids to meaningful names, 
or add comments or add shortcuts whatever.

Later when the source directory has changed rerun 
mallow with the wxs-file, which has been generated 
by mallow before, as input parameter. 

Mallow will preserve the content of the file with the 
exception of Directory-, Component- and File elements
to be matched with the physical directory:

File-elements, where the physical file no longer exists,
will be deleted. Same applies to Directory-elements.
Empty Component-elements will then be deleted, too.

For new files and directories, there will new elements 
be generated. Component-elements will be generated, too,
if necessary. 

After this, mallow will insert a comment block at the 
beginning of the generated wxs-output, in which it 
details the changes, so appropriate measures can be 
taken.
Likewise these are:
- Change component guid of changed Components.
- Update the feature table to reflect added/removed
  components.
- Edit shortcuts, where files are removed or added.
