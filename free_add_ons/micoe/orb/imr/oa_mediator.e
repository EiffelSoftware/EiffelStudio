indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
deferred class OA_MEDIATOR

inherit
    CORBA_OBJECT

feature

    create_obj (objref, remote_objref : CORBA_OBJECT;
                id : ARRAY [INTEGER]; svid : INTEGER) is

        deferred
        end
--------------------------------------

    restore_obj (objref, remote_objref : CORBA_OBJECT;
                 id : ARRAY [INTEGER]; svid : INTEGER) is

        deferred
        end
--------------------------------------

    activate_obj (objref : CORBA_OBJECT; svid : INTEGER) is

        deferred
        end
--------------------------------------

    deactivate_obj (objref : CORBA_OBJECT; svid : INTEGER) is

        deferred
        end
--------------------------------------

    migrate_obj (objref : CORBA_OBJECT;
                 svid : INTEGER;
                 im : IMPLEMENTATION_DEFINITION) is

        deferred
        end
--------------------------------------

    orphan_obj (objref : CORBA_OBJECT; svid : INTEGER) is

        deferred
        end
--------------------------------------

    dispose_obj (objref : CORBA_OBJECT; svid : INTEGER) is

        deferred
        end
--------------------------------------

    create_impl (impl : IMPLEMENTATION_DEFINITION; server : OA_SERVER; id : INTEGER) is

        deferred
        end
--------------------------------------

    activate_impl (id : INTEGER) is

        deferred
        end
--------------------------------------

    deactivate_impl (id : INTEGER) is

        deferred
        end
--------------------------------------

    dispose_impl (id : INTEGER) is

        deferred
        end
--------------------------------------

    get_restore_objs (id : INTEGER) : INDEXED_LIST [CORBA_OBJECT] is

        deferred
        end

end -- class OA_MEDIATOR
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
