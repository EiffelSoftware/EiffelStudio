indexing

description: "Represents a basic object reference in the OMA.";
keywords: "object reference";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_OBJECT

inherit
    ORB_STATICS
        undefine
            copy, is_equal
        end;
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    HASHABLE
        redefine
            copy, is_equal
        end

creation
    make, make_with_ior

feature -- Initialization

    make is

        local
            theo : THE_ORB

        do
            create theo.make (0, void, "")
            orb := theo.ORB_instance
            ior := clone (orb.ior_template)
        end
----------------------

    make_with_ior (i : IOR) is

        local
            theo : THE_ORB

        do
            create theo.make (0, void, "")
            ior := i
            orb := theo.ORB_instance
        end
----------------------
feature -- The official interface

    create_request (ctx        : CORBA_CONTEXT;
                    operation  : STRING;
                    arg_list   : CORBA_NV_LIST;
                    inv_result : CORBA_NAMED_VALUE) : CORBA_REQUEST is
        -- An object representing an invocation of the method
        -- `operation' on `current' with actual arguments `arg_list'.
        -- Upon return the result can be found in `inv_result' if
        --`operation' represents a function.

        do
            create result.make5 (current, ctx, operation,
                            arg_list, inv_result)
        end
----------------------

    is_a (type_id : STRING) : BOOLEAN is
        -- `type_id' is the identifier used by the interface repository.

        do
            -- check some trivial cases first
            if equal (type_id, "IDL:omg.org/CORBA/Object:1.0") then
                result := true
            elseif equal (type_id, repoid) then
                result := true
            else
                result := is_a_remote (type_id)
            end
        end
----------------------

    non_existent : BOOLEAN is
        -- Has the servant `current' refers to been deleted?

        do
            result := orbnc.non_existent (current)
        end
----------------------

    is_equivalent (o : CORBA_OBJECT) : BOOLEAN is
        -- Do `current' and `o' refer to the same servant?

        do
            result := equal (get_ior, o.get_ior)
        end
----------------------

    hash_code : INTEGER is

        local
            s : STRING

        do
            s := ior.objid
            if s = void then
                s := ior.stringify
            end
            result := s.hash_code
        end
----------------------

    get_interface : CORBA_INTERFACEDEF is

        do
            result := orbnc.get_iface (current)
        end
----------------------
feature -- The rest is the MICO interface

    get_implementation : IMPLEMENTATION_DEFINITION is

        do
            result := orbnc.get_impl (current)
        end
----------------------
feature -- Requests

    create_request5 (ctx       : CORBA_CONTEXT;
                     op        : STRING;
                     args      : CORBA_NV_LIST;
                     reslt     : CORBA_NAMED_VALUE;
                     req_flags : FLAGS) : CORBA_REQUEST is

        do
            create result.make5 (current, ctx, op, args, reslt)
        end
----------------------

    create_request7 (ctx       : CORBA_CONTEXT;
                     op        : STRING;
                     args      : CORBA_NV_LIST;
                     rslt      : CORBA_NAMED_VALUE;
                     elist     : INDEXED_LIST [CORBA_TYPECODE];
                     clist     : INDEXED_LIST [STRING];
                     req_flags : FLAGS) : CORBA_REQUEST is

        do
            create result.make7 (current, ctx, op, args,
                            rslt, elist, clist)
        end
----------------------

    request (op : STRING) : CORBA_REQUEST is

        do
            create result.make2 (current, op)
        end
----------------------
feature -- Access

    orbnc : ORB is

        do
            result := orb
        end
----------------------

    get_ior : IOR is

        do
            result := ior

        ensure
            nonvoid_result : result /= void
        end
----------------------

    repoid : STRING is

        do
            result := get_ior.get_repoid
        end
----------------------

    tag : ARRAY [INTEGER] is
        -- Tag stored in the ior, that uniquely identifies
        -- `current' among all objects having same profile.

        local
            prof : IOR_PROFILE
            l    : INTEGER_REF

        do
            prof := ior.profile
            create l
            result := prof.get_objectkey (l)
        end
----------------------

    class_name : STRING is
        -- Name of type of object; this information is
        -- buried in the repoid.

        local
            rep         : STRING
            first, last : INTEGER

        do
            result := "unknown"
            rep    := repoid
            if rep /= void then
                last := reverse_index_of (rep, ':', rep.count)
                if last > 0 then
                    first := reverse_index_of (rep, '/', last - 1)
                    if first = 0 then
                        first := reverse_index_of (rep, ':', last - 1)
                    end
                    if first >= 1 then
                        result := rep.substring (first + 1, last - 1)
                    end
                end
            end
        end
----------------------

    get_ident : STRING is

        local
            key  : ARRAY [INTEGER]
            i, n : INTEGER
            s    : STRING
            p    : POINTER

        do
            if ident = void or else ident.count = 0 then
                key    := tag
                ident  := ""
                from
                    i := key.lower
                    n := key.upper
                until
                    i > n
                loop
                    s := ""
                    p := mico_to_hex (key.item (i))
                    check
                        got_hex : p /= Default_pointer
                    end
                    s.from_c (p)
                    mico_free_charbuf                 
                    ident.append (s)
                    i := i + 1
                end
            end -- if ident = void or else ident.count = 0 then ...
            result := ident
        end
----------------------

    is_a_remote (type_id : STRING) : BOOLEAN is

        do
            if not orbnc.is_impl (current) then
                result := orbnc.is_a (current, type_id)
            end
        end
----------------------

    simplified_is_a_remote (type_id : STRING) : BOOLEAN is
        -- Is `current' an object reference to a servant in
        -- this process? Questions about subtyping are not
        -- asked for reasons of efficiency.

        do
            -- only ask if we are a stub or an object implementation
            result := (not am_a_stub and then not orbnc.is_impl (current))
        end
----------------------

    is_a_stub : BOOLEAN is

        do
            result := am_a_stub
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            ior := clone (other.ior)
            orb := clone (other.orb)
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is
        -- We assume two objects with equal IORs refer to
        -- the same implementation object.

        do
            result := equal (ior, other.ior)
        end
----------------------
feature { CORBA_OBJECT } -- Implementation

    ior       : IOR
    orb       : ORB
    ident     : STRING
    am_a_stub : BOOLEAN
----------------------

    reverse_index_of (str : STRING;
                      ch : CHARACTER;
                      begin : INTEGER) : INTEGER is
        -- Index of first occurence of `ch' in `str' when searching
        -- backwards from `begin'. 0 if `ch' not found.
        -- NOTE: the ISE class STRING could have had such a function
        -- but despite BM's "supermarket principle" it does not.

        require
            nonvoid_arg : str /= void
            in_range    : begin <= str.count

        local

        do
            from
                result := begin
            until
                result <= 0 or else
                str.item (result) = ch
            loop
                result := result - 1
            end
        end
----------------------

    mico_to_hex (n : INTEGER) : POINTER is
        -- Convert a byte `n' into a pointer to a C-string of
        -- length 2 with two hex digits.

        require
            is_a_byte : 0 <= n and then n <= 15

        external "C"
        alias "MICO_to_hex"

        end
----------------------

    mico_free_charbuf is
        -- To prevent memory leaks.

        external "C"
        alias "MICO_free_charbuf"

        end

end -- class CORBA_OBJECT

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
