indexing

description: "Abstraction of a file event.";
keywords: "scheduling", "event";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FILE_EVENT

creation
    make, make3

feature -- Initialization

    make is

        do
        end
---------------------------------

    make3 (ev, file_desc : INTEGER; dcb : DISPATCHER_CALLBACK) is

        do
            event   := ev
            fd      := file_desc
            cb      := dcb
            deleted := false
        end
---------------------------------
feature -- Access

    get_event : INTEGER is

        do
            result := event
        end
---------------------------------

    get_fd : INTEGER is

        do
            result := fd
        end
---------------------------------

    get_cb : DISPATCHER_CALLBACK is

        do
            result := cb
        end
---------------------------------

    get_deleted : BOOLEAN is

        do
            result := deleted
        end
---------------------------------
feature -- Mutation

    set_event (ev : INTEGER) is

        do
            event := ev
        end
---------------------------------

    set_fd (file_desc : INTEGER) is

        do
            fd := file_desc
        end
---------------------------------

    set_cb (dcb : DISPATCHER_CALLBACK) is

        do
            cb := dcb
        end
---------------------------------

    set_deleted (on_off : BOOLEAN) is

        do
            deleted := on_off
        end
---------------------------------
feature { NONE } -- Implementation

    event   : INTEGER
    fd      : INTEGER
    cb      : DISPATCHER_CALLBACK
    deleted : BOOLEAN


end -- class FILE_EVENT

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
