indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNICODESET_CONVERTER

inherit
    CODESET_CONVERTER
        redefine
            encode, encode_and_terminate, decode, decode_and_terminate
        end

creation { CODESET_STATICS}
    make2

---------------------------------
feature -- Encoding and Decoding

    encode (from_data : ARRAY [INTEGER]; len : INTEGER;
            ec : DATA_ENCODER) : INTEGER is

        local
            f, t    : ARRAY [INTEGER]
            i, j    : INTEGER
            n       : INTEGER
            flen    : INTEGER
            tlen    : INTEGER
            written : INTEGER

        do
            flen := from_cs.codepoint_size
            if flen = 3 then
                flen := 4 -- alignment ...
            end
            if from_data.item (len) = 0 then
                n := len - 1
            else
                n := len
            end

            flen := n * flen
            create f.make (1, flen)

            inspect from_cs.codepoint_size

            when 1 then
                from
                    i := 1
                    j := from_data.lower
                until
                    i > flen or else j > from_data.upper
                loop
                    f.put (from_data.item (j), i)
                    i := i + 1
                    j := j + 1
                end

                check
                    got_all_data1 : j <= from_data.upper implies
                                    from_data.item (j) = 0
                end

            when 2 then
                from
                    i := 1
                    j := from_data.lower
                until
                    i > flen or else j > from_data.upper
                loop
                    f.put (get_ushort (from_data, j), i)
                    i := i + 1
                    j := j + 2
                end

                check
                    got_all_data2 : j <= from_data.upper - 1 implies
                                    get_ushort (from_data, j) = 0
                end

            when 3, 4 then
                -- XXX this is bound to go wrong if codepoint_size = 4
                -- and the platform is 32 bit, since then Eiffel
                -- INTEGERs are _signed_ long ...
                from
                    i   := 1
                    j   := from_data.lower
                until
                    i > flen or else j > from_data.upper
                loop
                    f.put (get_ulong (from_data, j), i)
                    i := i + 1
                    j := j + 4
                end -- loop over i and j

                check
                    got_all_data3_4 : j <= from_data.upper - 3 implies
                                      get_ulong (from_data, j) = 0
                end

            else
                logger.log (logger.Log_err, "General", "UNICODESET_CONVERTER",
                            "encode").put_string ("trying to encode with %
                            %nonsupported codepoint size%N")
                check
                    supported_codepoint_size1 : false
                end
            end

            tlen := to_cs.codepoint_size
            if tlen = 3 then
                tlen := 4 -- alignment ...
            end 
            tlen := len * to_cs.codepoint_size
            create t.make (1, tlen)
            written := convert (f, t, flen)

            written := written - 1
                -- forget the terminating 0.

            check
                not_too_much_data2 : written <= t.count
            end

            if written > 0 then
                inspect to_cs.codepoint_size

                when 1 then
                    from
                        i := 1
                    until
                        i > written
                    loop
                        ec.get_buffer.put1 (t.item (i))
                            -- Can't use (unsigned) octets, since
                            -- after conversion some elements (of `t')
                            -- might be negative.
                        i := i + 1
                    end

                when 2 then
                    from
                        i := 1
                    until
                        i > written
                    loop
                        ec.put_ushort (t.item (i))
                        i := i + 1
                    end

                when 3, 4 then
                    from
                        i := 1
                    until
                        i > written
                    loop
                        ec.put_ulong (t.item (i))
                        i := i + 1
                    end

                else
                    logger.log (logger.Log_err, "General", "UNICODESET_CONVERTER",
                                "encode").put_string ("trying to encode with %
                                %nonsupported codepoint size%N")
                    check
                        supported_codepoint_size2 : false
                    end
                end
            end -- if written > 0 then ...

            result := written
        end
---------------------------------

    encode_and_terminate (from_data : ARRAY [INTEGER]; len : INTEGER;
                          ec : DATA_ENCODER) : INTEGER is

        local
            f, t    : ARRAY [INTEGER]
            i, j    : INTEGER
            flen    : INTEGER
            tlen    : INTEGER
            written : INTEGER
            log     : IO_MEDIUM

        do
            flen := from_cs.codepoint_size
            if flen = 3 then
                flen := 4 -- alignment ...
            end
            flen := len * flen
             create f.make (1, flen)
            inspect from_cs.codepoint_size

            when 1 then
                from
                    i := 1
                    j := from_data.lower
                until
                    i > flen or else j > from_data.upper
                loop
                    f.put (from_data.item (j), i)
                    i := i + 1
                    j := j + 1
                end

            when 2 then
                from
                    i := 1
                    j := from_data.lower
                until
                    i > flen
                loop
                    f.put (get_ushort (from_data, j), i)
                    i := i + 1
                    j := j + 2
                end

            when 3, 4 then
                -- XXX this is bound to go wrong if codepoint_size = 4
                -- and the platform is 32 bit, since then Eiffel
                -- INTEGERs are signed long ...
                from
                    i   := 1
                    j   := from_data.lower
                until
                    i > flen
                loop
                    f.put (get_ulong (from_data, j), i)
                    i := i + 1
                    j := j + 4
                end -- loop over i and j

            else
                log := logger.log (logger.Log_err, "General",
                                   "UNICODESET_CONVERTER",
                                   "encode_and_terminate")
                log.put_string ("trying to encode with nonsupported codepoint size ")
                log.putint (from_cs.codepoint_size)
                log.new_line
                check
                    supported_codepoint_size1 : false
                end
            end

            tlen := to_cs.codepoint_size
            if tlen = 3 then
                tlen := 4 -- alignment ...
            end 
            tlen := len * to_cs.codepoint_size
            create t.make (1, tlen)
            written := convert (f, t, flen)

             -- this time we don't forget the terminating 0.

            if written > 0 then
                inspect to_cs.codepoint_size

                when 1 then
                    from
                        i := 1
                    until
                        i > written
                    loop
                        ec.get_buffer.put1 (t.item (i))
                            -- Can't use (unsigned) octets, since
                            -- after conversion some elements (of `t')
                            -- might be negative.
                        i := i + 1
                    end

                when 2 then
                    from
                        i := 1
                    until
                        i > written
                    loop
                        ec.put_ushort (t.item (i))
                        i := i + 1
                    end

                when 3, 4 then
                    from
                        i := 1
                    until
                        i > written
                    loop
                        ec.put_ulong (t.item (i))
                        i := i + 1
                    end

                else
                    log := logger.log (logger.Log_err, "General",
                                       "UNICODESET_CONVERTER",
                                       "encode_and_terminate")
                    log.put_string ("trying to encode with nonsupported codepoint size ")
                    log.putint (to_cs.codepoint_size)
                    log.new_line
                    check
                        supported_codepoint_size2 : false
                    end
                end
            end -- if written > 0 then ...

            result := written
        end
---------------------------------

    decode (dc : DATA_DECODER;
            to_data : ARRAY [INTEGER];
            len : INTEGER) : INTEGER is

        -- `to_data' is where the decoded data is to be put. The caller
        -- should have dimensioned `to_data' correctly; if `to_data' is
        -- too small some of the decoded data will be missing. `len' is
        -- the length of the data in `dc's buffer that is to be decoded.

        local
            f, t    : ARRAY [INTEGER]
            flen    : INTEGER
            tlen    : INTEGER
            i, j    : INTEGER
            ir      : INTEGER_REF
            written : INTEGER
            log     : IO_MEDIUM

        do
            flen := from_cs.codepoint_size
            if flen = 3 then
                flen := 4 -- alignment ...
            end
            flen := len * flen

            create f.make (1, flen)
            inspect from_cs.codepoint_size

            when 1 then
                from
                    i := 1
                until
                    i > flen
                loop
                    f.put (dc.get_octet.value, i)
                    i := i + 1
                end

            when 2 then
                from
                    create ir
                    i := 1
                until
                    i > flen
                loop
                    dc.get_ushort (ir)
                    f.put (ir.item, i)
                    i := i + 1
                end

            when 3, 4 then
                from
                    create ir
                    i := 1
                until
                    i > flen
                loop
                    dc.get_ulong (ir)
                    f.put (ir.item, i)
                    i := i + 1
                end

            else
                log := logger.log (logger.Log_err, "General",
                                   "UNICODESET_CONVERTER",
                                   "decode")
                log.put_string ("trying to decode with nonsupported codepoint size ")
                log.putint (from_cs.codepoint_size)
                log.new_line
                check
                    supported_codepoint_size1 : false
                end
            end

            tlen := to_cs.codepoint_size
            if tlen = 3 then
                tlen := 4 -- alignment ...
            end
            tlen := 6 * len + 1
                -- Let's be sufficiently generous ...
            create t.make (1, tlen)
            written := convert (f, t, flen)
            written := written - 1
            -- forget the terminating 0.

            if written > 0 then
                inspect to_cs.codepoint_size

                when 1 then
                    from
                        i := 1
                        j := to_data.lower
                    until
                        i > written
                    loop
                        to_data.put (t.item (i), j)
                        i := i + 1
                        j := j + 1
                    end

                when 2 then
                    from
                        i := 1
                        j := to_data.lower
                    until
                        i > written
                    loop
                        put_ushort (to_data, j, t.item (i))
                        j := j + 2
                    end

                when 3, 4 then
                    from
                        i   := 1
                        j   := to_data.lower
                    until
                        i > written
                    loop
                        put_ulong (to_data, j, t.item (i))
                        i := i + 1
                        j := j + 4
                    end -- loop over i and j

                else
                    log := logger.log (logger.Log_err, "General",
                                       "UNICODESET_CONVERTER",
                                       "decode")
                    log.put_string ("trying to decode with nonsupported codepoint size ")
                    log.putint (to_cs.codepoint_size)
                    log.new_line
                    check
                        supported_codepoint_size2 : false
                    end
                end -- inspect
            end -- if written > 0 then ...
            result := written
        end
---------------------------------

    decode_and_terminate (dc : DATA_DECODER;
                 to_data : ARRAY [INTEGER];
                 len : INTEGER) : INTEGER is

        local
            f, t    : ARRAY [INTEGER]
            flen    : INTEGER
            tlen    : INTEGER
            i, j    : INTEGER
            ir      : INTEGER_REF
            written : INTEGER
            log     : IO_MEDIUM

        do
            flen := from_cs.codepoint_size
            if flen = 3 then
                flen := 4 -- alignment ...
            end
            flen := len * flen

            create f.make (1, flen)
            inspect from_cs.codepoint_size

            when 1 then
                from
                    i := 1
                until
                    i > flen
                loop
                    f.put (dc.get_octet.value, i)
                    i := i + 1
                end

            when 2 then
                from
                    create ir
                    i := 1
                until
                    i > flen
                loop
                    dc.get_ushort (ir)
                    f.put (ir.item, i)
                    i := i + 1
                end

            when 3, 4 then
                from
                    create ir
                    i := 1
                until
                    i > flen
                loop
                    dc.get_ulong (ir)
                    f.put (ir.item, i)
                    i := i + 1
                end

            else
                log := logger.log (logger.Log_err, "General",
                                   "UNICODESET_CONVERTER",
                                   "decode_and_terminate")
                log.put_string ("trying to decode with nonsupported codepoint size ")
                log.putint (from_cs.codepoint_size)
                log.new_line
                check
                    supported_codepoint_size1 : false
                end
            end

            tlen := to_cs.codepoint_size
            if tlen = 3 then
                tlen := 4 -- alignment ...
            end
            tlen := len * tlen
            create t.make (1, tlen)
            written := convert (f, t, flen)

            -- this time don't forget the terminating 0.

            if written > 0 then
                inspect to_cs.codepoint_size

                when 1 then
                    from
                        i := 1
                        j := to_data.lower
                    until
                        i > written
                    loop
                        to_data.put (t.item (i), j)
                        i := i + 1
                        j := j + 1
                    end

                when 2 then
                    from
                        i := 1
                        j := to_data.lower
                    until
                        i > written
                    loop
                        put_ushort (to_data, j, t.item (i))
                        i := i + 1
                        j := j + 2
                    end

                when 3, 4 then
                    from
                        i   := 1
                        j   := to_data.lower
                    until
                        i > written
                    loop
                        put_ulong (to_data, j, t.item (i))
                        i := i + 1
                        j := j + 4
                    end -- loop over i and j

                else
                    log := logger.log (logger.Log_err, "General",
                                       "UNICODESET_CONVERTER",
                                       "decode_and_terminate")
                    log.put_string ("try to decode with nonsupported codepoint size ")
                    log.putint (to_cs.codepoint_size)
                    log.new_line
                    check
                        supported_codepoint_size2 : false
                    end
                end -- inspect
            end -- if written > 0 then ...
            result := written
        end
---------------------------------
feature { NONE } -- Impementation

    convert (from_data, to_data : ARRAY [INTEGER]; len : INTEGER) : INTEGER is
        -- First convert `from_data' to UTF8.
        -- Then convert UTF8 into `to_data'.
        -- `len' elements are to be converted.

        require
            enough_data : from_data.count >= len

        local
            chars    : INTEGER
            tlen     : INTEGER
            written  : INTEGER
            fext     : ANY
            text     : ANY
            tmp      : ARRAY [INTEGER]
            return   : BOOLEAN

        do
            if to_cs.id = C_utf8 then
                text := to_data.to_c
            else
                tlen := 6 * len + 1
                    -- UTF8 has max 6 code points per char
                create tmp.make (1, tlen)
                text := tmp.to_c
            end -- if to_cs.id = C_utf8 then ...
            fext := from_data.to_c
            chars := uni_toUTF8 ($text, $fext, tlen, len,
                                 from_cs.id, C_line_lf)
            if chars < 0 then
                logger.log (logger.Log_err, "General", "UNICODESET_CONVERTER",
                            "convert").put_string ("codeset conversion error in %
                                %stage 1%N")
                check
                    could_convert1 : false
                end
                result := -1
                return := true
            end -- if chars < 0 then ...

            if not return     and then
               to_cs.id /= C_utf8 then
                text     := to_data.to_c
                tlen     := to_data.count
                fext     := tmp.to_c
                written := uni_fromUTF8 ($text, $fext, tlen, chars,
                                         to_cs.id, C_line_lf)
                if written < 0 then
                    logger.log (logger.Log_err, "General", "UNICODESET_CONVERTER",
                                "convert").put_string ("codeset conversion error in %
                                    %stage 2%N")
                    check
                        could_convert2 : false
                    end
                    result := -1
                    return := true
                else -- success
                    result := written
                    return := true
                end -- if written < 0 then ...
            end -- if not return  and then to_cs.id /= C_utf8 then ...
        end
---------------------------------

    uni_fromUTF8 (t, f : POINTER;
                  tlen, flen, id, ending : INTEGER) : INTEGER is
        -- `t' and `f' point to (C) arrays of INTEGER. `t' has `tlen'
        -- elements. `ending' specifies the type of line end used
        -- (e. g. LF or CRLF). `flen' elements of `f', which are coded
        -- in UTF8 are to be converted to the codeset specified by
        -- `id' and stored in `t'. The return value is the number of
        -- elements placed in `t'; a value < 0 means an error occurred.

        external "C"
        alias "MICO_uni_fromUTF8"

        end
---------------------------------

    uni_toUTF8 (t, f : POINTER;
                tlen, flen, id, ending : INTEGER) : INTEGER is

        -- `t' and `f' point to (C) arrays of INTEGER. `t' has `tlen'
        -- elements. `id' specifies the code set in which `f' is coded
        -- and `ending' the type of line end used (e. g. LF or CRLF).
        -- `flen' elements of `f' are to be converted to UTF8 and placed
        -- in `t'. The return value is the number of elements placed in `t';
        -- a value < 0 means an error occurred.

        external "C"
        alias "MICO_uni_toUTF8"

        end

end -- class UNICODESET_CONVERTER

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
