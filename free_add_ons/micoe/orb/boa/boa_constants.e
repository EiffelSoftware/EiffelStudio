indexing

description: "Some constants needed by the BOA.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class BOA_CONSTANTS

feature

------- Constants needed by BOAs ---------------

    BOA_active   : INTEGER is 0
    BOA_shutdown : INTEGER is 1
    BOA_inactive : INTEGER is 2

    -- Activation modes

    Activate_shared     : INTEGER is 0
    Activate_unshared   : INTEGER is 1
    Activate_per_method : INTEGER is 2
    Activate_persistent : INTEGER is 3
    Activate_library    : INTEGER is 4

end -- class BOA_CONSTANTS

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
