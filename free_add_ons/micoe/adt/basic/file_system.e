indexing

description: "Various utilities for manipulating files and clusters.";
keywords: "file", "cluster", "permission"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FILE_SYSTEM

creation
    make

feature -- Initialization

    make is

        do
            -- just for backward compatibility
        end
-----------------------------------------------------------
feature -- Cluster operations

    change_cluster (path : STRING) is
        -- Change current cluster to `path'

        require
            path_not_empty : path /= Void and then not path.empty
            exists         : cluster_exists (path)

        local
            apath  : STRING
            e_name : ANY

        do
            if path.count > 0 and then path.item (1) = '/' then
                apath := path
            else
                apath := concat_paths (current_cluster, path)
            end
            apath  := absolute_path (apath)
            e_name := apath.to_c
            ext_change_cluster ($e_name)
        end
-------------------------------------------------

    current_cluster : STRING is

        do
            create result.make (1)
            result.from_c (ext_current_cluster)
        end
-------------------------------------------------

    add_cluster (path, permissions: STRING) is
        -- Create a new cluster with path `path'

        require
            path_not_empty : path /= void and then path.count /= 0
            valid_perm     : permissions /= void
            perm_to_modify : has_modperm (path_prefix (path))

        local
            ext_pa, ext_pe : ANY

        do
            ext_pa := path.to_c
            ext_pe := permissions.to_c
            ext_add_cluster ($ext_pa, $ext_pe)
        end
-------------------------------------------------

    remove_cluster (path : STRING) is
        -- Eliminate the cluster with path `path'.

        require
            path_not_empty : path /= void and then path.count /= 0
            perm_to_modify : has_modperm (path_prefix (path))
            empty          : file_count (path) = 0 and then
                             subcluster_count (path) = 0

        local
            ext_p : ANY

        do
            ext_p := path.to_c
            ext_remove_cluster ($ext_p)
        end
-------------------------------------------------

    file_list (path : STRING) : SORTED_LIST [STRING] is
        -- Make a sorted list of all files in the cluster with path `path'.

        local
            e_name : ANY
            name   : STRING

        do
            e_name := path.to_c
            ext_file_list ($e_name, result)

            from
                create result.make (false)
            until
                not more_names
            loop
                create name.make (256)
                name.from_c (next_name)
                result.add (name)
            end
        end
-------------------------------------------------

    subcluster_list (path : STRING) : SORTED_LIST [STRING] is
        -- Make a sorted list of all subclusters in the cluster
        -- with path `path'.

        local
            e_name : ANY
            name   : STRING

        do
            e_name := path.to_c
            ext_cluster_list ($e_name, result)

            from
                create result.make (false)
            until
                not more_names
            loop
                create name.make (256)
                name.from_c (next_name)
                result.add (name)
            end
        end
-------------------------------------------------

    file_count (path : STRING) : INTEGER is
        -- The numer of files in the cluster with path `path'.

        require
            path_not_empty : path /= void and then path.count /= void
            perm_to_list   : has_listperm (path)

        local
            ext_p : ANY

        do
            ext_p := path.to_c
            result := ext_cluster_count ($ext_p)
        end    
-------------------------------------------------

    subcluster_count (path : STRING) : INTEGER is
        -- The number of subclusters in the cluster with path `path'.

        require
            path_not_empty : path /= void and then path.count /= void
            perm_to_list   : has_listperm (path)

        local
            ext_p : ANY

        do
            ext_p := path.to_c
            result := ext_subcluster_count ($ext_p)
        end
-------------------------------------------------

    cluster_exists(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty
            perm_to_list   : has_readperm (path_prefix (path))

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_exists ($e_name)
        end
-------------------------------------------------
feature -- Path operations

    temp_file : STRING is
        -- An absolute path not belonging to any file.

        do
            create result.make (256)
            result.from_c (ext_temp_file)
        end
-------------------------------------------------

    absolute_path (path : STRING) : STRING is

        local
            external_name : ANY

        do
            external_name := path.to_c
            create result.make (1)
            result.from_c (ext_absolute_path ($external_name))
        end
-------------------------------------------------

    concat_paths (path1, path2 : STRING) : STRING is
        -- Concatenate `path2' onto `path1' using the appropriate separator.

        local
            ext_name1, ext_name2 : ANY

        do
            ext_name1 := path1.to_c
            ext_name2 := path2.to_c
            create result.make (1)
            result.from_c (ext_concat_paths ($ext_name1, $ext_name2))
        end
-------------------------------------------------

    path_prefix (path : STRING) : STRING is

        local
            ext_name : ANY

        do
            ext_name := path.to_c
            create result.make (1)
            result.from_c (ext_path_prefix ($ext_name))
        end
-------------------------------------------------

    path_suffix (path : STRING) : STRING is

        local
            ext_name : ANY

        do
            ext_name := path.to_c
            create result.make (1)
            result.from_c (ext_path_suffix ($ext_name))
        end
-------------------------------------------------
feature -- File operations

    add_file (path, permissions: STRING) is
        -- Create a file with path `path'.

        require
            path_not_empty : path /= void and then path.count /= 0
            valid_perm     : permissions /= void
            per_to_modify  : has_modperm (path_prefix (path))

        local
            ext_pa, ext_pe : ANY

        do
            ext_pa := path.to_c
            ext_pe := permissions.to_c
            ext_add_file ($ext_pa, $ext_pe)
        end
-------------------------------------------------


    remove_file (path : STRING) is
        -- Eliminate the file with path `path'.

        require
            path_not_empty : path /= void and then path.count /= 0
            perm_to_modify : has_modperm (path_prefix (path))

        local
            ext_p : ANY

        do
            ext_p := path.to_c
            ext_remove_file ($ext_p)
        end
-------------------------------------------------

    file_exists(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_exists ($e_name)
        end
-------------------------------------------------
feature -- Permission status (files)

    has_readperm(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty
            perm_to_list   : has_listperm (path_prefix (path))

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_has_readperm ($e_name)
        end
-------------------------------------------------

    has_writeperm(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty
            perm_to_list    : has_listperm (path_prefix (path))

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_has_writeperm ($e_name)
        end
-------------------------------------------------

    has_execperm(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty
            perm_to_list    : has_listperm (path_prefix (path))

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_has_execperm ($e_name)
        end
-------------------------------------------------
feature -- Permission status (clusters)

    has_modperm(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_has_modperm ($e_name)
        end
-------------------------------------------------

    has_listperm(path : STRING) : BOOLEAN is

        require
            path_not_empty : path /= void and then not path.empty

        local
            e_name : ANY

        do
            e_name := path.to_c
            result := ext_has_listperm ($e_name)
        end
-------------------------------------------------
feature { NONE }

    ext_file_list (path : POINTER; list : SORTED_LIST[STRING]) is

        external "C"
        alias    "c_file_list"

        end
-------------------------------------------------

    ext_cluster_list (path : POINTER; list : SORTED_LIST[STRING]) is

         external "C"
         alias    "c_cluster_list"

         end
-------------------------------------------------

    ext_exists (path : POINTER) : BOOLEAN is

        external "C"
        alias    "c_exists"

        end
-------------------------------------------------

    ext_has_readperm(path : POINTER) : BOOLEAN is

        external "C"
        alias    "c_has_readperm"

        end
-------------------------------------------------

    ext_has_writeperm(path : POINTER) : BOOLEAN is

        external "C"
        alias    "c_has_writeperm"

        end
-------------------------------------------------

    ext_has_execperm(path : POINTER) : BOOLEAN is

        external "C"
        alias    "c_has_execperm"

        end
-------------------------------------------------


    ext_has_modperm(path : POINTER) : BOOLEAN is

        external "C"
        alias    "c_has_modperm"

        end
-------------------------------------------------

    ext_has_listperm(path : POINTER) : BOOLEAN is

        external "C"
        alias    "c_has_listperm"

        end
-------------------------------------------------

    ext_current_cluster : POINTER is

        external "C"
        alias    "c_current_cluster"

        end

-------------------------------------------------

    ext_absolute_path (path : POINTER) : POINTER is

        external "C"
        alias    "c_absolute_path"

        end
-------------------------------------------------

    ext_concat_paths (path1, path2 : POINTER) : POINTER is

        external "C"
        alias    "c_concat_paths"

        end
-------------------------------------------------

    ext_path_prefix (path : POINTER) : POINTER is

        external "C"
        alias    "c_path_prefix"

        end
-------------------------------------------------

    ext_path_suffix (path : POINTER) : POINTER is

        external "C"
        alias    "c_path_suffix"

        end
-------------------------------------------------

    ext_change_cluster (path : POINTER) is

        external "C"
        alias    "c_change_cluster"

        end
-------------------------------------------------

    ext_add_cluster (path, perms : POINTER) is

        external "C"
        alias    "c_add_cluster"

        end
-------------------------------------------------

    ext_add_file (path, perms : POINTER) is

        external "C"
        alias    "c_add_file"

        end
-------------------------------------------------

    ext_remove_cluster (path : POINTER) is

        external "C"
        alias    "c_remove_cluster"

        end
-------------------------------------------------

    ext_remove_file (path : POINTER) is

        external "C"
        alias    "c_remove_file"

        end
-------------------------------------------------

    ext_cluster_count (path : POINTER) : INTEGER is

        external "C"
        alias    "c_cluster_count"

        end
-------------------------------------------------

    ext_subcluster_count (path : POINTER) : INTEGER is

        external "C"
        alias    "c_subcluster_count"

        end
-------------------------------------------------

    ext_temp_file : POINTER is

        external "C"
        alias    "c_temp_file"

        end
-------------------------------------------------

    more_names : BOOLEAN is

        external "C"
        alias    "c_more_names"

        end
-------------------------------------------------

    next_name : POINTER is

        external "C"
        alias    "c_next_name"

        ensure
            real_name : result /= default_pointer
        end

end -- class FILE_SYSTEM

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
