indexing

description: "Keeps account of all symbols found";
keywords: "symbol table";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SYMBOL_TABLE

creation
    make

feature

    make is

        local
            sn : SCOPED_NAME

        do
            create current_table.make
            create lower_table.make
            create current_scope.make
            create registered_types.make
            create registered_scopes.make (true)
            create registered_modules.make
            create abstract_interfaces.make (false)
            create abstract_values.make (false)
            create all_interfaces.make (false)
            create all_values.make (false)
            create sn.make
            sn.add_name_component ("CORBA")
            sn.add_name_component ("TypeCode")
            registered_types.add (sn, "TypeCode")
            create sn.make
            sn.add_name_component ("Object")
            registered_types.add (sn, "Object")
                -- I find it hard to believe this suffices
                -- to fulfill the requirements of [3-34].
        end
----------------------

    reinitialize_current_scope (first_component : STRING) is

        do
            create current_scope.make
            current_scope.add_name_component (first_component)

        ensure
            are_at_top_level      : at_top_level
            right_first_component : equal (current_scope.name_component_at (1),
                                           first_component)
        end
----------------------

    register_module (m : MODULE) is
        -- Add `m' to record of known modules.
        -- If `m' is already registered, this has no effect.

        do
            if not registered_modules.has (m.name) then
                registered_modules.put (m, m.name)
            end
        end
----------------------

    lookup_module (name : SCOPED_NAME) is
        -- If there is a registered module with name `name'
        -- bind `found_module' to it; if not make `found_module' void.

        do
            if registered_modules.has (name) then
                found_module := registered_modules.at (name)
            else
                found_module := void
            end
        end
----------------------

    add_name (real_name : STRING) is

        local
            np : NAME_PAIR
            ln : STRING
            sn : SCOPED_NAME

        do
            create np.make (real_name)
            ln := clone (real_name)
            ln.to_lower
            sn := current_scope.duplicate
            sn.add_name_component (real_name)
            current_table.put (np, sn)            
            sn := current_scope.duplicate
            sn.add_name_component (ln)
            lower_table.put (np, sn)

        ensure
            name_is_now_known : name_is_known (real_name) and then
                                name_is_known_insensitive (real_name)
        end
----------------------

    remove_name (real_name : STRING) is
        -- Names in forward declarations should not conflict
        -- with the names in the actual declarations.

        local
            sn : SCOPED_NAME
            ln : STRING

        do
            ln := clone (real_name)
            ln.to_lower
            sn := current_scope.duplicate
            sn.add_name_component (real_name)
            current_table.remove (sn)
            sn := current_scope.duplicate
            sn.add_name_component (ln)
            lower_table.remove (sn)

        ensure
            name_is_now_unknown : not name_is_known (real_name) and then
                                  not name_is_known_insensitive (real_name)
        end
----------------------

    name_is_known (real_name : STRING) : BOOLEAN is

        local
            sn : SCOPED_NAME

        do
            sn := current_scope.duplicate
            sn.add_name_component (real_name)
            result := current_table.has (sn)
        end
----------------------

    name_is_known_insensitive (name: STRING) : BOOLEAN is
        -- Is `name' known if we ignore case?

        local
            ln : STRING
            sn : SCOPED_NAME

        do
            ln := clone (name)
            ln.to_lower
            sn := current_scope.duplicate
            sn.add_name_component (ln)
            result := lower_table.has (sn)
        end
----------------------

    name_is_known_outside_current_scope (real_name : STRING) : BOOLEAN is
        -- Needed by UNDEFINED_NAME_VISITOR where `current_scope' isn't
        -- likely to be relevant.

        local
            it : ITERATOR

        do
            from
                it := current_table.iterator
            until
                it.finished
            loop
                if equal (current_table.item (it).real_name, real_name) then
                    it.stop
                else
                    it.forth
                end
            end
            result := it.inside
        end
----------------------

    fullname_is_known_outside_current_scope (name : SCOPED_NAME) : BOOLEAN is
        -- Needed by UNDEFINED_NAME_VISITOR where `current_scope' isn't
        -- likely to be relevant.

        do
            result := current_table.has (name)
        end
----------------------

    real_name_match (real_name : STRING) : BOOLEAN is
        -- Does the real name stored for `real_name'
        -- agree with `real_name' case sensitively?

        require
            name_is_known_insensitive : name_is_known_insensitive (real_name)

        local
            sn : SCOPED_NAME
            ln : STRING

        do
            ln := clone (real_name)
            ln.to_lower
            sn := current_scope.duplicate
            sn.add_name_component (ln)
            result := equal (lower_table.at(sn).real_name, real_name)
        end
----------------------

    previous_spelling (real_name : STRING) : STRING is

        require
            name_is_known_insensitive : name_is_known_insensitive (real_name)

        local
            sn : SCOPED_NAME
            ln : STRING

        do
            ln := clone (real_name)
            ln.to_lower
            sn := current_scope.duplicate
            sn.add_name_component (ln)
            result := lower_table.at (sn).real_name
        end
----------------------

    descend (last_component : STRING) is
        -- Enter a new scope.

        do
            registered_scopes.add (current_scope.duplicate)
            current_scope.add_name_component (last_component)


        ensure
            right_last_component : equal (current_scope.last_name_component,
                                          last_component)
        end
----------------------

    at_top_level : BOOLEAN is

        do
            result := (current_scope.name_component_count < 1)
        end
----------------------

    ascend is
        -- Return to next higher scope.

        require
            not_at_top_level : not at_top_level

        do
            registered_scopes.add (current_scope.duplicate)
            current_scope.remove_last_name_component
        end
----------------------

    current_scope : SCOPED_NAME

----------------------

    type_is_visible (typename : STRING) : BOOLEAN is
        -- Is a type with simple name `typename' visible when looking
        -- upward from `current_scope'?

        require
            nonvoid_arg : typename /= void

        local
            i, n : INTEGER
            sn   : SCOPED_NAME
            tl   : INDEXED_LIST [SCOPED_NAME]

        do
            if registered_types.has (typename) then
                from
                    tl := registered_types.at (typename)
                    i  := tl.low_index
                    n  := tl.high_index
                until
                    result or else i > n
                loop
                    sn := tl.at (i).duplicate
                    sn.remove_last_name_component
                        -- take off simple name
                    result := scope_is_visible_from_here (sn)
                    if result then
                        found_type := tl.at (i).duplicate
                    end
                    i := i + 1
                end
            else
                -- We've never heard of this type
            end
        end
----------------------

    simpletype_is_visible (typename : STRING) : BOOLEAN is

        local
            sn : SCOPED_NAME

        do
            create sn.make
            sn.add_name_component (typename)
            result := fulltype_is_visible (sn)
        end
----------------------

    fulltype_is_visible (typename : SCOPED_NAME) : BOOLEAN is
        -- Is a type with full name `typename' visible when looking
        -- upward from `current_scope'?

        require
            nonvoid_arg : typename /= void

        local
            i, n : INTEGER
            sn   : SCOPED_NAME
            simp : STRING
            tl   : INDEXED_LIST [SCOPED_NAME]

        do
            simp := typename.last_name_component
            sn   := typename.duplicate
            sn.remove_last_name_component
            if registered_types.has (simp) then
                from
                    tl := registered_types.at (simp)
                    i  := tl.low_index
                    n  := tl.high_index
                until
                    result or else i > n
                loop
                    result := equal (typename, tl.at (i)) and then
                              scope_is_visible_from_here (sn)
                    if result then
                        found_type := typename.duplicate
                    end
                    i := i + 1
                end
            else
                -- We've never heard of this type
            end
        end
----------------------

    simple_name_to_full_type (simple_name : STRING) : SCOPED_NAME is
        -- Fully qualified name of type with simple name `simple_name'.

        require
            type_is_visible : type_is_visible (simple_name)

        do
            result := found_type
        end
----------------------

    register_type (simple_name : STRING) : SCOPED_NAME is
        -- Register type with simple name `simple_name' at current
        -- scope and return its full scoped_name.

        require
            nonvoid_arg : simple_name /= void

        do
            result := current_scope.duplicate
            result.add_name_component (simple_name)
            registered_types.add (result, simple_name)
            add_name (simple_name)
        end
----------------------

    is_a_value (vname : SCOPED_NAME) : BOOLEAN is

        do
            all_values.search (vname)
            result := all_values.found
        end
----------------------

    is_an_interface (iname : SCOPED_NAME) : BOOLEAN is

        do
            all_interfaces.search (iname)
            result := all_interfaces.found
        end
----------------------

    interface_is_abstract (iname : SCOPED_NAME) : BOOLEAN is

        do
            abstract_interfaces.search (iname)
            result := abstract_interfaces.found
        end
----------------------

    value_is_abstract (vname : SCOPED_NAME) : BOOLEAN is

        do
            abstract_values.search (vname)
            result := abstract_values.found
        end
----------------------

    register_value (vname : SCOPED_NAME; abstract : BOOLEAN) is

        do
            all_values.add (vname)
            if abstract then
                abstract_values.add (vname)
            end
        end
----------------------

    register_interface (iname : SCOPED_NAME; abstract : BOOLEAN) is

        do
            all_interfaces.add (iname)
            if abstract then
                abstract_interfaces.add (iname)
            end
        end
----------------------
feature { EXTENDED_SYNTAX_PARSER }

    found_module : MODULE
        -- Module found by last call to `lookup_module'.
----------------------
feature { NONE }

    current_table : DICTIONARY [NAME_PAIR, SCOPED_NAME]
        -- Originalspelling used as last component of key.
    lower_table : DICTIONARY [NAME_PAIR, SCOPED_NAME]
        -- Lower case version used as last component of key.
    found_type : SCOPED_NAME
        -- Type found by `type_is_visible'. Remember it for
        -- reasons of efficiency.
    registered_scopes : SORTED_LIST [SCOPED_NAME]
        -- The scopes we've been through.
    registered_types : INDEXED_CATALOG [SCOPED_NAME, STRING]
        -- The key is the simple name of the type and the item
        -- is the full scoped name of the type.
    registered_modules : DICTIONARY [MODULE, SCOPED_NAME]
        -- All modules parsed so far
    abstract_interfaces : SORTED_LIST [SCOPED_NAME]
        -- List of all abstract interfaces seen so far.
    abstract_values : SORTED_LIST [SCOPED_NAME]
        -- List of all abstract valuetypes seen so far.
    all_interfaces : SORTED_LIST [SCOPED_NAME]
        -- All interfaces (abstract or concrete)
    all_values : SORTED_LIST [SCOPED_NAME]
        -- All valuetypes (abstract or concrete)
----------------------

    scope_is_visible_from_here (sn : SCOPED_NAME) : BOOLEAN is
        -- is the scope described by `sn' visible from `current_scope'?

        require
            nonvoid_arg : sn /= void

        local
            sn1  : SCOPED_NAME

        do
            from
                sn1 := sn.duplicate
                if sn1.name_component_count = 0 then
                    result := true
                else
                    registered_scopes.search (sn1)
                    result := registered_scopes.found
                end
            until
                result
            loop
                sn1.remove_last_name_component
                if sn1.name_component_count = 0 then
                    result := true
                else
                    registered_scopes.search (sn1)
                    result := registered_scopes.found
                end
            end
        end

end -- class SYMBOL_TABLE

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
