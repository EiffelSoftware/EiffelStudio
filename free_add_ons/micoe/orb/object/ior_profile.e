indexing

description: "Parent of all profile classes";
keywords: "GIOP framework", "object reference";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class IOR_PROFILE

inherit
    MICO_COMPARABLE

feature -- Access

    addr : ADDRESS is

        deferred
        end
----------------------

    id : INTEGER is

        deferred
        end
----------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        require
            nonvoid_arg : l /= void

        deferred
        end
----------------------

    reachable : BOOLEAN is

        deferred
        end
----------------------

    components : MULTI_COMPONENT is

        do
        end
----------------------
feature -- Encoding and Decoding

    encode_id : INTEGER is

        deferred
        end
----------------------

    encode (ec : DATA_ENCODER) is

        deferred
        end
----------------------
feature -- Mutation

    set_objectkey (o : ARRAY [INTEGER]; cnt : INTEGER) is

        require
            enough_data : o.count >= cnt

        deferred
        end
----------------------
feature -- Miscellaneous

    print_it is

        deferred
        end
----------------------

    keycompare (k1, k2 : ARRAY [INTEGER]) : INTEGER is

        local
            i, n : INTEGER

        do
            if k1 /= void and k2 /= void then
                if k1.count /= k2.count then
                     result := k1.count - k2.count
                else
                    from
                        i := 1
                        n := k1.count
                    until
                        i > n or result /= 0
                    loop
                        result := k1.item (i) - k2.item (i)
                        i      := i + 1
                    end
                end
            end
        end

end -- class IOR_PROFILE

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
