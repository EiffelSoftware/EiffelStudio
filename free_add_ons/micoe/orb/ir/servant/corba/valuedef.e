indexing

description: "the class that represents a value type definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_VALUEDEF_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_VALUEDEF_SKEL
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
      redefine -- added
         type
      end
   
creation
   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER;
	 id_par, name_par, version_par: STRING;
	 is_custom_par, is_abstract_par : BOOLEAN;
	 base_value_par : CORBA_VALUEDEF;
	 is_truncatable_par : BOOLEAN;
	 abstract_base_values_par : CORBA_VALUEDEFSEQ;
	 supported_interfaces_par : CORBA_INTERFACEDEFSEQ;
	 inits : CORBA_INITIALIZERSEQ)  is
	 -- You may give this creation procedure
	 -- any arguments needed.
      
      require
	 defined_in_not_void : defined_in_par /= void
	 id_nonvoid : id_par /= void
	 name_nonvoid : name_par /= void
	 version_nonvoid : version_par /= void
	 abstract_base_values_not_void : abstract_base_values_par /= void
	 supported_interfaces_not_void : supported_interfaces_par /= void
         inits_nonvoid : inits /= void
                         
      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_Container
	 make_Contained (defined_in_par)
	 make_IDLType
	 -- put any other initialization needed here.
	 create private_dk.make (CORBA_dk_Value)
	 private_id := id_par
	 private_name := name_par
	 private_version := version_par
	 private_is_custom := is_custom_par
	 private_is_abstract := is_abstract_par
	 private_base_value := base_value_par
	 private_is_truncatable := is_truncatable_par
	 private_abstract_base_values := abstract_base_values_par
	 private_supported_interfaces := supported_interfaces_par
	 set_initializers (inits)
      end
   
   ------------
   
   supported_interfaces : CORBA_INTERFACEDEFSEQ is
      
      do
         result := private_supported_interfaces
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_supported_interfaces (value : CORBA_INTERFACEDEFSEQ) is
      
      do
         private_supported_interfaces := value
      end
   
   ------------
   
   initializers : CORBA_INITIALIZERSEQ is
      
      do
         create result.make_default
         result.copy (private_initializers)
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_initializers (value : CORBA_INITIALIZERSEQ) is
      
      local
         i, j : INTEGER
         
      do
         private_initializers := value
         from
            i := 1
         until
            i > private_initializers.length
         loop
            from
               j := 1
            until
               j > private_initializers.get_value (i).members.length
            loop
               private_initializers.get_value (i).members.get_value (j).set_type (private_initializers.get_value (i).members.get_value (j).type)
               j := j + 1
            end -- loop j
            i := i + 1
         end -- loop i
      end
   
   ------------
   
   base_value : CORBA_VALUEDEF is
      
      do
         result := private_base_value
      end
   
   ------------
   
   set_base_value (value : CORBA_VALUEDEF) is
      
      do
         private_base_value := value
      end
   
   ------------
   
   abstract_base_values : CORBA_VALUEDEFSEQ is
      
      do
         result.make_default
         result.copy (private_abstract_base_values)
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_abstract_base_values (value : CORBA_VALUEDEFSEQ) is
      
      do
         private_abstract_base_values := value
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
   
   is_custom : BOOLEAN is
      
      do
         result := private_is_custom
      end
   
   ------------
   
   set_is_custom (value : BOOLEAN) is
      
      do
         private_is_custom := value
      end
   
   ------------
   
   is_truncatable : BOOLEAN is
      
      do
         result := private_is_truncatable
      end
   
   ------------
   
   set_is_truncatable (value : BOOLEAN) is
      
      do
         private_is_truncatable := value
      end
   
   ------------
   
   idl_is_a (idl_id : STRING) : BOOLEAN is
      
      local
	 i : INTEGER
	 
      do
	 if equal (private_id, idl_id) or else
            equal ("IDL:omg.org/CORBA/ValueBase:1.0", idl_id) then
	    result := true
	 end
	 
	 from
	    i := 1
	 until
	    i > private_abstract_base_values.length or else result
	 loop
	    if private_abstract_base_values.get_value (i).idl_is_a (idl_id) then
	       result := true
	    end
	    i := i + 1
	 end -- loop i
	 
         -- if private_supported_interfaces /= void
         --    and then private_supported_interfaces.idl_is_a (idl_id) then
         --    result := true
         -- end
	 
	 if private_base_value /= void
	    and then private_base_value.idl_is_a (idl_id) then
	    result := true
	 end
      end
   
   ------------
   
   describe_value : CORBA_VALUEDEF_FULLVALUEDESCRIPTION is
      
      do
      ensure then
         result_nonvoid : result /= void
      end

   ------------
   
   create_value_member (idl_id : STRING;
                        idl_name : STRING;
                        idl_version : STRING;
                        idl_type : CORBA_IDLTYPE;
                        access : INTEGER) : CORBA_VALUEMEMBERDEF is
      
      do
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   create_attribute (idl_id : STRING;
                     idl_name : STRING;
                     idl_version : STRING;
                     idl_type : CORBA_IDLTYPE;
                     mode : CORBA_ATTRIBUTEMODE) : CORBA_ATTRIBUTEDEF is
      
      do
      ensure then
         result_nonvoid : result /= void
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
      
      do
      ensure then
         result_nonvoid : result /= void
      end

   ------------
   
   type : CORBA_TYPECODE is
      
      do
      end
 
   ------------
   
   describe : CORBA_CONTAINED_DESCRIPTION is
      
      local
      	 d         : CORBA_VALUEDESCRIPTION
	 ca        : CORBA_ANY
	 base      : CORBA_VALUEDEF
	 bases2    : CORBA_VALUEDEFSEQ
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
         --	    supported := v.supported_interfaces
         base := base_value
         bases2 := abstract_base_values
         --	    create d.make(private_name, private_id,
         --			   v.is_abstract, v.is_custom,
         --			   def_in_id, private_version,
         --			   supported, bases, v.is_truncatable,
         --			   base)
         create ca.make
         d.struct_to_any (ca)
         result.set_value (ca)
      end

feature {NONE}
   
   private_is_custom, private_is_abstract,
   private_is_truncatable       : BOOLEAN
   private_base_value           : CORBA_VALUEDEF
   private_abstract_base_values : CORBA_VALUEDEFSEQ
   private_supported_interfaces : CORBA_INTERFACEDEFSEQ
   private_initializers         : CORBA_INITIALIZERSEQ
   private_rec_type             : CORBA_TYPECODE
   
         ------------
   
   is_ops_overloaded_ops (name_par, id_par : STRING) : BOOLEAN is
      
      do
      end

end -- class CORBA_VALUEDEF_IMPL

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
