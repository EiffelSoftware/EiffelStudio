indexing

description: "the class that represents a exception definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_EXCEPTIONDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_EXCEPTIONDEF_SKEL
      rename
	 make as make_skel
      end;
   CORBA_CONTAINED_IMPL
      rename
	 make as make_Contained
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      end;
   CORBA_CONTAINER_IMPL
      rename
	 make as make_Container
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel,
	 ib_make, unused_doinvoke
      end
   
creation
   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER;
	 id_par, name_par, version_par: STRING;
	 members_par : CORBA_STRUCTMEMBERSEQ) is
	 -- You may give this creation procedure
	 -- any arguments needed.
      
      require
	 defined_in_not_void : defined_in_par /= void
	 -- id_nonvoid : id_par /= void
	 -- name_nonvoid : name_par /= void
	 -- version_nonvoid : version_par /= void

      local
         intf : INTF_REPOS

      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_Contained (defined_in_par)
	 make_Container
	 -- put any other initialization needed here.
	 
         if is_duplicated_member (members_par) then
            create intf.make
            raise_exception (intf)
         else
            create private_dk.make (CORBA_dk_Exception)
            private_id := id_par
            private_name := name_par
            private_version := version_par
            private_members := members_par
            if private_members = void then
               create private_members.make_default
            end
         end
      end
   
   ------------
   
   type : CORBA_TYPECODE is
      
      local
         mems : INDEXED_LIST [CORBA_STRUCTMEMBER]
         i, n : INTEGER
         
      do
         from
            create mems.make (false)
            i := 1
            n := private_members.length
         until
            i > n
         loop
            mems.append (private_members.get_value (i))
            i := i + 1
         end
         result := create_exception_tc (private_id,
                                        private_name,
                                        mems)
      end      
   
   ------------
   
   members : CORBA_STRUCTMEMBERSEQ is
      
      do
	 result := private_members
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_members (value : CORBA_STRUCTMEMBERSEQ) is
      
      local
         intf : INTF_REPOS

      do
         if is_duplicated_member (value) then
            create intf.make
            raise_exception (intf)
         else
            private_members := value
         end
      end
    
   ------------
   
   describe : CORBA_CONTAINED_DESCRIPTION is

      local
	 d        : CORBA_EXCEPTIONDESCRIPTION
	 ca        : CORBA_ANY
	 def_in_id : STRING
	 def_in    : CORBA_CONTAINED

      do
	 def_in := CORBA_Contained_narrow (private_defined_in)
	 if def_in = void then
	    def_in_id := def_in.id
	 else
	    -- The Repository doesn't have am RepoID, because it is 
	    -- not a Contained.
	    def_in_id := ""
	 end  
         create result.make_default
	 result.set_kind (private_dk)
         create d.make(private_name, private_id, def_in_id,
                       private_version, type)
         create ca.make
         d.struct_to_any (ca)
         result.set_value (ca)
      end

feature {NONE}
   
   private_members : CORBA_STRUCTMEMBERSEQ
   private_type    : CORBA_TYPECODE
   
	 ------------
   
   is_duplicated_member (mems : CORBA_STRUCTMEMBERSEQ) : BOOLEAN is
      
      local
         i, j : INTEGER

      do
         from
            i := 1
         until
            i > mems.length or else result
         loop
            from
               j := i + 1
            until
               j > mems.length or else result
            loop
               if equal (mems.get_value (i), mems.get_value (j)) then
                         result := true
               end
               j := j + 1
            end -- loop j
            i := i + 1
         end -- loop i
      end

invariant
   -- members_nonvoid : private_members /= void

end -- class CORBA_EXCEPTIONDEF_IMPL

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
