indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_CONTEXT

inherit
    THE_FLAGS;
    TYPECODE_STATICS

creation
    make, make_with_decoder,
    make_with_name, make_with_name_and_parent


feature -- Initializtion

    make is

        do
            make_with_name_and_parent ("", void)
        end
----------------------

    make_with_name (the_name : STRING) is

        do
            make_with_name_and_parent (the_name, void)
        end
----------------------

    make_with_name_and_parent (the_name : STRING;
                               the_parent : CORBA_CONTEXT) is

        do
            myparent := the_parent
            name     := the_name
            create properties.make
        end
----------------------

    make_with_decoder (dc : DATA_DECODER) is

        do
            decode (dc)
        end
----------------------
feature -- Access

    context_name : STRING is

        do
            result := name
        end
----------------------

    parent : CORBA_CONTEXT is

        do
            result := myparent
        end
----------------------

    get_values_pat (scope   : STRING;
                    f       : FLAGS;
                    pattern : STRING)  : CORBA_NV_LIST is

        require
            nonvoid_args : scope /= void and then
                           f     /= void

        local
            patterns : INDEXED_LIST [STRING]

        do
            create patterns.make (false)
            patterns.append (pattern)
            result := get_values_cl (scope, f, patterns)
        end
----------------------

    get_values_cl (scope    : STRING;
                   f        : FLAGS;
                   patterns : INDEXED_LIST [STRING]) : CORBA_NV_LIST is

        require
            nonvoid_arg : scope    /= void
                          f        /= void and then
                          patterns /= void

        local
            done : BOOLEAN
            i, n : INTEGER
            k, m : INTEGER
            j, p : INTEGER
            stop : BOOLEAN
            nv   : CORBA_NAMED_VALUE
            dum  : CORBA_NAMED_VALUE

        do
            if (scope /= void        and then
                scope.count > 0      and then
                not equal (name, scope)) then
                check
                    nonvoid_parent : myparent /= void
                end
                result := myparent.get_values_cl (scope, f, patterns)
                done   := true
            elseif (f & flags.Ctx_restrict_scope) = flags.Zero_flag
                   and then myparent /= void then
                result := myparent.get_values_cl ("", f, patterns)
            else
                create result.make
            end
            if not done then
                from
                    i := 1
                    n := properties.count
                until
                    i > n
                loop
                    nv := properties.item (i)
                    i  := i + 1
                    from
                        k := patterns.low_index
                        m := patterns.high_index
                    until
                        k < m
                    loop
                        if match (nv.name, patterns.at (k)) then
                            from
                                stop := false
                                j    := 1
                                p    := result.count
                            until
                                j > p
                            loop
                                if equal (nv.name, result.item (j).name) then
                                    result.item (j).set_value (nv.value)
                                    stop := true
                                end -- if equal (nv.name ...
                                j := j + 1
                            end -- tightest loop over j
                            if not stop then
                                dum := result.add_value (nv.name, nv.value,
                                                         nv.my_flags)
                            end -- if not stop then ...
                        end -- if match ...
                        k := k + 1
                    end -- inner loop over k
                end -- outer loop over i
            end
        end
----------------------
feature -- Child creation

    create_child (nm : STRING) : CORBA_CONTEXT is

        do
            create result.make_with_name_and_parent (nm, current)
            children.append (result)
        end
----------------------
feature -- Mutation

    set_one_value (nm : STRING; val : CORBA_ANY) is

        local
            tc   : CORBA_TYPECODE
            nv   : CORBA_NAMED_VALUE
            i, n : INTEGER
            done : BOOLEAN

        do
            tc := val.get_typecode
            check
                isa_string : tc.unalias.kind = Tk_string
            end
            from
                i := 1
                n := properties.count
            until
                i > n or else done
            loop
                nv := properties.item (i)
                i  := i + 1
                if equal (nm, nv.name) then
                    nv.set_value (val)
                    done := true
                end
            end
            if not done then
                nv := properties.add_value (nm, val, void)
            end
        end
----------------------

    set_values (nvlist : CORBA_NV_LIST) is

        local
            i, n : INTEGER
            nv   : CORBA_NAMED_VALUE

        do
            from
                i := 1
                n := nvlist.count
            until
                i > n
            loop
                nv := nvlist.item (i)
                i  := i + 1
                set_one_value (nv.name, nv.value)
            end
        end
----------------------

    delete_values (pattern : STRING) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := properties.count
            until
                i > n
            loop
                if match (properties.item (i).name, pattern) then
                    properties.remove (i)
                    n := properties.count
                end
                i := i + 1
            end
        end
----------------------
feature -- Encoding and Decoding

    encode1 (ec : DATA_ENCODER) is

        do
            encode2 (ec, void)
        end
----------------------

    encode2 (ec : DATA_ENCODER; clist : INDEXED_LIST [STRING]) is

        require
            nonvoid_args : ec    /= void and then
                           clist /= void

        local
            f    : FLAGS
            outl : CORBA_NV_LIST
            nv   : CORBA_NAMED_VALUE
            i, n : INTEGER

        do
            create f.make (0, 32)
            if clist /= void then
                outl := get_values_cl ("", f, clist)
            else
                outl := get_values_pat ("", f, "*")
            end
            ec.seq_begin (2 * outl.count)
            from
                i := 1
                n := outl.count
            until
                i > n
            loop
                nv := outl.item (i)
                i  := i + 1
                ec.put_string (nv.name)
                nv.value.marshal (ec)
            end
            ec.seq_end
        end
----------------------

    decode (dc : DATA_DECODER) is

        local
            len : INTEGER
            i   : INTEGER
            s   : STRING
            a   : CORBA_ANY
            r   : BOOLEAN

        do
            -- delete existing properties but not child contexts
            properties.make

            len := dc.seq_begin
            check
                even_length : (len \\ 2) = 0
            end
            if (len \\ 2) = 2 then
                from
                    create a.make
                    i := 0
                until
                    i >= len
                loop
                    s := dc.get_string
                    check
                        nonvoid_name : s /= void
                    end
                    r :=  a.demarshal (Tc_string, dc)
                    check
                        demarshal_ok : r
                    end
                    set_one_value (s, a)
                    i := i + 2
                end
            end -- if (len \\ 2) = 0 then ...
            dc.seq_end
        end
----------------------
feature { CORBA_CONTEXT} -- Implementation

    myparent   : CORBA_CONTEXT
    children   : INDEXED_LIST [CORBA_CONTEXT]
    properties : CORBA_NV_LIST
    name       : STRING
----------------------

    match (value, pattern : STRING) : BOOLEAN is

        do
            if pattern.item (pattern.count) = '*' then
                result := equal (value,
                                 pattern.substring (1, pattern.count - 1))
            else
                result := equal (value, pattern)
            end
        end

end -- class CORBA_CONTEXT

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
