indexing

description: "The parent of all address classes.";
keywords: "GIOP framework", "address";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class ADDRESS

inherit
    THE_LOGGER
        undefine
            copy, is_equal
        end;
    ADDRESS_STATICS
        undefine
            copy, is_equal
        end;
    MICO_COMPARABLE;
    HASHABLE
        undefine
            copy, is_equal
        end

feature

    stringify : STRING is

        deferred
        end
----------------------

    proto : STRING is

        deferred
        end
----------------------

    make_transport : TRANSPORT is

        deferred
        end
----------------------

    make_transport_server : TRANSPORT_SERVER is

        deferred
        end
----------------------

    make_ior_profile (a : ARRAY [INTEGER];
                      mc : MULTI_COMPONENT) : IOR_PROFILE is

        require
            nonvoid_arg : a  /= void and
                          mc /= void

        deferred
        end
----------------------

    is_local : BOOLEAN is

        deferred
        end

end -- class ADDRESS

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
