indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class BOA_INTERFACE


feature

    create3 (refd   : ARRAY [INTEGER];
             idef   : CORBA_INTERFACEDEF;
             impdef : IMPLEMENTATION_DEFINITION) : CORBA_OBJECT is

        do
            result := create_ref (refd, idef, impdef, void, void)
        end   
----------------------

    create4 (refd    : ARRAY [INTEGER];
             idef    : CORBA_INTERFACEDEF;
             impdef  : IMPLEMENTATION_DEFINITION;
             impbase : IMPLEMENTATION_BASE) : CORBA_OBJECT is

        do
            result := create_ref (refd, idef, impdef, impbase, void)
        end
----------------------

    create_ref (refd    : ARRAY [INTEGER];
                idef    : CORBA_INTERFACEDEF;
                impdef  : IMPLEMENTATION_DEFINITION;
                impbase : IMPLEMENTATION_BASE;
                repoid  : STRING) : CORBA_OBJECT is

        deferred
        end
----------------------

    restoring : BOOLEAN is

        deferred
        end
----------------------

    restore (orig   : CORBA_OBJECT;
             refd   : ARRAY [INTEGER];
             interf : CORBA_INTERFACEDEF;
             impl   : IMPLEMENTATION_DEFINITION;
             skel   : IMPLEMENTATION_BASE) : CORBA_OBJECT is

        deferred
        end
----------------------

    orb : ORB is

        deferred
        end
----------------------

    impl_name : STRING is

        deferred
        end
----------------------

    save_objects is

        deferred
        end
----------------------

    dispose_objects is

        deferred
        end
----------------------

    dispose (obj : CORBA_OBJECT) is

        deferred
        end
----------------------

    get_id (o : CORBA_OBJECT) : ARRAY [INTEGER] is

        deferred
        end
----------------------

    change_implementation (obj  : CORBA_OBJECT;
                           idef : IMPLEMENTATION_DEFINITION) is

        require
            nonvoid_arg : idef /= void

        deferred
        end
----------------------

    get_principal (o  : CORBA_OBJECT;
                   env: ENVIRONMENT) : PRINCIPAL is

        deferred
        end
----------------------

    impl_is_ready (idef : IMPLEMENTATION_DEFINITION) is

        deferred
        end
----------------------

    deactivate_impl (idef : IMPLEMENTATION_DEFINITION) is

        deferred
        end
----------------------

    obj_is_ready (obj : CORBA_OBJECT; idef : IMPLEMENTATION_DEFINITION) is

        deferred
        end
----------------------

    deactivate_obj (obj : CORBA_OBJECT) is

        deferred
        end
    
end -- class BOA_INTERFACE

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
