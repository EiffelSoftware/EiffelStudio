indexing

description: "Represents a kind of type_dcl introduced in (42[2.3])";
keywords: "native_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class NATIVE_TYPE

inherit
    TYPE_DCL

creation { CONCRETE_SYNTAX_PARSER }
    make

feature { CONCRETE_SYNTAX_PARSER } -- Initialization

    make (sd : SIMPLE_DECLARATOR) is

        do
            simple_declarator := sd
        end
----------------------
feature { SEMANTIC_VISITOR }

    simple_declarator : SIMPLE_DECLARATOR

----------------------

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_native_type (current)
        end
----------------------
feature { CONCRETE_SYNTAX_PARSER } -- Mutation

    set_simple_declarator (sd : SIMPLE_DECLARATOR) is

        do
            simple_declarator := sd
        end

end -- class NATIVE_TYPE

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
