indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_PRINCIPAL

inherit
    PRINCIPAL
        redefine
            list_properties, get_property
        end

creation
    make2, make3, make_with_decoder3, make_with_decoder4

feature -- Initialization

    make2 (peer : X509; cipher : ARRAY [INTEGER]) is

        do
            make3 (peer, cipher, void)
        end
----------------------

    make3 (peer : X509; cipher : ARRAY [INTEGER]; t :TRANSPORT) is

        do
        end
----------------------

    make_with_decoder3 (peer : X509;
                        cipher : ARRAY [INTEGER];
                        dc : DATA_DECODER) is

        do
            make_with_decoder4 (peer, cipher, dc, void)
        end
----------------------

    make_with_decoder4 (peer : X509; cipher : ARRAY [INTEGER];
           dc : DATA_DECODER; t : TRANSPORT) is

        do
        end
----------------------

    list_properties : ARRAY [STRING] is

        do
        end
----------------------

    get_property (prop_name : STRING) : CORBA_ANY is

            do
            end

end -- class SSL_PRINCIPAL

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


