indexing

description: "Parses MICO style command line arguments.";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class GET_OPTS

creation
    make

feature

    make (the_opts : DICTIONARY [STRING, STRING]) is

        do
            in_opts := the_opts
            create out_opts.make
        end
----------------------

    parse2 (argc : INTEGER_REF; argv : ARRAY [STRING]) : BOOLEAN is

        do
            result := parse3 (argc, argv, false)
        end
----------------------

    parse3 (argc   : INTEGER_REF;
            argv   : ARRAY [STRING];
            ignore : BOOLEAN) : BOOLEAN is

        require
            nonvoid_arg     : argv /= void
            conformant_args : argc.item <= argv.upper

        local
            args  : INDEXED_LIST [STRING]
            erase : SORTED_LIST [INTEGER]
            nargc : INTEGER
            i     : INTEGER
            n     : INTEGER

        do
            n := argc.item
            from
                i := 1 -- 0th arg is program name
                create args.make (false)
            until
                i > n
            loop
                args.append (argv.item (i))
                i := i + 1
            end
            create erase.make (false)
            result := private_parse3 (args, erase, ignore)
            if result then
                from
                    nargc := 1
                    i     := args.low_index
                until
                    i > args.high_index
                loop
                    erase.search (i)
                    if not erase.found then
                        argv.put (args.at (i), nargc)
                        nargc := nargc + 1
                    end
                    i     := i + 1
                end -- loop
                if nargc <= n then
                    argv.put (void, nargc)
                end
                argc.set_item (nargc - 1)
            end -- if result then ...
        end
----------------------

    parse_vec (argv : INDEXED_LIST [STRING]) : BOOLEAN is

        do
            result := parse_vec2 (argv, false)
        end
----------------------

    parse_vec2 (argv   : INDEXED_LIST [STRING];
                ignore : BOOLEAN) : BOOLEAN is

        local
            erase : SORTED_LIST [INTEGER]

        do
            create erase.make (false)
            result := private_parse3 (argv, erase, ignore)
        end
----------------------

    parse_file (filename : STRING) : BOOLEAN is

        do
            result := parse_file2 (filename, false)
        end
----------------------

    parse_file2 (filename : STRING;
                 ignore   : BOOLEAN) : BOOLEAN is

        local
            env  : EXECUTION_ENVIRONMENT
            fs   : FILE_SYSTEM
            path : STRING
            inf  : PLAIN_TEXT_FILE
            argv : INDEXED_LIST [STRING]
            tok  : TOKENS

        do
            create fs.make
            create tok.make (" ")
            if filename.item (1) = '~' then
                create env
                path := env.get ("HOME")
                path := fs.concat_paths (path,
                                   filename.substring (3, filename.count))
            else
                path := filename
            end
            if not fs.file_exists (path) then
                result := true
            else
                from
                    create inf.make_open_read (path)
                    create argv.make (false)
                until
                    inf.end_of_file or else
                    not inf.file_readable
                loop
                    inf.readline
                    from
                        tok.set_text (clone (inf.last_string))
                    until
                        tok.finished
                    loop
                        argv.append (tok.token)
                        tok.forth
                    end

                end
                result := parse_vec2 (argv, ignore)
            end -- if not fs.file_exists (path) then ...
        end
----------------------

    opts : INDEXED_CATALOG [STRING, STRING] is

        do
            result := out_opts
        end
----------------------
feature { NONE } -- Implementation

    in_opts  : DICTIONARY [STRING, STRING]
    out_opts : INDEXED_CATALOG [STRING, STRING]
            -- It has to be a catalog because some
            -- options may be used more than once

----------------------

    private_parse2 (args  : INDEXED_LIST [STRING];
                    erase : SORTED_LIST [ INTEGER]) : BOOLEAN is

        do
            result := private_parse3 (args, erase, false)
        end
----------------------

    private_parse3 (args   : INDEXED_LIST [STRING];
                    erase  : SORTED_LIST [INTEGER];
                    ignore : BOOLEAN) : BOOLEAN is

        local
            i, n   : INTEGER
            pos    : INTEGER
            it     : ITERATOR
            arg    : STRING
            val    : STRING
            break  : BOOLEAN

        do
            from
                i := args.low_index
                n := args.high_index
                result := true
            until
                i > n or else break or else result = false
            loop
                arg := clone (args.at (i))

                if equal (arg, "--") then
                    erase.add (i)
                    break := true
                end -- if equal (arg, "--") then ...

                if not break and then not ignore 
                and then (arg.count = 0 or else arg @ 1 /= '-') then
                    break := true
                end -- if not break and then ...

                if not break then
                    if not in_opts.has (arg) then
                        -- `arg' is not recognized as option
                        if arg.count > 2 then
                            -- perhaps `arg' is of the form `-Ovalue'
                            arg.head (2)
                            pos := 2

                            if not in_opts.has (arg) then
                                pos := args.at (i).index_of ('=', 1)
                                if pos > 0 then
                                    -- perhaps the argument is of the form `--long-opt=something'
                                    arg := clone (args.at (i))
                                    arg.head (pos-1)
                                end -- if pos > 0 then ...
                            end -- if not in_opts.has (arg) then ...
                        end -- if arg.count > 2 then ...

                        if in_opts.has (arg) then
                            val := in_opts.at (arg)
                            if val.count = 0 then
                                io.put_string ("unexpected value for option ")
                                io.put_string (arg)
                                io.new_line
                                result := false
                            else
                                if not equal (val, "unique") 
                                or else not out_opts.has (arg) then
                                    val := clone (args.at (i))
                                    val.tail (val.count-pos)
                                    out_opts.add (val, arg)
                                end -- if not equal ...
                                erase.add (i)
                            end -- if val.count = 0 then ...
                        else
                            if not ignore then
                                io.put_string ("unknown option: ")
                                io.put_string (args.at (i))
                                io.new_line
                                result := false
                            end -- if not ignore then ...
                       end -- if in_opts.has (arg) then ...
                    else
                        val := in_opts.at (arg)
                        erase.add (i)
                        if val.count > 0 then
                            -- expecting value for `arg'
                            if i >= n then
                                io.put_string ("missing value for option ")
                                io.put_string (arg)
                                io.new_line
                                result := false
                            else
                                if not equal (val, "unique") 
                                or else not out_opts.has (arg) then
                                    out_opts.add (args.at (i + 1), arg)
                                end -- if not equal ...
                                erase.add (i + 1)
                                i := i + 1
                            end -- if i >= n then ...
                        else -- val.count = 0
                            if not out_opts.has (arg) then
                                out_opts.add ("", arg)
                            end -- if not out_opts.has (arg) then ...
                        end -- if val.count > 0 then ...
                    end -- if in_opts.has (arg) then ...
                end -- if not break then ...
                i := i + 1
            end -- loop over i
        end

end -- class GET_OPTS

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
