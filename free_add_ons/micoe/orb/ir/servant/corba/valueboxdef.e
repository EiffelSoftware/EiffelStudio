indexing

description: "the class that represents a boxed value type in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_VALUEBOXDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    CORBA_VALUEBOXDEF_SKEL
        rename
            make as make_skel
        end;
    CORBA_TYPEDEFDEF_IMPL
        rename
            make as make_TypedefDef
        undefine
            type_name, consume, valid_message_type,
            repoid, template, dispatcher, doinvoke, make_skel
        end

creation
   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER;
         id_par, name_par, version_par: STRING;
         original_type_def_par : CORBA_IDLTYPE) is
         -- You may give this creation procedure
         -- any arguments needed.
      
      require
	 defined_in_not_void : defined_in_par /= void
	 id_nonvoid : id_par /= void
	 name_nonvoid : name_par /= void
	 version_nonvoid : version_par /= void
	 original_type_def_not_void : original_type_def_par /= void
                                      
      do
         make_skel
         -- if any parent's creation procedure
         -- takes arguments add them below.
         make_TypedefDef (defined_in_par)
         -- put any other initialization needed here.
         private_id := id_par
         private_name := name_par
         private_version := version_par
         private_original_type := original_type_def_par
      end
   
   ------------
   
   original_type_def : CORBA_IDLTYPE is
      
      do
         result := private_original_type
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_original_type_def (value : CORBA_IDLTYPE) is
      
      do
         private_original_type := value
      end
   
feature {NONE}
   
   private_original_type     : CORBA_IDLTYPE
   private_old_original_type : CORBA_IDLTYPE
   private_done              : BOOLEAN

invariant
   -- original_type_nonvoid : private_original_type /= void
   
end -- class CORBA_VALUEBOXDEF_IMPL

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
