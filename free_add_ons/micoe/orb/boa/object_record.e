indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class OBJECT_RECORD

inherit
    BOA_CONSTANTS

creation
    make_l4, make_l5, make_lr5, make_lr6

feature -- Initialization

    make_l4 (loc    : CORBA_OBJECT;
             theid  : ARRAY[INTEGER];
             inface : CORBA_INTERFACEDEF;
             imp    : IMPLEMENTATION_DEFINITION) is

        do
            make_l5 (loc, theid, inface, imp, void)
        end
-----------------------------------------------

    make_l5 (loc_obj : CORBA_OBJECT;
             refdata : ARRAY [INTEGER];
             ifc     : CORBA_INTERFACEDEF;
             im      : IMPLEMENTATION_DEFINITION;
             sk      : IMPLEMENTATION_BASE) is

        do
            local_obj  := loc_obj
            remote_obj := loc_obj
            id         := refdata
            iface      := ifc
            impl       := im
            skel       := sk
            dosave     := true
            state      := Boa_active
            persistent := false
        end
-----------------------------------------------

    make_lr5 (loc_obj : CORBA_OBJECT;
              rem_obj : CORBA_OBJECT;
              refdata : ARRAY[INTEGER];
              ifc     : CORBA_INTERFACEDEF;
              im      : IMPLEMENTATION_DEFINITION) is

        do
            make_lr6 (loc_obj, rem_obj, refdata, ifc, im, void)
        end
-----------------------------------------------

   make_lr6 (loc_obj : CORBA_OBJECT;
             rem_obj : CORBA_OBJECT;
             refdata : ARRAY [INTEGER];
             ifc     : CORBA_INTERFACEDEF;
             im      : IMPLEMENTATION_DEFINITION;
             sk      : IMPLEMENTATION_BASE) is

        do
            local_obj  := loc_obj
            remote_obj := rem_obj
            id         := refdata
            iface      := ifc
            impl       := im
            skel       := sk
            dosave     := true
            state      := Boa_active
            persistent := false
        end
-----------------------------------------------

    get_id : ARRAY [INTEGER] is

        do
            if skel /= void then
                result := skel.get_ior.get_objectkey
            else
                result := id
            end
        end
-----------------------------------------------

    get_impl : IMPLEMENTATION_DEFINITION is

        do
            result := impl
        end
-----------------------------------------------

    set_impl (imp : IMPLEMENTATION_DEFINITION) is

        do
            impl := imp
        end
-----------------------------------------------

    get_iface : CORBA_INTERFACEDEF is

        do
            result := iface
        end
-----------------------------------------------

    set_iface (inface : CORBA_INTERFACEDEF) is

        do
            iface := inface
        end
-----------------------------------------------

    get_local_obj : CORBA_OBJECT is

        do
             result := local_obj
        end
-----------------------------------------------

    get_remote_obj : CORBA_OBJECT is

        do
            result := remote_obj
        end
-----------------------------------------------

   get_skel : IMPLEMENTATION_BASE is

        do
            result := skel
        end
-----------------------------------------------

    set_skel (base : IMPLEMENTATION_BASE) is

        do
            skel := base
        end
-----------------------------------------------

    save : BOOLEAN is

        do
            result := dosave
        end
-----------------------------------------------

    set_save (s : BOOLEAN) is

        do
            dosave := s
        end
-----------------------------------------------

    get_persistent : BOOLEAN is

        do
            result := persistent
        end
-----------------------------------------------

    set_persistent (p : BOOLEAN) is

        do
            persistent := p
        end
-----------------------------------------------

    get_state : INTEGER is

        do
            result := state
        end
-----------------------------------------------

    set_state (s: INTEGER) is

        do
            state := s
        end
-----------------------------------------------
feature { NONE } -- Implementation

    id         : ARRAY[INTEGER]
    impl       : IMPLEMENTATION_DEFINITION
    iface      : CORBA_INTERFACEDEF
    local_obj  : CORBA_OBJECT
    remote_obj : CORBA_OBJECT
    skel       : IMPLEMENTATION_BASE
    dosave     : BOOLEAN
    state      : INTEGER
    persistent : BOOLEAN

end -- class OBJECT_RECORD

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
