indexing

description: "The parent of all skeletons";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class STANDARD_SKELETON
    -- The class from which all skeletons inherit.

inherit
    IMPLEMENTATION_BASE
        rename
            make as ib_make
        redefine
            doinvoke
        end;
    PRODUCER
        undefine
            copy, is_equal
        redefine
            produce
        end

feature

    doinvoke (req : SERVER_REQUEST_BASE; env : ENVIRONMENT) is

        local
            op : STRING
            ex : BAD_OPERATION
            sr : CORBA_SERVER_REQUEST

        do
            the_message ?= req
            if my_dispatcher = void then
                build_my_dispatcher
            end
            op := the_message.operation
            if my_dispatcher.has (op) then
                my_dispatcher.at (op).execute
            else -- unknown operation
                create ex.make
                sr ?= the_message
                sr.set_exception_ex (ex)
            end
        end
----------------------
feature { COURIER }

    frozen produce is

        do
            message_available := true
        end
----------------------
feature { NONE } -- Implementation

    my_dispatcher : DICTIONARY [COURIER, STRING]
----------------------

    dispatcher : DICTIONARY [COURIER, STRING] is

        deferred
        end
----------------------

    frozen build_my_dispatcher is

        local
            it   : ITERATOR
            cour : COURIER

        do
            from
                my_dispatcher := clone (dispatcher)
                it            := my_dispatcher.iterator
            until
                it.finished
            loop
                cour := my_dispatcher.item (it)
                cour.set_consumer (current)
                cour.set_producer (current)
                it.forth
            end
        end

end -- class STANDARD_SKELTON

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
