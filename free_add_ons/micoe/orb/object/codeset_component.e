indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_COMPONENT

inherit
    CODESET_STATICS
        undefine
            copy, is_equal
        end;
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    CORBA_COMPONENT
        undefine
            copy, is_equal
        end;
    MICO_COMPARABLE
        redefine
            copy, is_equal
        end


creation
    make, make4

feature -- Initialization

    make is

        do
            my_native_cs    := 0
            my_native_wcs   := 0
            selected_cs     := 0
            selected_wcs    := 0
            create conv_cs.make (false)
            create conv_wcs.make (false)
        end
----------------------

    make4 (native_c, native_wc : INTEGER;
          conv_c, conv_wc : INDEXED_LIST [INTEGER]) is

        do
            my_native_cs    := native_c
            my_native_wcs   := native_wc
            conv_cs      := conv_c
            conv_wcs     := conv_wc
            selected_cs  := 0
            selected_wcs := 0
            if conv_cs = void then
                create conv_cs.make (false)
            end
            if conv_wcs = void then
                create conv_wcs.make (false)
            end
        end
----------------------
feature -- Access

    id : INTEGER is

        do
            result := Tag_code_sets
        end
----------------------

    get_selected_cs : INTEGER is

        local
            cl_nat : INTEGER
                -- Native code set on client.
            sv_nat : INTEGER
                -- Native code set on server.
            i, n   : INTEGER
            return : BOOLEAN

        do
            if selected_cs /= 0 then
                result := selected_cs
            else
                cl_nat := special_cs (Native_cs).id
                sv_nat := native_cs

                -- The following is a workaround for a bug in VB,
                -- which specifies a native codeset 0 and no
                -- conversion code sets
                if native_cs = 0 and then conv_cs.count = 0 then
                    sv_nat := special_cs (Default_cs).id
                end

                -- same native code sets?
                if sv_nat = cl_nat then
                    selected_cs := sv_nat
                    result      := selected_cs
                    return      := true
                end

                if not return then
                    -- can client convert its native code set to
                    -- server's native code set?
                    if can_convert (cl_nat, sv_nat) then
                        selected_cs := sv_nat
                        result      := selected_cs
                        return      := true
                    end
                end -- if not return then ...

                if not return then
                    -- can server convert client's native code set
                    -- to its native code set?
                    from
                        i := conv_cs.low_index
                        n := conv_cs.high_index
                    until
                        return or else i > n
                    loop
                        if cl_nat = conv_cs.at (i) then
                            selected_cs := cl_nat
                            result      := selected_cs
                            return      := true
                        end
                        i := i + 1
                    end
                end -- if not return then ...

                if not return then
                    -- is there an intermediate code set both client
                    -- and server can convert their native code sets
                    -- to? Is so, favor the preference of the server.
                    from
                        i := conv_cs.low_index
                        n := conv_cs.high_index
                    until
                        return or else i > n
                    loop
                        if can_convert (cl_nat, conv_cs.at (i)) then
                            selected_cs := conv_cs.at (i)
                            result      := selected_cs
                            return      := true
                        end
                        i := i + 1
                    end
                end -- if not return then ...

                if not return then
                    -- use fallback code set
                    selected_cs := special_cs (Fallback_cs).id
                    result      := selected_cs
                end -- if not return then ...
            end
        end
----------------------

    get_selected_wcs : INTEGER is

        local
            cl_nat : INTEGER
                -- Native code set on client.
            sv_nat : INTEGER
                -- Native code set on server.
            i, n   : INTEGER
            return : BOOLEAN

        do
            if selected_wcs /= 0 then
                result := selected_wcs
            else
                cl_nat := special_cs (Native_wcs).id
                sv_nat := native_wcs

                -- The following is a workaround for a bug in VB,
                -- which specifies a native codeset 0 and no
                -- conversion code sets
                if native_wcs = 0 and then conv_wcs.count = 0 then
                    sv_nat := special_cs (Default_wcs).id
                end

                -- same native code sets?
                if sv_nat = cl_nat then
                    selected_wcs := sv_nat
                    result       := selected_wcs
                    return       := true
                end

                if not return then
                    -- can client convert its native code set to
                    -- server's native code set?
                    if can_convert (cl_nat, sv_nat) then
                        selected_wcs := sv_nat
                        result       := selected_wcs
                        return       := true
                    end
                end -- if not return then ...

                if not return then
                    -- can server convert client's native code set to
                    -- its native code set?
                        from
                            i := conv_wcs.low_index
                            n := conv_wcs.high_index
                        until
                            return or else i > n
                        loop
                            if cl_nat = conv_wcs.at (i) then
                                selected_wcs := cl_nat
                                result       := selected_wcs
                                return       := true
                            end
                            i := i + 1
                        end -- loop
                end -- if not return then ...

                if not return then
                    -- is there an intermediate code set both client
                    -- and server can convert their native code sets
                    -- to? Is so, favor the preference of the server.
                    from
                        i := conv_cs.low_index
                        n := conv_cs.high_index
                    until
                        return or else i > n
                    loop
                        if can_convert (cl_nat, conv_wcs.at (i)) then
                            selected_wcs := conv_wcs.at (i)
                            result       := selected_wcs
                            return       := true
                        end -- if can_convert ...
                        i := i + 1
                    end -- loop
                end -- if not return then ...

                if not return then
                    -- use fallback code set
                    selected_wcs := special_cs (Fallback_wcs).id
                    result       := selected_wcs
                end -- if not return then ...
            end -- if selected_wcs /= 0 then ...
        end
----------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        local
            i, n : INTEGER

        do
            -- CodesetComponentInfo
            ec.struct_begin
            -- ForCharData
            ec.struct_begin
            -- native_code_set
            ec.put_ulong (my_native_cs)
            -- conversion_code_sets
            ec.seq_begin (conv_cs.count)
            if conv_cs.count > 0 then
                from
                    i := conv_cs.low_index
                    n := conv_cs.high_index
                until
                    i > n
                loop
                    ec.put_ulong (conv_cs.at (i))
                    i := i + 1
                end -- loop
            end -- if conv_cs.count > 0 then ...
            ec.seq_end
            ec.struct_end

            -- ForWcharData
            ec.struct_begin
            -- native_code_set
            ec.put_ulong (my_native_wcs)
            -- conversion_code_sets
            ec.seq_begin (conv_wcs.count)
            if conv_wcs.count > 0 then
                from
                    i := conv_wcs.low_index
                    n := conv_wcs.high_index
                until
                    i > n
                loop
                    ec.put_ulong (conv_wcs.at (i))
                    i := i + 1
                end -- loop
            end -- if conv_wcs.count > 0 then ...
            ec.seq_end
            ec.struct_end
            ec.struct_end
        end
----------------------
feature -- Miscellaneous

    print_it is

        local
            nci  : CODESET_INFO
            nwi  : CODESET_INFO
            s    : STRING
            p    : POINTER
            i, n : INTEGER

        do
            nci := find_codeset_info_by_id (my_native_cs)
            nwi := find_codeset_info_by_id (my_native_wcs)

            io.put_string ("Native Codesets:%N")
            io.put_string ("              normal: ")
            if nci /= void then
                io.put_string (nci.desc)
                io.new_line
            else
                s := ""
                p := mico_to_hex (my_native_cs)
                s.from_c (p)
                io.put_string (s)
                mico_free_charbuf
                io.new_line
            end

            io.put_string ("                wide: ")
            if nwi /= void then
                io.put_string (nwi.desc)
                io.new_line
            else
                s := ""
                p := mico_to_hex (my_native_wcs)
                s.from_c (p)
                mico_free_charbuf
                io.put_string (s)
                io.new_line
            end

            if conv_cs.count > 0 then
                io.put_string ("              Other Codesets:%N")
                from
                    i := conv_cs.low_index
                    n := conv_cs.high_index
                until
                    i > n
                loop
                    nci := find_codeset_info_by_id (conv_cs.at (i))
                    io.put_string ("                      ")
                    if nci /= void then
                        io.put_string (nci.desc)
                        io.new_line
                    else
                        s := ""
                        p := mico_to_hex (my_native_cs)
                        s.from_c (p)
                        mico_free_charbuf
                        io.put_string (s)
                        io.new_line
                    end                    
                    i := i + 1
                end
            end -- if conv_cs.count > 0 the ...
            if conv_wcs.count > 0 then
                io.put_string ("              Other Wide Codesets:%N")
                from
                    i := conv_wcs.low_index
                    n := conv_wcs.high_index
                until
                    i > n
                loop
                    nwi := find_codeset_info_by_id (conv_wcs.at (i))
                    io.put_string ("                      ")
                    if nwi /= void then
                        io.put_string (nwi.desc)
                        io.new_line
                    else
                        s := ""
                        p := mico_to_hex (my_native_wcs)
                        s.from_c (p)
                        mico_free_charbuf
                        io.put_string (s)
                        io.new_line
                    end                    
                    i := i + 1
                end
            end -- if conv_wcs.count > 0 the ...

        end
----------------------
feature -- Copying

    copy (other : like current) is

       do
            my_native_cs  := other.my_native_cs
            my_native_wcs := other.my_native_wcs
            conv_cs       := clone (other.conv_cs)
            conv_wcs      := clone (other.conv_wcs)
            selected_cs   := other.selected_cs
            selected_wcs  := other.selected_wcs
       end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
           result := (my_native_cs  = other.my_native_cs  and then
                      my_native_wcs = other.my_native_wcs and then
                      equal (conv_cs, other.conv_cs)      and then
                      equal (conv_wcs, other.conv_wcs)    and then
                      selected_cs = other.selected_cs     and then
                      selected_wcs = other.selected_wcs)
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        do
            result := id - other.id
            if result /=0 then
                result := my_native_cs - other.my_native_cs
            end
            if result /= 0 then
                result := my_native_wcs - other.my_native_wcs
            end    
            if result /= 0 then
                result := vec_compare (conv_cs, other.conv_cs)
            end
            if result /= 0 then
                result := vec_compare (conv_wcs, other.conv_wcs)
            end
        end
----------------------
feature { CODESET_COMPONENT } -- Implementation

    my_native_cs  : INTEGER
    my_native_wcs : INTEGER
    selected_cs   : INTEGER
    selected_wcs  : INTEGER
    conv_cs       : INDEXED_LIST [INTEGER]
    conv_wcs      : INDEXED_LIST [INTEGER]
----------------------

    vec_compare (vec1, vec2 : INDEXED_LIST [INTEGER]) : INTEGER is

        local
            i, n : INTEGER

        do
            result := vec1.count - vec2.count

            from
                i := 1
            until
                result /= 0 or else i > n
            loop
                result := vec1.at (i) - vec2.at (i)
                i      := i + 1
            end
        end
----------------------

    mico_to_hex (n : INTEGER) : POINTER is
        -- Convert a byte `n' into a string of
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

end -- class CODESET_COMPONENT

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
