indexing

description: "Represents nonterminal <fixed_pt_type>(96[2.3])";
keywords: "fixed_pt_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FIXED_PT_TYPE

inherit
    CONST_TYPE;
    TEMPLATE_TYPE_SPEC;
    PARAM_TYPE_SPEC
        redefine
            accept
        end

feature

    digits : INTEGER
    scale  : INTEGER
----------------------
feature { CONCRETE_SYNTAX_PARSER }

    set_digits (d : INTEGER) is

        do
            digits := d
        end
----------------------

    set_scale (s : INTEGER) is

        do
            scale := s
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_fixed_pt_type (current)
        end

end -- class FIXED_PT_TYPE

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
