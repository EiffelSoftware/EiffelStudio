indexing

description: "the class that represents an enum definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_ENUMDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_ENUMDEF_SKEL
        rename
	   make as make_skel
        end;
	CORBA_TYPEDEFDEF_IMPL
      rename
	 make as make_TypedefDef
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      redefine
        type
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
         version_nonvoid : version /= void

      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_TypedefDef (defined_in_par)
	 -- put any other initialization needed here.
	 create private_dk.make (CORBA_dk_Enum)
	 private_id := id_par
	 private_name := name_par
	 private_version := version_par
	 
	 create private_members.make_default
      end
   
   ------------
   
   members : CORBA_ENUMMEMBERSEQ is
      
      do
	 result := private_members
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_members (value : CORBA_ENUMMEMBERSEQ) is
      
      local
	 tc   : CORBA_TYPECODE
	 i, j : INTEGER
         n    : INTEGER
	 intf : INTF_REPOS
	 
      do
	 private_members := value
         	 
	 -- See if we have any duplicate names in the member list
	 from
	    i := 1
            n := private_members.length
	 until
	    i > n or else intf /= void
	 loop
	    from
	       j := i + 1
	    until
	       j > n or else intf /= void
	    loop
	       if equal (private_members.get_value (i),
			 private_members.get_value (j)) then
		  create intf.make
		  raise_exception (intf)
	       end
	       j := j + 1
	    end -- loop j
	    i := i + 1
	 end -- loop i
      end 
   ----------------------
   
   type : CORBA_TYPECODE is
      
      local
         i, n : INTEGER
         mems : ARRAY [STRING]

      do
         from
            i := 1
            n := private_members.length
            create mems.make (i, n)
         until
            i > n
         loop
            mems.put (private_members.get_value (i), i)
            i := i + 1
         end
         result := create_enum_tc (private_id,
                                   private_name,
                                   mems)
      end

feature {NONE}
   
   private_members : CORBA_ENUMMEMBERSEQ

invariant
   -- members_nonvoid : private_member /= void

end -- class CORBA_ENUMDEF_IMPL
	
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
