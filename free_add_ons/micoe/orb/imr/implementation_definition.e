indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
deferred class IMPLEMENTATION_DEFINITION

inherit
    CORBA_OBJECT

feature

    mode : INTEGER is

        deferred
        end
--------------------------------------

    set_mode (value : INTEGER) is

        deferred
        end
--------------------------------------

    repoids : INDEXED_LIST[STRING] is

        deferred
        end
--------------------------------------

    set_repoids (value : INDEXED_LIST[STRING]) is

        deferred
        end
--------------------------------------

    name : STRING is

        deferred
        end
--------------------------------------

    command : STRING is

        deferred
        end
--------------------------------------

    set_command (value : STRING) is

        deferred
        end
--------------------------------------

    to_string : STRING is

        deferred
        end

end -- class IMPLEMENTATION_DEFINITION
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
