indexing
   
description: "the class that represents a member of a value type in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_VALUEMEMBERDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    CORBA_VALUEMEMBERDEF_SKEL
        rename
            make as make_skel
        end;
    CORBA_CONTAINED_IMPL
        rename
            make as make_Contained
        undefine
            type_name, consume, valid_message_type,
            repoid, template, dispatcher, doinvoke, make_skel
        end

creation
   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER;
         id_par, name_par, version_par: STRING;
         type_par : CORBA_IDLTYPE; access_par : INTEGER) is
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
         make_Contained (defined_in_par)
         -- put any other initialization needed here.
         create private_dk.make (CORBA_dk_ValueMember)
         private_id := id_par
         private_name := name_par
         private_version := version_par
         private_type_def := type_par
         private_access := access_par
      end
   
   ------------
   
   type : CORBA_TYPECODE is
      
      do
         result := private_type_def.type
      end
   
   ------------
   
   type_def : CORBA_IDLTYPE is
      
      do
         result := private_type_def
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_type_def (value : CORBA_IDLTYPE) is
      
      do
         private_type_def := value
      end

   ------------
   
   access : INTEGER is
      
      do
         result := private_access
      end
   
   ------------
   
   set_access (value : INTEGER) is
      
      do
         private_access := value
      end

   ------------

   describe : CORBA_CONTAINED_DESCRIPTION is

      do
      end

feature {NONE}
   
   private_type_def : CORBA_IDLTYPE
   private_access   : INTEGER
   
invariant
   -- type_def_nonvoid : private_typedef /= void

end -- class CORBA_VALUEMEMBERDEF_IMPL

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
