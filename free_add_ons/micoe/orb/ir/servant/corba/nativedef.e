indexing

description: "the class that represents a native definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_NATIVEDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
   CORBA_NATIVEDEF_SKEL
      rename
	 make as make_skel
      end;
   CORBA_TYPEDEFDEF_IMPL
      rename
	 make as make_TypedefDef
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      end;
   TYPECODE_STATICS
      undefine
	 is_equal, copy
      end

creation
    make

feature

    make (defined_in_par : CORBA_CONTAINER;
	  id_par, name_par, version_par: STRING) is
        -- You may give this creation procedure
        -- any arguments needed.

      require
	 defined_in_not_void : defined_in_par /= void
	 id_nonvoid : id_par /= void
	 name_nonvoid : name_par /= void
	 version_nonvoid : version_par /= void

        do
            make_skel
            -- if any parent's creation procedure
            -- takes arguments add them below.
            make_TypedefDef (defined_in_par)
            -- put any other initialization needed here.
	    create private_dk.make (CORBA_dk_Native)
	    private_id := id_par
	    private_name := name_par
	    private_version := version_par
--	    private_type := create_native_tc (private_id, private_name)
        end

end -- class CORBA_NATIVEDEF_IMPL

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
--                                                                    
----
------------------------------------------------------------------------
