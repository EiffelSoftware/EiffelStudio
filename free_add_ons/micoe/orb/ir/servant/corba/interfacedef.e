indexing

description: "the class that represents an interface definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_INTERFACEDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_INTERFACEDEF_SKEL
      rename
	 make as make_skel
      end;
   CORBA_CONTAINER_IMPL
      rename
	 make as make_Container
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      end;
   CORBA_CONTAINED_IMPL
      rename
	 make as make_Contained
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel,
	 ib_make, unused_doinvoke
      end;
   CORBA_IDLTYPE_IMPL
      rename
	 make as make_IDLType
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel,
	 ib_make, unused_doinvoke
      end;
   TYPECODE_STATICS -- added
      undefine
	 is_equal, copy
      end;
   TYPECODE_CONSTANTS
      undefine
	 is_equal, copy
      end;
   
creation
   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER;
	 id_par, name_par, version_par: STRING;
	 base_interfaces_par : CORBA_INTERFACEDEFSEQ;
	 is_abstract_par : BOOLEAN) is
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
	 make_Container
	 make_Contained (defined_in_par)
	 make_IDLType
	 -- put any other initialization needed here.
	 create private_dk.make (CORBA_dk_Interface)
	 private_id := id_par
	 private_name := name_par
	 private_version := version_par
	 private_base_interfaces :=  base_interfaces_par
	 if private_base_interfaces = void then 
	    create private_base_interfaces.make_default
	 end
	 private_is_abstract := is_abstract_par
      end
   
   ------------
   
   type : CORBA_TYPECODE is
      
      do
         create {OBJREF_TYPECODE} result.make
      ensure then
         result_nonvoid : result /= void
      end
   
   -------------   
   
   base_interfaces : CORBA_INTERFACEDEFSEQ is
      
      do
	 result := private_base_interfaces
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_base_interfaces (value : CORBA_INTERFACEDEFSEQ) is
      
      do
	 private_base_interfaces := value
      end
   
   ------------
   
   is_abstract : BOOLEAN is
      
      do
	 result := private_is_abstract
      end
   
   ------------
   
   set_is_abstract (value : BOOLEAN) is
      
      do
	 private_is_abstract := value
      end
   
   ------------
   
   idl_is_a (interface_id : STRING) : BOOLEAN is

      local 
	 i : INTEGER
	 
      do
	 if equal (private_id, interface_id) or else
            equal ("IDL:omg.org/CORBA/Object:1.0", interface_id) or else
	    (equal ("IDL:omg.org/CORBA/AbstractBase:1.0", interface_id)
             and then private_is_abstract) then
	    result := true
	 end
	 
	 from
	    i := 1
	 until 
	    i > private_base_interfaces.length
               or else result
	 loop
	    if private_base_interfaces.get_value (i).idl_is_a (interface_id) then
	       result := true
	    end
	    i := i + 1
	 end -- loop i
      end
   
   ------------
   
   describe_interface : CORBA_INTERFACEDEF_FULLINTERFACEDESCRIPTION is
      
      do
      end
   
   ------------
   
   create_attribute (idl_id : STRING;
		     idl_name : STRING;
		     idl_version : STRING;
		     idl_type : CORBA_IDLTYPE;
		     mode : CORBA_ATTRIBUTEMODE) : CORBA_ATTRIBUTEDEF is

      local
         bad_param : BAD_PARAM
	 
      do
         if is_overloaded_ops (name, id) then
            create bad_param.make
            raise_exception (bad_param)
         else
            create {CORBA_ATTRIBUTEDEF_IMPL} result.make (current, idl_id,
                                                          idl_name,
                                                          idl_version,
                                                          idl_type,
                                                          mode)
            private_contents.set_value (result, private_contents.length + 1)
         end
      end
   
   ------------
   
   create_operation (idl_id : STRING;
		     idl_name : STRING;
		     idl_version : STRING;
		     idl_result : CORBA_IDLTYPE;
		     mode : CORBA_OPERATIONMODE;
		     params : CORBA_PARDESCRIPTIONSEQ;
		     exceptions : CORBA_EXCEPTIONDEFSEQ;
		     contexts : CORBA_CONTEXTIDSEQ) : CORBA_OPERATIONDEF is
      
      local
	 intf      : INTF_REPOS
         bad_param : BAD_PARAM
	 result_tc : CORBA_TYPECODE
	 i         : INTEGER
	 
      do
         if is_overloaded_ops (idl_name, idl_id) then
            create bad_param.make
            raise_exception (bad_param)
         else
            if mode.value = CORBA_OP_ONEWAY then
               -- Check that oneway operations have no result, no out, 
               -- inout paramters an no raises expression
               result_tc := idl_result.type
               if result_tc.kind /= Tk_void then
                  create intf.make
                  raise_exception (intf)
               elseif exceptions.length = 0 then
                  create intf.make
                  raise_exception (intf)
               else
                  from
                     i := 1
                  until 
                     i > params.length
                  loop
                     if params.get_value(i).mode.value /= CORBA_PARAM_IN then
                        create intf.make
                        raise_exception (intf)
                     end
                  end -- loop i
               end -- if
            end -- if ...
            
            if intf = void then
               i := private_contents.length
               create {CORBA_OPERATIONDEF_IMPL} result.make (current, idl_id,
                                                             idl_name,
                                                             idl_version,
                                                             idl_result, 
                                                             mode, params,
                                                             exceptions,
                                                             contexts)
               private_contents.set_value (result, i)
            end -- if
         end -- if
      end
    
   ------------
   
   describe : CORBA_CONTAINED_DESCRIPTION is
      
      local
	 d         : CORBA_INTERFACEDESCRIPTION
	 ca        : CORBA_ANY
	 bases     : CORBA_INTERFACEDEFSEQ
         j         : INTEGER
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
         bases := base_interfaces
         create d.make_default
         d.set_name (private_name)
         d.set_id (private_id)
         d.set_defined_in (def_in_id)
         d.set_version (private_version)
         from
            j := 1
         until
            j > bases.length
         loop
            d.base_interfaces.set_value (bases.get_value (j).id, j)
            j := j + 1
         end -- loop j	    
         create ca.make
         d.struct_to_any (ca)
         result.set_value(ca)
      end	    

feature {NONE}
   
   private_base_interfaces : CORBA_INTERFACEDEFSEQ
   private_is_abstract     : BOOLEAN
   
	 ------------
   
   is_overloaded_ops (name_par, id_par : STRING) : BOOLEAN is
      -- id_par unused ??
      local
	 cont           : CORBA_CONTAINEDSEQ
	 i              : INTEGER
	 con            : CORBA_CONTAINED
	 dk             : CORBA_DEFINITIONKIND

      do
	 create dk.make (CORBA_dk_all)
	 cont := contents (dk, false)

	 from
	    i := 1
	 until
	    i > cont.length or else result
	 loop
	    con := cont.get_value (i)
	    if con.def_kind.value = CORBA_dk_Operation or else
	       con.def_kind.value = CORBA_dk_Attribute then
	       if equal (con.name, name_par) then
                  result := true
	       end
	    end -- if ...
	    i := i + 1
	 end -- loop i
      end
   
invariant
   -- base_interfaces_nonvoid :  private_base_interfaces /= void

end -- class CORBA_INTERFACEDEF_IMPL

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
