indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
deferred class IMPLEMENTATION_REPOSITORY

inherit
    CORBA_OBJECT

feature

    restore (asstring : STRING) : IMPLEMENTATION_DEFINITION is

        deferred
        end
--------------------------------------


    create_impl (mode : INTEGER; repoids : INDEXED_LIST [STRING];
                 name, command : STRING) : IMPLEMENTATION_DEFINITION is

        deferred
        end
--------------------------------------

    destroy (impl_def : IMPLEMENTATION_DEFINITION) is

        deferred
        end
--------------------------------------

    find_by_name (name : STRING) :  ARRAY [IMPLEMENTATION_DEFINITION] is

        deferred
        end
--------------------------------------

    find_by_repoid (rep : STRING) : ARRAY [IMPLEMENTATION_DEFINITION] is

        deferred
        end
--------------------------------------

    find_all : ARRAY [IMPLEMENTATION_DEFINITION] is

        deferred
        end

end -- class IMPLEMENTATION_REPOSITORY

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
