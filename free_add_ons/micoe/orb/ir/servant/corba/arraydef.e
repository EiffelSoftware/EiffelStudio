indexing

description: "the class that represents an array definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_ARRAYDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
   CORBA_ARRAYDEF_SKEL
      rename
	 make as make_skel
      end;
   CORBA_IDLTYPE_IMPL
      rename
	 make as make_IDLType
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      redefine -- added
	 type
      end

creation
    make

feature
   
   make is
	 -- You may give this creation procedure
	 -- any arguments needed.
      
      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_IDLType
	 -- put any other initialization needed here.
	 create private_dk.make (CORBA_dk_Array)
	 private_length := 0
      end
   
   ------------
   
   length : INTEGER is
      
      do
	 result := private_length
      ensure then
         result_notnegative : result >= 0
      end
   
   ------------
   
   set_length (value : INTEGER) is

      do
	 private_length := value
      end
   
   ------------
   
   element_type : CORBA_TYPECODE is
      
      do
	 check -- obsolete if class invariant works
	    element_typedef_nonvoid : private_element_type_def /= void
	 end
	 result := private_element_type_def.type
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   element_type_def : CORBA_IDLTYPE is
      
      do
	 result := private_element_type_def
      end
   
   ------------
   
   set_element_type_def (value : CORBA_IDLTYPE) is
      
      do
	 private_element_type_def := value
      end
   
   ------------
   
   type : CORBA_TYPECODE is
      
      do
         create {ARRAY_TYPECODE} result.make
      ensure then
         result_nonvoid : result /= void
      end
   
feature {NONE}

   private_length           : INTEGER
   private_element_type_def : CORBA_IDLTYPE

invariant
   -- element_type_def_nonvoid : private_element_type_def /= void
   length_notnegative : private_length >= 0

end -- class CORBA_ARRAYDEF_IMPL

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
