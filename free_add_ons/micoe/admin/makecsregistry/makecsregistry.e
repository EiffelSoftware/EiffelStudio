indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class MAKECSREGISTRY

inherit
    ARGUMENTS

creation
    make

feature

    make is

        local
            err      : BOOLEAN
            reg_path : STRING
            out_file : PLAIN_TEXT_FILE
            text     : INDEXED_LIST [STRING]
            i, n     : INTEGER
            m        : INTEGER
            t        : TOKENS
            s, s1    : STRING
            ext      : ANY

        do
            if not err then
                if argument_count = 0 then    
                    io.put_string ("Usage: ")
                    io.put_string (fs.path_suffix (command_name))
                    io.put_string (" <registry-file>%N")
                    except.raise ("usage")
                else
                    reg_path := argument_array.item (1)
                end
                if not fs.file_exists (reg_path) then
                    io.put_string ("The registry file ")
                    io.put_string (reg_path)
                    io.put_string (" does not exist%N")
                    except.raise ("existence")
                else
                    text := load_text (reg_path)
                end
                if fs.file_exists ("the_osf_cs_registry.e") then
                    fs.remove_file ("the_osf_cs_registry.e")
                end
                create out_file.make_open_write ("the_osf_cs_registry.e")
                io.set_file_default (out_file)
                io.put_string ("class THE_OSF_CS_REGISTRY%N")
                indent_to (1)
                io.put_string ("-- automatically generated from %
                               %code_set_registry.txt by makecsregistry%N%N")
                io.put_string ("feature%N%N")
                indent_to (1)
                io.put_string ("osf_cs_registry : %
                               %DICTIONARY [CODESET_INFO, INTEGER] is%N%N")
                indent_to (2)
                io.put_string ("local%N")
                indent_to (3)
                io.put_string ("csi  : CODESET_INFO%N%N")
                indent_to (2)
                io.put_string ("once%N")
                indent_to (3)
                io.put_string ("create result.make%N")
                from
                    i := text.low_index
                    n := text.high_index
                    create t.make (" %T,")
                until
                    i > n
                loop
                    i := find_start (text, i) + 1
                    if i <= text.high_index then
                        indent_to (3)
                        io.put_string ("create csi.make%N")
                        t.set_text (text.at (i))
                        if equal (t.token, "description") then
                            t.forth
                            indent_to (3)
                            io.put_string ("csi.set_desc (%"")
                            io.put_string (t.rest)
                            io.put_string ("%")%N")
                            -- Kay Roemer: "Die Deppen von der OSF haben
                            -- codepoint_size vergessen"! So it has to be
                            -- hand coded.
                            indent_to (3)
                            if t.rest.substring_index ("UCS-2", 1) > 0 then
                                io.put_string ("csi.set_codepoint_size (2)%N")
                            elseif t.rest.substring_index ("UCS-4", 1) > 0 then
                                io.put_string ("csi.set_codepoint_size (4)%N")
                            elseif t.rest.substring_index ("UTF-16", 1) > 0 then
                                io.put_string ("csi.set_codepoint_size (2)%N")
                            else
                                io.put_string ("csi.set_codepoint_size (1)%N")
                            end
                            i := i + 1
                            t.set_text (text.at (i))
                        end
                        if equal (t.token, "loc_name") then
                            i := i + 1
                            t.set_text (text.at (i))
                        end
                        if equal (t.token, "rgy_value") then
                            t.forth
                            s   := t.token
                            ext := s.to_c
                            m := hexstring2int ($ext)
                            indent_to (3)
                            io.put_string ("csi.set_id (")
                            io.putint (m)
                            io.put_string (")%N")
                            m  := s.index_of ('x', 1)
                            s1 := s.substring (m + 1, s.count)
                            s  := "osf"
                            s.append (s1)
                            indent_to (3)
                            io.put_string ("csi.set_name (%"")
                            io.put_string (s)
                            io.put_string ("%")%N")
                            i := i + 1
                            t.set_text (text.at (i))
                        end
                        if equal (t.token, "char_values") then
                            from
                                t.forth
                            until
                                t.finished
                            loop
                                ext := t.token.to_c
                                m   := hexstring2int ($ext)
                                indent_to (3)
                                io.put_string ("csi.add_char_value (")
                                io.putint (m)
                                io.put_string (")%N")
                                t.forth
                            end
                            indent_to (3)
                            io.put_string ("csi.add_char_value (0)%N")
                            i := i + 1
                            t.set_text (text.at (i))
                        end
                        if equal (t.token, "max_bytes") then
                            t.forth
                            indent_to (3)
                            io.put_string ("csi.set_max_codepoints (")
                            io.put_string (t.token)
                            io.put_string (")%N")
                            i := i + 1
                            t.set_text (text.at (i))
                        end
                        if equal (t.token, "end") then
                            i := i + 1
                        end
                        indent_to (3)
                        io.put_string ("result.put (csi, csi.id)%N")
                    end -- if i <= text.high_index then ...
                end
                indent_to (2)
                io.put_string ("end%N%N")
                io.put_string ("end -- class THE_OSF_CS_REGISTRY%N")
            end -- if not err then ...

        rescue
            err := true
            retry
        end
----------------------
feature { NONE }


    load_text (path : STRING) : INDEXED_LIST [STRING] is

        local
            inf : PLAIN_TEXT_FILE

        do
            from
                create result.make (false)
                create inf.make_open_read (path)
            until
                inf.end_of_file or else not inf.file_readable
            loop
                inf.read_line
                result.append (clone (inf.last_string))
            end
            inf.close
        end
----------------------

    find_start (text : INDEXED_LIST [STRING]; begin : INTEGER) : INTEGER is
        -- Next line in `text' that begins with "start" beginning search
        -- at `begin'.

        local
            n : INTEGER

        do
            from
                result := begin
                n      := text.high_index
            until
                result > n
                or else
                (text.at (result).count > 0 and then
                 text.at (result).substring_index ("start", 1) > 0)
            loop
                result := result + 1
            end
        end
----------------------

    indent_to (n : INTEGER) is

        local
            i : INTEGER

        do
            from
                i := 1
            until
                i > n
            loop
                io.put_string ("    ")
                i := i + 1
            end
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end
----------------------

    fs : FILE_SYSTEM is

        once

           create result.make
        end
----------------------

    hexstring2int (sp : POINTER) : INTEGER is

        external "C"
        alias "MICO_hexstring2int"

        end        

end -- class MAKECSREGISTRY


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
