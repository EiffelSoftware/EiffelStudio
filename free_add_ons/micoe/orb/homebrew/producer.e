indexing

description: "Anything that can produce a message; application classes often%
             % inherit from ICE_PRODUCER so couriers can transport messages%
             % from them to interface objects that are consumers.";
keywords: "producer", "application classes"

deferred class  PRODUCER

feature -- Access

    message_available : BOOLEAN
        -- Do we have a message for someone?

feature -- Production

    message : ANY is
        -- This is the message - valid, if and
        -- only if `message_available' is true.

        deferred
        end

    produce is
        -- Do whatever you're supposed to do.

        do
        end


end -- class PRODUCER

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
