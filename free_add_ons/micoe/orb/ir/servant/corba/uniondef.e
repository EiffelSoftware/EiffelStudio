indexing

description: "the class that represents an union definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_UNIONDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_UNIONDEF_SKEL
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
	 discr : CORBA_IDLTYPE; members_par : CORBA_UNIONMEMBERSEQ) is
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
	 
	 if is_unionmember_duplicated (members)
            or else is_recursion_unionmember_bad (members) then
            create intf.make
            raise_exception (intf)
         else
            create private_dk.make (CORBA_dk_Union)
            private_id := id_par
            private_name := name_par
            private_version := version_par
            private_discr := discr
            private_members := members_par
            
            create private_old_member_types.make (true)
         end
      end
   
   ------------
   
   discriminator_type : CORBA_TYPECODE is
      
      do
	 result := private_discr.type
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   discriminator_type_def : CORBA_IDLTYPE is
      
      do
	 result := private_discr
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_discriminator_type_def (value : CORBA_IDLTYPE) is

      do
	 private_discr := value
      end
   
   ------------
   
   members : CORBA_UNIONMEMBERSEQ is
      
      do
	 result := clone(private_members)
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_members (value : CORBA_UNIONMEMBERSEQ) is
      
      local
         intf : INTF_REPOS
         
      do
         if is_unionmember_duplicated (value)
            or else is_recursion_unionmember_bad (value)
            or else is_case_explicit_default_bad (value) then
            create intf.make
            raise_exception (intf)
         else
            private_members := value
         end
      end
   
   ------------
   
    type : CORBA_TYPECODE is
   
        local
            i, n : INTEGER
            mems : INDEXED_LIST [CORBA_UNIONMEMBER]
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
            result := create_union_tc (private_id,
                                       private_name,
                                       private_discr.type,
                                       mems)

        end
   
feature {NONE}
   
   private_discr                       : CORBA_IDLTYPE
   private_members                     : CORBA_UNIONMEMBERSEQ
   private_old_member_types            : INDEXED_LIST[CORBA_TYPECODE]
   private_var, private_old_discr_type : CORBA_TYPECODE
   private_done                        : BOOLEAN
   
	 ------------
   
   is_recursion_unionmember_bad (mems : CORBA_UNIONMEMBERSEQ) : BOOLEAN is
      
      local
         i : INTEGER
         s : CORBA_STRUCTDEF
         u : CORBA_UNIONDEF

      do
         from 
            i := 1
         until
            i > mems.length or else result
         loop
            s := CORBA_StructDef_narrow (mems.get_value (i).type_def)
            if s /= void and then is_recursion_structmember_bad (s.members) then
               result := true
            end
            if not result then
               u := CORBA_UnionDef_narrow (mems.get_value (i).type_def)
               if u /= void then
                  if u.is_equivalent (current)
                     or else is_recursion_unionmember_bad (u.members) then
                     result := true
                  end
               end
            end
            i := i + 1
         end -- loop i
      end
   
   ------------
   
   is_recursion_structmember_bad  (mems : CORBA_STRUCTMEMBERSEQ) : BOOLEAN is
      
      local
         i : INTEGER
         s : CORBA_STRUCTDEF
         u : CORBA_UNIONDEF

      do
         from 
            i := 1
         until
            i > mems.length or else result
         loop
            s := CORBA_StructDef_narrow (mems.get_value (i).type_def)
            if s /= void and then is_recursion_structmember_bad (s.members) then
               result := true
            end
            if not result then
               u := CORBA_UnionDef_narrow (mems.get_value (i).type_def)
               if u /= void then
                  if u.is_equivalent (current)
                     or else is_recursion_unionmember_bad (u.members) then
                     result := true
                  end
               end
            end
            i := i + 1
         end -- loop i
      end
   
   ------------
   
   is_unionmember_duplicated (mems : CORBA_UNIONMEMBERSEQ) : BOOLEAN is
      
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
               if equal (mems.get_value (i), mems.get_value (j))
                  and then not mems.get_value (i).type_def.is_equivalent (mems.get_value (j).type_def) then
               result := true
               end
               if not result
                  and then equal (mems.get_value (i).label,
                                  mems.get_value (j).label) then
               result := true
               end
               j := j + 1
            end -- loop j
            i := i + 1
         end -- loop i
      end
   
   ------------
   
   is_case_explicit_default_bad (mems : CORBA_UNIONMEMBERSEQ) : BOOLEAN is
      
      local
         i, num_discr_vals : INTEGER
         tc, discr_tc      : CORBA_TYPECODE
         break             : BOOLEAN
         ca                : CORBA_ANY

      do
         from 
            i := 1
         until
            i > mems.length or else break
         loop
            tc := mems.get_value (i).type -- ?? label.type?
            if tc.kind = tk_octet then
               break := true
            else
               i := i + 1
            end
         end -- loop i
         
         if i < mems.length then
            -- Determine the number of possible values for the 
            -- discriminator type
            discr_tc := private_discr.type
            inspect discr_tc.kind
            when tk_boolean then
               num_discr_vals := 2
            when tk_char then
               num_discr_vals := 256
            when tk_enum then
                num_discr_vals := discr_tc.member_count
           else
              -- For all other discriminator types we just assume a 
              -- ridiciously high value. Its highly unlikely that 
              -- there exists a IDL-union specification with >> 1000 cases.
              num_discr_vals := 9999999
            end -- inspect
            
            if num_discr_vals = mems.length then
               result := true
            end
         end
      end
   
      
invariant
   -- discr_nonvoid            : private_discr /= void 
   -- members_nonvoid          : private_members /= void 
   -- old_member_types_nonvoid : private_old_member_types /= void 
   -- var_nonvoid              : private_var /= void 
   -- old_discr_type_nonvoid   : private_old_discr_type /= void 

end -- class CORBA_UNIONDEF_IMPL

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
