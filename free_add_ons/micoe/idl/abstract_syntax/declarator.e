indexing

description: "Represents nonterminal <declarator>(50[2.3])";
keywords: "declarator";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class IDL_DECLARATOR
    -- Sorry! We can't call it DECLARATOR since the ISE
    -- kernel cluster has a class DECLARATOR and class
    -- renaming in LACE doesn't seem to work.

inherit
    IDL_SYNTAX_ELEMENT

feature

    name : SCOPED_NAME

    set_name (nm : SCOPED_NAME) is

        do
            name := nm
        end

end -- class IDL_DECLARATOR

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
