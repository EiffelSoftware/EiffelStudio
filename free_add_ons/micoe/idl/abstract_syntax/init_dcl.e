indexing

description: "Represents nonterminal <init_dcl>(23[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INIT_DCL

inherit
    VALUE_ELEMENT;
    COMPOSITE_SYNTAX_ELEMENT
        rename
            make as comp_make
        redefine
            anchor
        end

creation { INIT_DCL_PARSER }
    make

feature

    make (nm : SCOPED_NAME) is

        do
            name := nm
            comp_make
        end
----------------------
feature { SEMANTIC_VISITOR }

    name : SCOPED_NAME

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_init_dcl (current)
        end
----------------------
feature { NONE }

    anchor  : INIT_PARAM_DCL

end -- class INIT_DCL

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
