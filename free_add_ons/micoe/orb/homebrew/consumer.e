indexing

description: "Anything that can consume a message.";
keywords: "consumer"

class  CONSUMER

feature { COURIER, CONSUMER, PRODUCER }

    consume (message : ANY; message_type : INTEGER) is
                        -- Consume a message of given type.
                        -- Default is 'do nothing'.
        do
        end
-----------------------------------------------------------

    valid_message_type (message : ANY; message_type : INTEGER) : BOOLEAN is
            -- Can this consumer handle a message of the
            -- given type. The default behavior is to
            -- answer `no'.

        do
        end

end -- class CONSUMER

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
