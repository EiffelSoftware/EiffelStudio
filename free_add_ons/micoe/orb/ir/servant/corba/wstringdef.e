indexing

description: "represents a wstring definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_WSTRINGDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_WSTRINGDEF_SKEL
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
	 create private_dk.make (CORBA_dk_Wstring)
	 private_bound := 0
      end
   
   ------------
   
   bound : INTEGER is
      
      do
	 result := private_bound
      ensure then
         bound_nonnegative : result >= 0
      end
   
   ------------
   
   set_bound (value : INTEGER) is
      
      local
	 bad_param : BAD_PARAM
	 
      do
	 if value = 0 then
	    create bad_param.make
	    raise_exception (bad_param)
	 else
	    private_bound := bound
	 end
      end

----------------------

    type : CORBA_TYPECODE is

        do
            create {WSTRING_TYPECODE} result.make
        end

----------------------   
feature {NONE}
   
   private_bound : INTEGER

invariant
   bound_nonnegative : private_bound >= 0

end -- class CORBA_WSTRINGDEF_IMPL

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
