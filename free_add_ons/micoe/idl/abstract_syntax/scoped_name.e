indexing

description: "Represents nonterminal <scoped_name>(12[2.3])";
keywords: "scoped_name";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SCOPED_NAME

inherit
    HASHABLE
        undefine
            copy, is_equal
        redefine
            hash_code
        end;
    COMPARABLE
        redefine
            infix "<", copy, is_equal
        end
    SIMPLE_TYPE_SPEC
         undefine
             copy, is_equal
         end;
    SWITCH_TYPE_SPEC
         undefine
             copy, is_equal
         end;
    CONST_TYPE
        undefine
            copy, is_equal
        end;
    PRIMARY_EXPR
        rename
            make as exp_make
        undefine
            accept, copy, is_equal
        end;
    PARAM_TYPE_SPEC
        undefine
            copy, is_equal
        redefine
            accept
        end

creation
    make

feature -- Initialization

    make is

        do
            create name_components.make (false)
        end
----------------------
feature -- Access

    initial_doublecolon : BOOLEAN
        -- Is `current' of the form ::comp1::... ?

    name_component_count : INTEGER is

        do
            if name_components /= void then
                result := name_components.count
            end
        end
----------------------

    name_component_at (index : INTEGER) : STRING is

        require
            valid_index : 1 <= index and then index <= name_component_count

        do
            result := name_components.at (index)
        end
----------------------

    last_name_component : STRING is

        require
            has_components : name_component_count > 0

        do
            result := name_components.at (name_components.count)
        end
----------------------

    has_prefix (p : like current) : BOOLEAN is
        -- Is `p' a prefix of `current'?

        require
            nonvoid_arg : p /= void

        local
            i, n : INTEGER

        do
            n      := p.name_components.count
            result := (n <= name_components.count)
            from
                i := 1
            until
                not result or else i > n
            loop
                result := equal (name_components.at (i),
                                 p.name_components.at (i))
                i := i + 1
            end
        end
----------------------
feature -- Mutation

    set_initial_doublecolon  is

        do
            initial_doublecolon := true
        end
----------------------

    add_name_component (s : STRING) is

        do
            name_components.append (s)
        end
----------------------

    remove_last_name_component is

        require
            non_empty : name_component_count > 0

        do
            name_components.remove_at (name_components.count)
        end
----------------------

    to_string : STRING is

        local
            i, n : INTEGER

        do
            if initial_doublecolon then
                result := "::"
            else
                result := ""
            end
            from
                i := 1
                n := name_components.count
                if i <= n then
                    result.append (name_components.at (i))
                end
                if i < n then
                    result.append ("::")
                end
                i := i + 1
            until
                i > n
            loop
                result.append (name_components.at (i))
                if i < n then
                    result.append ("::")
                end
                i := i + 1
            end
        end
----------------------
feature -- Copying

    duplicate : like current is
        -- This was needed because a deep clone is too expensive

        local
            i, n : INTEGER

        do
            from
                create result.make
                i := 1
                n := name_components.count
            until
                i > n
            loop
                result.add_name_component (
                       clone (name_components.at (i)))
                i := i + 1
            end
        end
----------------------

    copy (other : like current) is

        do
            name_components.copy (other.name_components)
        end
----------------------
feature -- Equality test

    is_equal (other : like current) : BOOLEAN is

        do
            if name_components /= void then
                result := name_components.is_equal (other.name_components)
            else
                result := (other.name_components = void)
            end
        end
----------------------
feature -- Comparison

    infix "<" (other : like current) : BOOLEAN is
        -- This is more complicated than you would at first think.
        -- If the number of name components differs, the shorter one
        -- is the smaller one. Otherwise compare name components until
        -- you find a pair that differs. The smaller scoped name is
        -- the one with the smaller name component at the first position
        -- where they differ.

        local
            i, n   : INTEGER
            s1, s2 : STRING
            break  : BOOLEAN

        do
            if name_components.count = other.name_components.count then
                from
                    i := 1
                    n := name_components.count
                until
                    break or else i > n
                loop
                    s1 := name_components.at (i)
                    s2 := other.name_components.at (i)
                    if s1 < s2 then
                        result := true
                        break  := true
                    elseif s2 < s1 then
                        break  := true -- result = false
                    else -- name components agree so far
                        i := i + 1
                    end
                end -- loop
            else -- differing # components
                result := name_components.count <
                          other.name_components.count
            end -- if name_components.count ...
        end
----------------------
feature -- Hashing

    hash_code : INTEGER is

        local
            long : STRING
            i, n : INTEGER

        do
            from
                i    := 1
                n    := name_components.count
                long := clone (name_components.at (i))
                i    := i + 1
            until
                i > n
            loop
                long.append (name_components.at (i))
                i := i + 1
            end

            result := long.hash_code
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_scoped_name (current)
        end
----------------------
feature { SCOPED_NAME }

    name_components : INDEXED_LIST [STRING]

end -- class SCOPED_NAME

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
