indexing

description: "Still to be entered";
keywords: "Parsing framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class CONCRETE_SYNTAX_PARSER

inherit
    LEX_TOKENS;
    PROJECT_TOKENS;
    THE_HANDLER

feature

    value : ABSTRACT_SYNTAX_ELEMENT
        -- Result of parsing.

    parse (scan : SCANNER) is

        deferred
        end
------------------------------------------------------

    error (msgs : ARRAY [STRING]) is

        local
            i : INTEGER
            m : STRING

        do
            from
                i := msgs.lower
                m := msgs.item (i)
                i := i + 1
            until
                i > msgs.upper
            loop
                m.append (msgs.item (i))
                i := i + 1               
            end
            error_handler.error (m, true)
        end
------------------------------------------------------

    warning (msg : STRING) is

        do
             error_handler.warning (msg, true)
        end

end -- class CONCRETE_SYNTAX_PARSER

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
