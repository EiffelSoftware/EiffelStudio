indexing

description: "Represents nonterminal <simple_declarator>(51[2.3])";
keywords: "simple_declarator";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SIMPLE_DECLARATOR

inherit
    IDL_DECLARATOR
        redefine
            accept
        end

creation
    make

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }


    identifier : STRING

    make (id : STRING; nm : SCOPED_NAME) is

        do
            identifier := id
            if nm /= void then
                name := nm
            else
                create name.make
                name.add_name_component (id)
            end
        end
----------------------

    set_identifier (id : STRING) is

        do
            identifier := id
            if name = void then
                create name.make
                name.add_name_component (id)
            end
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_simple_declarator (current)
        end

end -- class SIMPLE_DECLARATOR

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
