indexing

description: "Parses the start production <specification>(1[2.3]); i.e. it's %
             %essentially the whole parser";
keywords: "specification";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SPECIFICATION_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

creation
    make

feature

    make (project_name : STRING; ipaths : INDEXED_LIST [STRING]) is

        do
            project       := project_name
            include_paths := ipaths
            create repoids.make
            create versions.make
            version    := "1.0"
            rep_prefix := void
        end
----------------------

    value      : SPECIFICATION
    version    : STRING
    rep_prefix : STRING
    repoids    : DICTIONARY [STRING, SCOPED_NAME]
    versions   : DICTIONARY [STRING, SCOPED_NAME]

    parse (scan : SCANNER) is

        local
            dp  : DEFINITION_PARSER
            tok : INTEGER

        do
            from
                create value.make
                create dp
                tok := scan.token
                if tok = Include_token or else
                   tok = Version_token or else
                   tok = Pragma_token     then
                    parse_directive (scan)
                else
                    dp.parse (scan)
                    if dp.its_new then
                        value.add_component (dp.value)
                    end
                end
                tok := scan .token
            until
                tok = End_of_text
            loop
                if tok = Include_token or else
                   tok = Version_token or else
                   tok = Pragma_token     then
                    parse_directive (scan)
                else
                    dp.parse (scan)
                    if dp.its_new then
                        value.add_component (dp.value)
                    end
                end
                tok := scan .token
            end
        end
----------------------

    parse_include (scan : SCANNER) is

        local
            i, n  : INTEGER
            tok   : INTEGER
            sp    : like current
            read  : IDL_FILE_READER
            scn   : IDL_SCANNER
            tf    : PLAIN_TEXT_FILE
            path  : STRING
            ipath : STRING

        do
            tok := scan.token
            if tok = String_literal then
                ipath := scan.string_value
                scan.advance -- Eat the path
            else -- it must be of form "<path>"
                path := parse_path (scan)
                ipath := find_include (path)
            end

            if not fs.file_exists (ipath) then
                error (<<"The file ", path, " not found">>)
            end

            if not fs.has_readperm (ipath) then
                error (<<"You do not have read permission for ", ipath>>)
            end

            create tf.make_open_read (ipath)
            create read.make
            create scn.make (read)
            error_handler.set_scanner (scn)
            read.set_text (tf)
            create sp.make (project, include_paths)
            sp.parse (scn)

            from
                i := 1
                n := sp.value.component_count
            until
                i > n
            loop
                value.add_component (sp.value.component_at (i))
                i := i + 1
            end
            tf.close
            error_handler.set_scanner (scan)

        rescue
            if tf /= void then
                tf.close
            end
        end
----------------------

    parse_path (scan : SCANNER) : STRING is
        -- We use the following grammar for the paths
        -- that can occur here:
        -- <path> := "."
        --        |  ".""."
        --        |  <identifier>
        --        |  path"/"<identifier>
        --        |  path"."<identifier>

        require
            is_relative_path : scan.token = Left_angle

        local
            tok : INTEGER

        do
            scan.advance -- Eat the '<'
            tok := scan.token

            from
                if tok = Identifier then
                    result := scan.lexeme
                    scan.advance -- Eat the component
                    tok := scan.token
                elseif tok = Dot_token then
                    result := "."
                    scan.advance -- Eat the '.'
                    tok := scan.token
                    if tok = Dot_token then
                        result.extend ('.')
                        scan.advance -- Eat the '.'
                        tok := scan.token
                    end
                else
                    error (<<"Expecting %".%", %"..%" or %
                             %path component">>)
                end
            until
                tok /= Div_token and then
                tok /= Dot_token
            loop
                if tok = Div_token then
                    result.extend ('/')
                else -- it's got to be a '.'
                    result.extend ('.')
                end
                scan.advance -- Eat the '/' or '.'
                tok := scan.token
                if tok /= Identifier then
                    error (<<"Expecting a path component">>)
                end
                result.append (scan.lexeme)
                scan.advance -- Eat the component
                tok := scan.token
            end -- loop
            if tok /= Right_angle then
                error (<<"Expecting a '>'">>)
            end
            scan.advance -- Eat the '>'

            if result = void then
                error (<<"#include directive must give a path">>)
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    parse_directive (scan : SCANNER) is

        require
            token_is_directive : scan.token = Include_token or else
                                 scan.token = Version_token or else
                                 scan.token = Pragma_token

        do
            if scan.token = Include_token then
                scan.advance -- Eat the "#include"

                if scan.token = String_literal or else
                   scan.token = Left_angle     then
                    parse_include (scan)
                else
                    error (<<"Expecting string literal or '<'">>)
                end

            elseif scan.token = Version_token then
                scan.advance -- Eat the "#version"
                if scan.token /= String_literal then
                    error (<<"Expecting a version number">>)
                end
                version := scan.string_value
                scan.advance --Eat the version number
            else -- it's got to be a pragma
                scan.advance -- Eat the "#pragma"
                if scan.token = Identifier and then
                   (equal (scan.lexeme, "ID")     or else
                    equal (scan.lexeme, "prefix") or else
                    equal (scan.lexeme, "version")) then
                    parse_pragma (scan)
                else
                    error (<<"Expecting %"ID%" or %
                             %%"prefix%", or %"version%"">>)
                end
            end
        end
----------------------

    parse_pragma (scan : SCANNER) is

        require
            is_a_proper_pragma : scan.token = Identifier and then
                                 (equal (scan.lexeme, "ID")     or else
                                  equal (scan.lexeme, "prefix") or else
                                  equal (scan.lexeme, "version"))
        local
            vers : STRING
            snp  : SCOPED_NAME_PARSER

        do
            if equal (scan.lexeme, "ID")   then
                scan.advance -- Eat the "ID"
                create snp
                snp.parse (scan)
                if scan.token /= String_literal then
                    error (<<"Expecting a string literal">>)
                end
                repoids.put (clone (scan.string_value), snp.value)
                scan.advance -- Eat the literal string
            elseif equal (scan.lexeme, "prefix") then
                scan.advance -- Eat the "prefix"
                if scan.token /= String_literal then
                    error (<<"Expecting a string literal">>)
                end
                rep_prefix := clone (scan.string_value)
                scan.advance -- Eat the prefix string
            elseif equal (scan.lexeme, "version") then
                scan.advance -- Eat the "version"
                create snp
                snp.parse (scan)
                if scan.token /= Real_literal then
                    error (<<"Expecting a version number of the form %
                             %major.minor">>)
                else
                    vers := clone (scan.lexeme)
                end
                scan.advance -- Eat the version number
                versions.put (vers, snp.value)
            end
        end
----------------------
feature { NONE }

    project       : STRING
    include_paths : INDEXED_LIST [STRING]

----------------------

    find_include (path : STRING) : STRING is

        require
            novoid_arg : path /= void

        local
            i, n  : INTEGER
            trial : STRING
            err   : BOOLEAN

        do
            if not err then
                i := include_paths.low_index
                n := include_paths.high_index
            else
                i := i + 1 -- previous value lead to exception
            end
            from
                -- do not reinitialize after exception ...
            until
                result /= void or else i > n
            loop
                trial := include_paths.at (i)
                if fs.cluster_exists (trial) then
                    trial := fs.concat_paths (trial, path)
                    if fs.file_exists (trial) then
                        result := trial
                    end
                end -- if fs.cluster_exits (trial) then ...
                i := i + 1
            end
            if result = void then -- assume it's in working directory
                result := path
            end

        ensure
            nonvoid_result : result /= void

        rescue
            err := true
            retry
        end
----------------------

    fs : FILE_SYSTEM is

        once
            create result.make
        end

end -- class SPECIFICATION_PARSER

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
