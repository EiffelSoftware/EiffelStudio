indexing

description: "Some constants defined as an enum in [OMG]";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class ENUM_CONSTANTS

feature

---------- enum AttributeMode --------------------

    Attr_normal   : INTEGER is 0
    Attr_readonly : INTEGER is 1

----------- enum OperationMode -------------------

    Op_normal : INTEGER is 0
    Op_oneway : INTEGER is 1

------- enum ParameterMode -----------------------

    Param_in    : INTEGER is 0
    Param_out   : INTEGER is 1
    Param_inout : INTEGER is 2


end -- class ENUM_CONSTANTS

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
