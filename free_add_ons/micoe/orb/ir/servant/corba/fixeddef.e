indexing

description: "the class that represents a fixed definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_FIXEDDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_FIXEDDEF_SKEL
      rename
	 make as make_skel
      end;
   CORBA_IDLTYPE_IMPL
      rename
	 make as make_IDLType
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
   
   make is
	 -- You may give this creation procedure
	 -- any arguments needed.
      
      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_IDLType
	 -- put any other initialization needed here.
	 create private_dk.make (CORBA_dk_Fixed)
	 private_digits := 0
	 private_scale := 0
      end
   
   ------------
   
   digits : INTEGER is
      
      do
	 result := private_digits
      ensure then
         result_nonvoid : result >= 0
      end
   
   ------------
   
   set_digits (value : INTEGER) is

      do
	 private_digits := value
      end
   
   ------------
   
   scale : INTEGER is
      
      do
	 result := private_scale
      ensure then
         result_nonvoid : result >= 0
      end
   
   ------------
   
   set_scale (value : INTEGER) is
      
      do
	 private_scale := value
      end
   
   ----------------------

   type : CORBA_TYPECODE is
      
        do
            result := create_fixed_tc (private_digits, private_scale)
        end

feature {NONE}
   
   private_digits, private_scale : INTEGER

invariant
   digits_nonnegative : private_digits >= 0
   scale_nonnegative  : private_scale >= 0
   
end -- class CORBA_FIXEDDEF_IMPL

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
