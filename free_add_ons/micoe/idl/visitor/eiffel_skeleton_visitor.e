indexing

description: "Generates code for skeletons";
keywords: "Visitor Pattern", "code generation";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class EIFFEL_SKELETON_VISITOR

inherit
    EIFFEL_CODE_VISITOR
        redefine
            generate_dispatcher
        end

creation
    make

feature

    interfaces_deferred : BOOLEAN is

        do
            result := true
        end
----------------------

    is_a_stub : BOOLEAN is

        do
            result := false
        end
----------------------

    is_a_skeleton : BOOLEAN is

        do
            result := true
        end
----------------------

    is_an_implementation : BOOLEAN is

        do
            result := false
        end
----------------------

    is_a_servant : BOOLEAN is

        do
            result := false
        end
----------------------

    visitor_type : INTEGER is

        do
            result := 2
        end
----------------------

    standard_parent : STRING is

        do
            result := "STANDARD_SKELETON"
        end
----------------------

    root : STRING is

        do
            result := clone (path_prefix)
            result := fs.concat_paths (result, "skeleton")
            if not fs.cluster_exists (result) then
                fs.add_cluster (result, "lm.lm")
            end
        end
----------------------

    class_name_suffix : STRING is

        do
            result := "_SKEL"
        end
----------------------

    generate_interface_inherit (in : INTERFACE) is

        local
            in1      : INTERFACE
            name     : STRING
            cparents : INDEXED_LIST [SCOPED_NAME]
            i, n     : INTEGER

        do
            name := scoped_name_to_class_name (in.name)
            io.put_string ("%Ninherit%N")

            if in.parent_count > 0 then
                -- Collect those parents that aren't abstract.
                from
                    create cparents.make (false)
                    i := 1
                    n := in.parent_count
                until
                    i > n
                loop
                    in1 := interfaces.at (in.parent_at (i))
                    if not in1.abstract then
                        cparents.append (in1.name)
                    end
                    i := i + 1
                end
            end
            if cparents = void or else cparents.count = 0 then
                indent_to (1)
                io.put_string ("STANDARD_SKELETON%N")
                indent_to (2)
                io.put_string ("undefine%N")
                indent_to (3)
                io.put_string ("repoid, consume, valid_message_type%N")
                indent_to (2)
                io.put_string ("select%N")
                indent_to (3)
                io.put_string ("doinvoke%N")
                indent_to (2)
                io.put_string ("end;%N")
                indent_to (1)
                io.put_string (name)
                io.new_line
                indent_to (2)
                io.put_string ("rename%N")
                indent_to (3)
                io.put_string ("doinvoke as unused_doinvoke%N")
                indent_to (2)
                io.put_string ("select%N")
                indent_to (3)
                io.put_string ("make%N")
                indent_to (2)
                io.put_string ("end%N")
            else -- cparents /= void and then cparents.count > 0
                from
                    indent_to (1)
                    io.put_string (name)
                    io.new_line
                    indent_to (2)
                    io.put_string ("undefine%N")
                    indent_to (3)
                    io.put_string ("doinvoke%N")
                    indent_to (2)
                    io.put_string ("end;%N")
                    i := 1
                    n := cparents.count
                    if feature_names.has (in.name) then
                        features := feature_names.at (in.name)
                    else
                        create features.make (true)
                        collect_interface_feature_names (in)
                        feature_names.put (features, in.name)
                    end
                until
                    i > n
                loop
                    in1 := interfaces.at (cparents.at (i))
                    indent_to (1)
                    name := scoped_name_to_class_name (cparents.at (i))
                    io.put_string (name)
                    io.put_string ("_SKEL%N")
                    indent_to (2)
                    io.put_string ("undefine%N")
                    if in1.parent_count = 0 then
                        indent_to (3)
                        io.put_string ("make,%N")
                    end
                    indent_to (3)
                    io.put_string ("repoid, type_name, consume,%N")
                    indent_to (3)
                    io.put_string ("valid_message_type, template")
                    if i > 1 then
                        io.put_string (",%N")
                        indent_to (3)
                        io.put_string ("ib_make, dispatcher%N")
                    else
                        io.new_line
                        indent_to (2)
                        io.put_string ("redefine%N")
                        indent_to (3)
                        io.put_string ("dispatcher%N")
                    end
                    indent_to (2)
                    io.put_string ("end")
                    if i < n then
                        io.put_string (";%N")
                    end
                    i := i + 1
                end
            end
            io.new_line
        end
----------------------

    generate_interface_creators is

        do
            -- Skeletons are deferred.
        end
----------------------

    generate_interface_make (in : INTERFACE) is

        do
            -- Not needed in skeletons.
        end
----------------------

    generate_dispatcher is

        local
            i, n : INTEGER
            od   : OP_DCL

        do
            indent_to (1)
            io.put_string ("dispatcher : DICTIONARY [COURIER, STRING] is%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("cour : COURIER%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create result.make%N")
            from
                i := 1
                n := pending_routines.count
            until
                i > n
            loop
                od := pending_routines.at (i)
                indent_to (3)
                io.put_string ("create cour.make (void, void, ")
                io.putint (i)
                io.put_string (")%N")
                indent_to (3)
                io.put_string ("result.put (cour, %"")
                io.put_string (od.name)
                io.put_string ("%")%N")
                i  := i + 1
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_undefines (extra : STRING) is

        do
            -- Not needed here.
        end
----------------------

    generate_attributes (ad : ATTR_DCL) is

        do
        end
----------------------

    generate_attribute_mutators (ad : ATTR_DCL) is

        do
        end
----------------------

    generate_attribute_accessors (ad : ATTR_DCL) is

        do
        end
----------------------

    generate_routine_body (od : OP_DCL) is

        do
        end
----------------------

    frozen generate_request (cl_name, op_name, ret_type  : STRING;
                             arg_names : ARRAY [STRING];
                             arg_attrs : ARRAY [STRING];
                             arg_types : ARRAY [STRING]) is

        do
        end
----------------------

    dummy : ARRAY [STRING] is
        -- An array of length 0

        once
            create result.make (1, 0)
        end

end -- class EIFFEL_SKELETON_VISITOR

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
