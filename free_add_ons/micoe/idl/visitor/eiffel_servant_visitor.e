indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class EIFFEL_SERVANT_VISITOR

inherit
    TYPECODE_CONSTANTS;
    EIFFEL_CODE_VISITOR

creation
    make

feature

    interfaces_deferred : BOOLEAN is

        do
            result := false
        end
----------------------

    is_a_stub : BOOLEAN is

        do
            result := false
        end
----------------------

     is_a_skeleton : BOOLEAN is

        do
            result := false
        end
----------------------

     is_an_implementation : BOOLEAN is

        do
            result := false
        end
----------------------

    is_a_servant : BOOLEAN is

        do
            result := true
        end
----------------------

    visitor_type : INTEGER is

        do
            result := 4
        end
----------------------

    standard_parent : STRING is

        do
        end
----------------------

    root : STRING is

        do
            result := clone (path_prefix)
            result := fs.concat_paths (result, "servant")
            if not fs.cluster_exists (result) then
                fs.add_cluster (result, "lm.lm")
            end
        end
----------------------

    class_name_suffix : STRING is

        do
            result := "_IMPL"
        end
----------------------

    generate_interface_inherit (in : INTERFACE) is

        local
            name     : STRING
            mname    : STRING
            cparents : INDEXED_LIST [SCOPED_NAME]
            in1      : INTERFACE
            i, n     : INTEGER

        do
            name := scoped_name_to_class_name (in.name)
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (name)
            io.put_string ("_SKEL%N")
            indent_to (2)
            io.put_string ("rename%N")
            indent_to (3)
            io.put_string ("make as make_skel%N")
            indent_to (2)
            io.put_string ("end")

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
            if cparents = void then
                io.put_string ("%N")
            else
                io.put_string (";%N")
            end

            if cparents /= void then
                from
                    i     := 1
                    n     := cparents.count
                until
                    i > n
                loop
                    indent_to (1)
                    name := scoped_name_to_class_name (cparents.at (i))
                    io.put_string (name)
                    io.put_string ("_IMPL%N")
                    indent_to (2)
                    io.put_string ("rename%N")
                    indent_to (3)
                    io.put_string ("make as make_")
                    mname := scoped_name_to_class_name (cparents.at (i))
                    mname.append ("_IMPL")
                    io.put_string (mname)
                    io.new_line
                    indent_to (2)
                    io.put_string ("undefine%N")
                    indent_to (3)
                    io.put_string ("type_name, consume, valid_message_type,%N")
                    indent_to (3)
                    io.put_string ("repoid, template, dispatcher, %
                                   %doinvoke, make_skel")
                    if i > 1 then
                        io.put_string (",%N")
                        indent_to (3)
                        io.put_string ("ib_make, unused_doinvoke%N")
                    else
                        io.new_line
                    end
                    indent_to (2)
                    io.put_string ("end")

                    if i < n then
                        io.put_string (";%N")
                    else
                        io.new_line
                    end
                    i := i + 1
                end -- loop
            end
        end
----------------------

    generate_interface_creators is

        do
            io.put_string ("%Ncreation%N")
            indent_to (1)
            io.put_string ("make%N%N")
        end
----------------------

    generate_interface_make (in : INTERFACE) is

        local
            sname    : STRING
            pname    : STRING
            cparents : INDEXED_LIST [SCOPED_NAME]
            in1      : INTERFACE
            i, n     : INTEGER

        do
            sname := safe_name ("name", true)
            indent_to (1)
            io.put_string ("make is%N")
            indent_to (2)
            io.put_string ("-- You may give this creation procedure%N")
            indent_to (2)
            io.put_string ("-- any arguments needed.%N%N")
            indent_to (2)
            io.put_string ("do%N")

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
            indent_to (3)
            io.put_string ("make_skel%N")
            if cparents /= void and then cparents.count > 0 then
                indent_to (3)
                io.put_string ("-- if any parent's creation procedure%N")
                indent_to (3)
                io.put_string ("-- takes arguments add them below.%N")
                from
                    i := 1
                    n := cparents.count
                until
                    i > n
                loop
                    indent_to (3)
                    io.put_string ("make_")
                    pname := scoped_name_to_class_name (cparents.at (i))
                    pname.append ("_IMPL")
                    io.put_string (pname)
                    io.new_line
                    i := i + 1
                end
            end
            indent_to (3)
            io.put_string ("-- put any other initialization needed here.%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    eiffel_type (in_type : STRING) : STRING is
        -- special to handle "wstring", but it may
        -- prove generally useful.

        do
            if equal (in_type, "wstring") then
                result := "ARRAY [INTEGER]"
            elseif types_defined_here.has (in_type) then
                result := "CORBA_OBJECT"
            else
                result := clone (in_type)
                result.to_upper
            end
        end
----------------------

    ca_type (t : STRING) : STRING is

        do
            if equal (t, "integer") then
                result := "long"
            elseif equal (t, "real") then
                result := "double"
            elseif equal (t, "character") then
                result := "char"
            else
                result := t
            end
        end
----------------------

    generate_undefines (extra : STRING) is

        do
        end
----------------------

    generate_attributes (ad : ATTR_DCL) is

        do
            -- They are now deferred functions.
        end
----------------------

    generate_attribute_mutators (ad : ATTR_DCL) is

        local
            i, n  : INTEGER
            sname : STRING

        do
            sname := safe_name ("value", true)
            from
                i := 1
                n := ad.component_count
            until
                i > n
            loop
                indent_to (1)
                io.put_string ("set_")
                ad.component_at (i).accept (current)
                io.put_string (" (")
                io.put_string (sname)
                io.put_string (" : ")
                ad.param_type_spec.accept (current)
                io.put_string (") is%N%N")
                indent_to (2)
                io.put_string ("do%N")
                indent_to (2)
                io.put_string ("end%N%N")
                i := i + 1
            end
        end
----------------------

    generate_attribute_accessors (ad : ATTR_DCL) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := ad.component_count
            until
                i > n
            loop
                indent_to (1)
                ad.component_at (i).accept (current)
                io.put_string (" : ")
                ad.param_type_spec.accept (current)
                io.put_string (" is%N%N")
                indent_to (2)
                io.put_string ("do%N")
                indent_to (2)
                io.put_string ("end%N%N")
                i := i + 1
            end
        end
----------------------

    generate_routine_body (od : OP_DCL) is

        do
            indent_to (2)
            io.put_string ("do%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end

end -- class EIFFEL_SERVANT_VISITOR

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
