indexing

description: "Some constants defined as enums ion [OMG]";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class GIOP_CONSTANTS

feature -- IOP enum

    IOP_Transactionservice : INTEGER is 0
    IOP_Codesets           : INTEGER is 1
----------------------
feature -- GIOP Events

    GIOP_Input_ready : INTEGER is 0
    GIOP_Closed      : INTEGER is 1
    GIOP_Idle        : INTEGER is 2

----------------------
feature -- enum ReplyStatusType

    No_exception      : INTEGER is 0
    User_exception    : INTEGER is 1
    System_exception  : INTEGER is 2
    Location_forward  : INTEGER is 3

----------------------
feature -- enum LocateStatusType

    Unknown_object : INTEGER is 0
    Object_here    : INTEGER is 1
    Object_forward : INTEGER is 2

----------------------
feature -- GIOP #defines

    GIOP_byteorder_bit : INTEGER is 1
    GIOP_fragment_bit  : INTEGER is 2

----------------------
feature -- enum MsgType_1_1

    GIOP_request          : INTEGER is 0
    GIOP_reply            : INTEGER is 1
    GIOP_cancel_request   : INTEGER is 2
    GIOP_locate_request   : INTEGER is 3
    GIOP_locate_reply     : INTEGER is 4
    GIOP_close_connection : INTEGER is 5
    GIOP_message_error    : INTEGER is 6
    GIOP_fragment         : INTEGER is 7
----------------------
feature -- enum GIOP::ReplyStatusType

    GIOP_no_exception     : INTEGER is 0
    GIOP_user_exception   : INTEGER is 1
    GIOP_system_exception : INTEGER is 2
    GIOP_location_forward : INTEGER is 3
----------------------
feature -- enum GIOP::LocateStatusType

    GIOP_unknown_object : INTEGER is 0
    GIOP_object_here    : INTEGER is 1
    GIOP_object_forward : INTEGER is 2

end -- class GIOP_CONSTANTS

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
