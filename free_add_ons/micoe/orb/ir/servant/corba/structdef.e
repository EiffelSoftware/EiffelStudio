indexing

description: "the class that represents a string definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_STRUCTDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_STRUCTDEF_SKEL
      rename
	 make as make_skel
      end;
   CORBA_TYPEDEFDEF_IMPL
      rename
	 make as make_TypedefDef
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      redefine -- added
	 type
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
	 id_nonvoid : id_par /= void
	 name_nonvoid : name_par /= void
	 version_nonvoid : version_par /= void
	 members_not_void : members_par /= void 
      
      local
         intf : INTF_REPOS

      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_TypedefDef (defined_in_par)
	 make_Container
	 -- put any other initialization needed here.
	 
         if is_structmember_duplicated (members_par) 
            or else is_recursion_structmember_bad (members_par) then
            create intf.make
            raise_exception (intf)
         else
            create private_dk.make (CORBA_dk_Struct)
            private_id := id_par
            private_name := name_par
            private_version := version_par
            private_members := members_par
         end
      end
   
   ------------
   
   members : CORBA_STRUCTMEMBERSEQ is
      
      do
	 result := clone (private_members)
      ensure then
	 result_nonvoid : result /= void
      end
   
   ------------
   
   set_members (value : CORBA_STRUCTMEMBERSEQ) is

      local
         intf : INTF_REPOS
         
      do
	 if is_recursion_structmember_bad (value)
          or else is_structmember_duplicated (value) then
            create intf.make
            raise_exception (intf)
         else
            private_members := value
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
            result := create_struct_tc (private_name,
                                        private_id,
                                        mems)
        end
   
feature {NONE}
   
   private_members : CORBA_STRUCTMEMBERSEQ
   private_done    : BOOLEAN
   
	 ------------
   
   is_recursion_unionmember_bad (mem : CORBA_UNIONMEMBERSEQ) : BOOLEAN is
	 -- Do we have any duplicate names in the member list?
      
      local
	 i, j : INTEGER
	 
      do
	 from
	    i := 1
	 until
	    i > mem.length or else result
	 loop
	    from
	       j := i + 1
	    until
	       j > mem.length or else result
	    loop
	       if equal (mem.get_value (i).name,
			 mem.get_value (j).name) then
                  result := true
	       end
	       j := j + 1
	    end
	    i := i + 1
	 end -- loop i
      end
   
   ------------
   
   is_recursion_structmember_bad (mem : CORBA_STRUCTMEMBERSEQ) : BOOLEAN is
	 -- Do we have any duplicate names in the member list?
      
      local
	 i, j        : INTEGER
	 s           : CORBA_STRUCTDEF
	 u           : CORBA_UNIONDEF
	 nested_mem  : CORBA_STRUCTMEMBERSEQ
	 nested_mem2 : CORBA_UNIONMEMBERSEQ
	 
      do
	 from
	    i := 1
	 until
	    i > mem.length or else result
	 loop
	    s := CORBA_StructDef_narrow (mem.get_value(i).type_def)
	    if s /= void then
	       if s.is_equivalent (current) then
		  result := true
	       end
	       nested_mem := s.members
	       result := is_recursion_structmember_bad (nested_mem)
	    end
	    i := i + 1
	 end -- loop i
	 u := CORBA_UnionDef_narrow (mem.get_value (i).type_def)
	 if u /= void then
	    nested_mem2 := u.members
	    result := is_recursion_unionmember_bad (nested_mem2)
	 end
      end
   
   ------------
   
   is_unionmember_duplicated (mem : CORBA_UNIONMEMBERSEQ) : BOOLEAN is
	 -- Check for bad form of recursion
      
      local
	 i, j        : INTEGER
	 s           : CORBA_STRUCTDEF
	 u           : CORBA_UNIONDEF
	 nested_mem  : CORBA_STRUCTMEMBERSEQ
	 nested_mem2 : CORBA_UNIONMEMBERSEQ
	 
      do
	 from
	    i := 1
	 until
	    i > mem.length or else result
	 loop
	    s := CORBA_StructDef_narrow (mem.get_value (i).type_def)
	    if s /= void then
	       if s.is_equivalent (current) then
		  result := true
	       end
	       nested_mem := s.members
	       result := is_recursion_structmember_bad (nested_mem)
	    end
	    i := i + 1
	 end -- loop i
	 u := CORBA_UnionDef_narrow (mem.get_value (i).type_def)
	 if u /= void then
	    nested_mem2 := u.members
	    result := is_recursion_unionmember_bad (nested_mem2)
	 end
      end
   
   ------------
   
   is_structmember_duplicated (mems : CORBA_STRUCTMEMBERSEQ) : BOOLEAN is
      
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
               if equal (mems.get_value (i).name,
                         mems.get_value (j).name) then
                  result := true
               end
               j := j + 1
            end
            i := i + 1
         end
      end

invariant
   -- members_nonvoid : private_members /= void

end -- class CORBA_STRUCTDEF_IMPL

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
