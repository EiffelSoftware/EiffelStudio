indexing

description: "base interface for all IR objetcs that contain others";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_CONTAINER_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_CONTAINER_SKEL
      rename
	 make as make_skel
      end;
   CORBA_IROBJECT_IMPL
      rename
	 make as make_IRObject
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      end;
   ORB_STATICS
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
	 make_IRObject
	 -- put any other initialization needed here.
	 create private_contents.make_default
      end
   
   ------------
   
   lookup (search_name : STRING) : CORBA_CONTAINED is
      
      local
         n, name,
	 first   : STRING
	 con     : CORBA_CONTAINED
	 cont    : CORBA_CONTAINER
	 repo    : CORBA_REPOSITORY
	 i       : INTEGER
	 
      do
         name := clone (search_name)
	 if not is_relative_scoped_name (name) then
	    -- We have to start our search from the toplevel 
	    -- repository
	    if private_dk.value /= CORBA_dk_Repository then
	       con := CORBA_Contained_narrow (current)
	       check
		  we_are_a_contained : con /= void
	       end
	       repo := con.containing_repository
	       result := repo.lookup (name)
	    end -- if
	 end -- if not is_relative_scoped_name 
	 
	 if result = void then
	    first := first_of_scoped_name (name)
	    strip_first_scope (name)
	    
	    from
	       i := 1
	    until
	       i > private_contents.length or else result /= void
	    loop
	       n := private_contents.get_value(i).name
	       if equal (n, first) then
		  if equal (name, "") then
		     -- Found
		     result := private_contents.get_value (i)
		  else
		     cont := CORBA_Container_narrow (private_contents.get_value (i))
		     if con /= void then
			result := cont.lookup (name)
		     end
		  end -- if equal (name, "")  ...
	       end -- if equal (n, first)
	       i := i + 1
	    end -- loop i
	 end -- if result = void ...
      end
   
   ------------
   
   contents (limit_type : CORBA_DEFINITIONKIND;
	     exclude_inherited : BOOLEAN) : CORBA_CONTAINEDSEQ is
      
      local
	 inherited : CORBA_CONTAINEDSEQ
	 i, j, k   : INTEGER
	 in,
	 supported : CORBA_INTERFACEDEF
	 bases     : CORBA_INTERFACEDEFSEQ
	 val, base : CORBA_VALUEDEF
	 bases2    : CORBA_VALUEDEFSEQ
	 
      do
	 create result.make_default
	 
	 from
	    i := 1
	    j := 1
	 until
	    i > private_contents.length
	 loop
	    if limit_type.value = CORBA_dk_all or else
	       equal (private_contents.get_value (i).def_kind,
		      limit_type) then
	       result.set_value (private_contents.get_value (i), j)
	       j := j + 1
	    end -- if ...
	    i := i + 1
	 end -- loop
	 
	 if not exclude_inherited
	    and then private_dk.value = CORBA_dk_Interface then
	    in := CORBA_InterfaceDef_narrow (current)
	    check
	       i_am_an_interface : in /= void
	    end
	    bases := in.base_interfaces
	    from
	       i := 1
	    until
	       i > bases.length
	    loop
	       inherited := bases.get_value (i).contents (limit_type, exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value (inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k
	       i := i + 1
	    end -- loop i
	 end -- if ...
	 
	 if not exclude_inherited
	    and then private_dk.value = CORBA_dk_Value then
	    val := CORBA_Valuedef_narrow (current)
	    check
	       i_am_a_value : val /= void
	    end
	    bases2 := val.abstract_base_values
	    from
	       i := 1
	    until
	       i > bases2.length
	    loop
	       inherited := bases2.get_value (i).contents (limit_type, exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value (inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k
	       i := i + 1
	    end -- loop
	
-- MICO seems to differ from the specification here:
--   supported_interface   instead of supported_interfaces
--	    supported := val.supported_interfaces
--	    if supported /= void then
--	       inherited := supported.contents (limit_type, exclude_inherited)
--	       from
--		  k := 1
--	       until
--		  k > inherited.length
--	       loop
--		  result.set_value (inherited.get_value(k), j)
--		  j := j + 1
--		  k := k + 1
--	       end -- loop k
--	    end -- if
	    
	    base := val.base_value
	    if base /= void then
	       inherited := base.contents (limit_type, exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value (inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k
	    end -- if ...
	 end -- if ...
      ensure then
	 result_nonvoid : result /= void
      end -- do
   
   ------------
   
   lookup_name (search_name : STRING;
		levels_to_search : INTEGER;
		limit_type : CORBA_DEFINITIONKIND;
		exclude_inherited : BOOLEAN) : CORBA_CONTAINEDSEQ is

      local
	 nested,
	 inherited : CORBA_CONTAINEDSEQ
	 i, j, k   : INTEGER
	 name      : STRING
	 bases     : CORBA_INTERFACEDEFSEQ
	 bases2    : CORBA_VALUEDEFSEQ
	 con       : CORBA_CONTAINER
	 in,
	 supported : CORBA_INTERFACEDEF
	 val, base : CORBA_VALUEDEF

      do
	 create result.make_default
	 
	 if levels_to_search > 0 then
	    from
	       i := 1
	    until
	       i > private_contents.length
	    loop
	       if limit_type.value = CORBA_dk_all or else
		  equal (private_contents.get_value (i).def_kind,
			 limit_type) then
		  name := private_contents.get_value (i).name
		  if equal (name, search_name) then
		     result.set_value (private_contents.get_value (i), j)
		     j := j + 1
		  end -- if ...
	       end -- if ...
	       
	       con := CORBA_Container_narrow (private_contents.get_value (i))
	       if con /= void then
		  -- Descend for the contents of this container
		  nested := con.lookup_name (search_name,
					     levels_to_search - 1,
					     limit_type,
					     exclude_inherited)
		  from
		     k := 1
		  until
		     k > inherited.length
		  loop
		     result.set_value (inherited.get_value(k), j)
		     j := j + 1
		     k := k + 1
		  end -- loop k
		  
	       end -- if
	       i := i + 1
	    end -- loop
	 end -- if
	 
	 if levels_to_search > 0 
            and then not exclude_inherited
	    and then private_dk.value = CORBA_dk_Interface then
	    in := CORBA_InterfaceDef_narrow (current)
	    check
	       we_are_an_interfacedef : in /= void
	    end
	    bases := in.base_interfaces
	    from
	       i := 1
	    until 
	       i > bases.length
	    loop
	       inherited := bases.get_value (i).lookup_name (search_name,
							     levels_to_search - 1,
							     limit_type,
							     exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value (inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k
	       i := i + 1
	    end -- loop i
	 end -- if ...
	 
	 if levels_to_search > 0 
            and then not exclude_inherited
	    and then private_dk.value = CORBA_dk_Value then
	    val := CORBA_Valuedef_narrow (current)
	    check
	       we_are_a_valuedef : val /= void
	    end
	    bases2 := val.abstract_base_values
	    from
	       i := 1
	    until 
	       i > bases2.length
	    loop
	       inherited := bases2.get_value(i).lookup_name (search_name,
							     levels_to_search - 1,
							     limit_type,
							     exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value(inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k
	       i := i + 1
	    end -- loop i
	    
-- ?? Differs MICO from OMG here
--	    supported := val.supported_interfaces
	    if supported /= void then
	       inherited := supported.lookup_name (search_name,
						   levels_to_search - 1,
						   limit_type,
						   exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value (inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k   
	    end -- if
	    
	    base := val.base_value
	    if base /= void then
	       inherited := base.lookup_name (search_name,
					      levels_to_search - 1,
					      limit_type,
					      exclude_inherited)
	       from
		  k := 1
	       until
		  k > inherited.length
	       loop
		  result.set_value (inherited.get_value (k), j)
		  j := j + 1
		  k := k + 1
	       end -- loop k
	    end -- if ...
	 end -- if ...
      ensure then
	 result_nonvoid : result /= void
      end
   
   ------------
   
   describe_contents (limit_type : CORBA_DEFINITIONKIND;
		      exclude_inherited : BOOLEAN;
		      max_returned_objs : INTEGER) : CORBA_CONTAINER_DESCRIPTIONSEQ is
      
      local
	 cont         : CORBA_CONTAINEDSEQ
	 limit, i     : INTEGER

      do
	 cont := contents (limit_type, exclude_inherited)
	 limit := cont.length
	 if limit > max_returned_objs and then max_returned_objs /= -1 then
	    limit := max_returned_objs
	 end
	 
	 create result.make_default
	 from
	    i := 1
	 until
	    i > limit
	 loop
	    result.set_value (cont.get_value (i).describe, i)
	    i := i + 1
	 end -- loop i
      ensure then
	 result_nonvoid : result /= void
      end
   
   ------------
   
   create_module (id : STRING;
		  name : STRING;
		  version : STRING) : CORBA_MODULEDEF is

      local
	 intf : INTF_REPOS
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module then
	    -- can only create a module in the repository or in a 
	    -- module
	    create intf.make
	    raise_exception (intf)
	 else
            if is_duplicated_name (name) or else
               is_duplicated_id (id) then
               create intf.make
               raise_exception(intf)
            else
               create {CORBA_MODULEDEF_IMPL} result.make (current, id,
                                                          name, version)
               insert_contained (result)
            end -- if ...
         end
      end
   
   ------------
   
   create_constant (id : STRING;
		    name    : STRING;
		    version : STRING;
		    type    : CORBA_IDLTYPE;
		    value   : CORBA_ANY) : CORBA_CONSTANTDEF is

      local
	 intf : INTF_REPOS
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module
	    and then def_kind.value /= CORBA_dk_Value
	    and then def_kind.value /= CORBA_dk_Interface then
	    -- can only create a constant in the repository, in a 
	    -- module, in a value or in an interface
	    create intf.make
	    raise_exception (intf)
	 else
            if is_duplicated_name (name) or else
               is_duplicated_id (id) then
               create intf.make
               raise_exception(intf)
            else
               create {CORBA_CONSTANTDEF_IMPL} result.make (current, id, name,
                                                       version, type,
                                                       value)
               insert_contained (result)
            end -- if
	 end -- if ...
      end
   
   ------------
   
   create_struct (id : STRING;
		  name : STRING;
		  version : STRING;
		  members : CORBA_STRUCTMEMBERSEQ) : CORBA_STRUCTDEF is
      
      local
	 intf : INTF_REPOS

      do
         if is_duplicated_name (name) or else
            is_duplicated_id (id) then
            create intf.make
            raise_exception(intf)
         else
            create {CORBA_STRUCTDEF_IMPL} result.make (current, id, name,
                                                  version, members)
            insert_contained (result)
         end
      end
   
   ------------
   
   create_union (id : STRING;
		 name : STRING;
		 version : STRING;
		 discriminator_type : CORBA_IDLTYPE;
		 members : CORBA_UNIONMEMBERSEQ) : CORBA_UNIONDEF is
      
      local
	 intf : INTF_REPOS
         
      do
	 if is_duplicated_name (name) or else
            is_duplicated_id (id) then
            create intf.make
            raise_exception(intf)
         else
            create {CORBA_UNIONDEF_IMPL} result.make (current, id, name,
                                                      version,
                                                      discriminator_type,
                                                      members)
            insert_contained (result)
         end
      end
   
   ------------
   
   create_enum (id : STRING;
		name : STRING;
		version : STRING;
		members : CORBA_ENUMMEMBERSEQ) : CORBA_ENUMDEF is
      
      local
	 intf : INTF_REPOS
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module
	    and then def_kind.value /= CORBA_dk_Value
	    and then def_kind.value /= CORBA_dk_Interface then
	    -- can only create an enum in the repository, in a 
	    -- module, in a value or in an interface
	    create intf.make
	    raise_exception (intf)
	 else
            if is_duplicated_name (name) or else
               is_duplicated_id (id) then
               create intf.make
               raise_exception(intf)
            else
               create {CORBA_ENUMDEF_IMPL} result.make (current, id, 
                                                        name, version)
               result.set_members (members)
               insert_contained (result)
            end -- if
	 end -- if ...
      end
   
   ------------

   create_alias (id : STRING;
		 name : STRING;
		 version : STRING;
		 original_type : CORBA_IDLTYPE) : CORBA_ALIASDEF is
      
      local
	 intf : INTF_REPOS
	 
        do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module
	    and then def_kind.value /= CORBA_dk_Value
	    and then def_kind.value /= CORBA_dk_Interface then
	    -- can only create an alias in the repository, in a 
	    -- module, in a value or in an interface
	    create intf.make
	    raise_exception (intf)
	 else
            if is_duplicated_name (name) or else
               is_duplicated_id (id) then
               create intf.make
               raise_exception(intf)
            else
               create {CORBA_ALIASDEF_IMPL} result.make (current, id,
                                                         name, version)
               result.set_original_type_def (original_type)
               insert_contained (result)
            end
         end
      end
   
   ------------

   create_interface (id : STRING;
		     name : STRING;
		     version : STRING;
		     base_interfaces : CORBA_INTERFACEDEFSEQ;
		     is_abstract : BOOLEAN) : CORBA_INTERFACEDEF is
      
      local 
         break         : BOOLEAN
	 intf          : INTF_REPOS
	 in_probe      : CORBA_CONTAINED
	 i,j           : INTEGER
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module then
	    -- can only create an interface in the repository or in a 
	    -- module.
	    create intf.make
	    raise_exception (intf)
            break := true
	 end
	 
         if not break then
            in_probe := locate_id (id)
            if in_probe /= void then
               if in_probe.def_kind.value /= CORBA_dk_Interface then
                  -- A different IDL construct exists which is not an 
                  -- interface => duplicate sysmbol error
                  create intf.make
                  raise_exception (intf)
                  break := true
               end
            else
               -- name does not exist
               create {CORBA_INTERFACEDEF_IMPL} result.make (current, id,
							     name, version,
							     base_interfaces,
							     is_abstract)
               private_contents.set_value (result, private_contents.length + 1)
               break := true
            end
         end
         
	 if not break then
	    -- Interface has already been defined via a forward 
	    -- declaration. No we only have to move this 
	    -- definition to the end to reflect the correct 
	    -- declaration ordering and set the base interfaces
            from
	       i := 1
	    until
               break or else i > private_contents.length
	    loop
	       if equal (private_contents.get_value (i).id, in_probe.id) then
                  break := true
               else
                  i := i + 1
               end
	    end -- loop i

            from
               j := i + 1
            until
               j > private_contents.length
            loop
               private_contents.set_value (private_contents.get_value (j), j - 1)
               j := j + 1
            end -- loop j
            
            private_contents.set_value (in_probe, private_contents.length)
            
            result := CORBA_InterfaceDef_narrow (in_probe)
            result.set_base_interfaces (base_interfaces)
            result.set_is_abstract (is_abstract)
	 end
      end
   
   ------------

   create_value (id : STRING;
		 name : STRING;
		 version : STRING;
		 is_custom : BOOLEAN;
		 is_abstract : BOOLEAN;
		 base_value : CORBA_VALUEDEF;
		 is_truncatable : BOOLEAN;
		 abstract_base_values : CORBA_VALUEDEFSEQ;
		 supported_interfaces : CORBA_INTERFACEDEFSEQ;
		 initializers : CORBA_INITIALIZERSEQ) : CORBA_VALUEDEF is
      
      local
	 val_probe            : CORBA_CONTAINED
	 len, i, j            : INTEGER
	 intf                 : INTF_REPOS
	 con_id, val_probe_id : STRING
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module then
	    -- can only create a value in the repository, in a 
	    -- module
	    create intf.make
	    raise_exception (intf)
	 end
	 val_probe := locate_id (id)
	 if val_probe /= void then
	    if val_probe.def_kind.value /= CORBA_dk_Value then
	       -- A different IDL construct exists which is not a 
	       -- value => duplicate sysmbol error
	       create intf.make
	       raise_exception (intf)
	    end
	    -- Value has already been defined via a forward 
	    -- declaration. No we only have to move this 
	    -- definition to the end to reflect the correct 
	    -- declaration ordering and set the base interfaces
	    len := private_contents.length
	    from
	       i := 1
	    until
	       i > len
	    loop
	       con_id := private_contents.get_value(i).id
	       val_probe_id := val_probe.id
	       
	       if equal (con_id, val_probe_id) then
		  if i + 1 = len then
		     i := len + 1 -- break
		  else
		     from
			j := i
		     until
			j > len - 1
		     loop
			private_contents.set_value (private_contents.get_value( j + 1), i)
			j := j + 1
		     end -- loop j
		     private_contents.set_value (val_probe, len)
		  end -- i + 1 = len then
	       end
	       i := i + 1
	    end -- loop i
	    
	    result := CORBA_Valuedef_narrow (val_probe)
	    result.set_is_abstract (is_abstract)
	    result.set_base_value (base_value)
	    result.set_is_truncatable (is_truncatable)
	    result.set_abstract_base_values (abstract_base_values)
	    result.set_supported_interfaces (supported_interfaces)
	    result.set_initializers (initializers)
	 else --if val_probe /= void
	    
	    i := private_contents.length
	    -- Problem: differs MICO from OMG? Type of supported_interfaces?
	    --	    create {CORBA_VALUEDEF_IMPL} result.make (current, id, name,
	    --					   version, is_custom,
	    --					   is_abstract, base_value,
	    --					   is_truncatable,
	    --					   abstract_base_values,
	    --			   supported_interfaces,
	    --			   initializers)
	    private_contents.set_value (result, i + 1)
	 end -- if val_probe /= void...
      end
   
   ------------
   
   create_value_box (id : STRING;
		     name : STRING;
		     version : STRING;
		     original_type_def : CORBA_IDLTYPE) : CORBA_VALUEBOXDEF is
      
      local
	 intf : INTF_REPOS
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module then
	    -- can only create a valuebox in the repository or in a 
	    -- module ...
	    create intf.make
	    raise_exception (intf)
	 else
            if is_duplicated_name (name) or else
               is_duplicated_id (id) then
               create intf.make
               raise_exception(intf)
            else
               create {CORBA_VALUEBOXDEF_IMPL} result.make (current, id,
                                                            name, version,
                                                            original_type_def)
               insert_contained (result)
            end
         end
      end -- do
   
   ------------
   
   create_exception (id : STRING;
		     name : STRING;
		     version : STRING;
		     members : CORBA_STRUCTMEMBERSEQ) : CORBA_EXCEPTIONDEF is
      
      local
	 intf : INTF_REPOS
	 
      do
	 if def_kind.value /= CORBA_dk_Repository
	    and then def_kind.value /= CORBA_dk_Module
	    and then def_kind.value /= CORBA_dk_Value
	    and then def_kind.value /= CORBA_dk_Interface then
	    -- can only create an exception in the repository, in a 
	    -- module, in an value or in an interface
	    create intf.make
	    raise_exception (intf)
	 else
            if is_duplicated_name (name) or else
               is_duplicated_id (id) then
               create intf.make
               raise_exception(intf)
            else
               create {CORBA_EXCEPTIONDEF_IMPL} result.make (current, id,
                                                        name, version, members)
               insert_contained (result)
            end
         end
      end
   
   ------------
   
   create_native (id : STRING;
		  name : STRING;
		  version : STRING) : CORBA_NATIVEDEF is
      
      local
         intf : INTF_REPOS
	 
      do
	 if is_duplicated_name (name) or else
            is_duplicated_id (id) then
            create intf.make
            raise_exception(intf)
         else
            create {CORBA_NATIVEDEF_IMPL} result.make (current, id,
                                                       name, version)
            insert_contained (result)
         end
      end
   
   ------------
   
   find (search_name : STRING) : CORBA_CONTAINED is
      
      local
         name, first : STRING
         con, c      : CORBA_CONTAINED
         repo        : CORBA_REPOSITORY
         cont        : CORBA_CONTAINER

      do
         name := clone (search_name)

         if is_scoped_name (name) then
            first := first_of_scoped_name (name)
            if is_relative_scoped_name (name) then
               con := locate_name (first, true, true)
            else
               inspect private_dk.value
               when CORBA_dk_Repository then
                  repo := CORBA_Repository_narrow (current)
                  check
                     we_are_a_repository : repo /= void
                  end
               when CORBA_dk_Module,
                  CORBA_dk_Interface,
                  CORBA_dk_Value,
                  CORBA_dk_Struct,
                  CORBA_dk_Union,
                  CORBA_dk_Exception then
                  c := CORBA_Contained_narrow (current)
                  check
                     we_are_a_contained : c /= void
                  end
                  repo := c.containing_repository
               end -- inspect

               con := repo.locate_name (first, true, true)
            end -- if

            from
               -- nothing
            until
               con = void
            loop
               strip_first_scope (name)
               if equal (name, "") then
                  result := con
                  con := void -- break
               else
                  -- con should be a container
                  first := first_of_scoped_name (name)
                  cont := CORBA_Container_narrow (con)
                  if cont /= void then
                     con := cont.locate_name (name, true, true)
                  else
                     con := void -- break
                  end
               end
            end -- loop
         else -- if is_scoped_name (name) ...
            -- search_name is a simple name. It must be located in this 
            -- scope or an enclosing scope
            result := locate_name (name, true, true)
         end -- if is_scoped_name (name) ...
      end

   ------------

    find_name (search_name : STRING;
        limit_type : CORBA_DEFINITIONKIND) : CORBA_CONTAINEDSEQ is
      
      local
         i, j : INTEGER

      do
         create result.make_default
         from
            i := 0
         until
            i > private_contents.length
         loop
            if limit_type.value = CORBA_dk_all or else
               private_contents.get_value (i).def_kind = limit_type then
               if equal (private_contents.get_value (i).name,
                         search_name) then
                  j := j + 1
                  result.set_value (private_contents.get_value (i), j)
               end              
            end -- if
            i := i + 1
         end
      ensure then
         result_nonvoid : result /= void
      end

	
   ------------

   locate_id (id : STRING) : CORBA_CONTAINED is
      
      local
	 i               : INTEGER
	 con,  contained : CORBA_CONTAINED
	 c               : CORBA_CONTAINER
	 
      do
	 from
	    i := 1
	 until
	    i > private_contents.length or else result /= void
	 loop
	    con := private_contents.get_value(i)
	    if equal (con.id, id) then
	       result := con
	    else
	       c := CORBA_Container_narrow (con)
	       if c /= void then
		  contained := c.locate_id (id)
		  if contained /= void then
		     result := contained
		  end -- if
	       end -- if
	    end -- if
	    i := i + 1
	 end -- loop i
      end
   
   ------------
   
   locate_name (name : STRING;
		include_enclosing_scopes : BOOLEAN;
		is_first_level : BOOLEAN) : CORBA_CONTAINED is
      
      local
	 i          : INTEGER
	 n          : STRING
	 in         : CORBA_INTERFACEDEF
	 bases      : CORBA_INTERFACEDEFSEQ
	 hit, c,
	 contained  : CORBA_CONTAINED
	 def_in     : CORBA_CONTAINER
	 intf       : INTF_REPOS
	 
      do
         logger.trace_enter ("CORBA_CONTAINER_IMPL", "locate_name")
	 from
	    i := 1
	 until
	    i > private_contents.length
	 loop
	    n := private_contents.get_value(i).name
	    if equal (n, name) then
	       result := private_contents.get_value(i)
	    end
	    i := i + 1
	 end -- loop
	 
	 -- Object not found in this level. Extend search to higher 
	 -- levels. If this is an InterfaceDef, then first look 
	 -- through all base interfaces
	 if result = void then
	    in := CORBA_InterfaceDef_narrow (current)
	    if in /= void then
	       bases := in.base_interfaces
	       if bases.length > 0 then
		  -- This interface has base interfaces
		  from
		     i := 1
		  until
		     i > bases.length
		  loop
		     contained := bases.get_value (i).locate_name (name, include_enclosing_scopes, false)
		     if contained /= void then
			if hit = void then
			   -- First time we found the name along an 
			   -- inheritance path. Save it and search 
			   -- other inheritance paths
			   hit := contained
			else
			   if not hit.is_equivalent (contained) then
			      -- We have found the name along two 
			      -- inheritance path denoting different 
			      -- types. This means we have an 
			      -- ambiguity
			      create intf.make
			      raise_exception (intf)
			   end -- if hit.is_equivalent (contained) ...
			end -- if hit = void ...
		     end -- if contained /= void ...
		     i := i + 1
		  end -- loop i
		  
		  if hit /= void then
		     result := hit
		  end
	       end -- if bases.length > 0 ...
	    end -- if in /= void ...
	 end -- f result = void ...
	 
	 if result = void
	    and then include_enclosing_scopes then
	    -- Now searching the enclosing container, but not if 
	    -- we are currently searching an inherited interface
	    c := CORBA_Contained_narrow (current)
	    if c /= void and then is_first_level then
	       def_in := c.defined_in
	       if def_in /= void then
		  result := def_in.locate_name (name, include_enclosing_scopes, true)
	       end -- if def_in /= void ...
	    end -- if c := void and then is_first_level ...
	 end -- if result = void ...
         logger.trace_leave ("CORBA_CONTAINER_IMPL", "locate_name")
      end
   
   ------------
   
   remove_contained (con : CORBA_CONTAINED) is
      
      local
	 con_id, id : STRING
	 i, j       : INTEGER
	 
      do
	 con_id := con.id
	 
	 from
	    i := 1
	 until
	    i > private_contents.length
	 loop
	    id := private_contents.get_value (i).id
	    if equal (id, con_id) then
	       if i < private_contents.length - 1 then
		  from
		     j := i
		  until
		     j > private_contents.length - 1
		  loop
		     private_contents.set_value (private_contents.get_value (j + 1), j)
		     j := j + 1
		  end -- loop j
	       end
	       i := private_contents.length -- break
	    end
	    i := i + 1
	 end
      end
   
   ------------
   
   add_contained (con : CORBA_CONTAINED) is
      
      do
         private_contents.set_value (con,private_contents.length + 1)
      end
   
feature {NONE}
   
   private_contents : CORBA_CONTAINEDSEQ
   
	 ------------
   
   is_duplicated_name (name : STRING) : BOOLEAN is
         -- is name already in this scope?

      local 
         i   : INTEGER
         con : CORBA_CONTAINED

      do
         from
	    i := 1
	 until
	    i > private_contents.length or else result
	 loop
	    con := private_contents.get_value (i)
	    if equal (con.name, name) then
               result := true
	    end
	    i := i + 1
	 end
      end

   ------------
   
   is_duplicated_id (id : STRING) : BOOLEAN is
	 -- is id already a id in this scope?
      
      local
	 repo     : CORBA_REPOSITORY
	 c        : CORBA_CONTAINED
	 
      do
	 if private_dk.value = CORBA_dk_Repository then
	    repo := CORBA_Repository_narrow (current)
	 else
	    c := CORBA_Contained_narrow (current)
	    check
	       we_are_a_contained : c /= void
	    end
	    repo := c.containing_repository
	 end -- if ...
	 
	 if repo.lookup_id (id) /= void then
            result := true
	 end
      end
   
   ------------
   
   is_scoped_name (name : STRING) : BOOLEAN is
	 -- Return true iff name is a scoped name (i. e. it contains "::" 
	 -- as a substring
      
      require
	 name_nonvoid : name /= void

      do
	 if  name.substring_index ("::", 0) > 0 then
	    result := true
	 end	    
      end
   
   ------------
   
   is_relative_scoped_name (name : STRING) : BOOLEAN is
      
      require
	 name_nonvoid : name /= void

      do
	 result := (name.index_of (':', 0) = 1)
      end
   
   ------------
   
   first_of_scoped_name (name : STRING) : STRING is

      require
	 name_nonvoid : name /= void
      
      local
	 i, j : INTEGER
	 
      do
	 if is_relative_scoped_name (name) then 
	    i := 1
	 else
	    i := 3
	 end
	 j := name.substring_index ("::", i)
	 if j = 0 then
	    result := name.substring (1, i)
	 else
	    result := name.substring (i, j)
	 end
      end

   ------------

   strip_first_scope (name : STRING) is


      require
	 name_nonvoid : name /= void
      
      local
	 i, j : INTEGER
	 
      do
	 if is_relative_scoped_name (name) then 
	    i := 1
	 else
	    i := 3
	 end
	 j := name.substring_index ("::", i)
	 if j = 0 then
	    name.wipe_out
	 else
	    name.copy (name.substring (1, j + 2))
	 end
      end

   ------------

   insert_contained (type : CORBA_CONTAINED) is
      
      require
	 type_nonvoid : type /= void
      
      do
	 private_contents.set_value (type, private_contents.length + 1)
      end

invariant

   -- contents_nonvoid : private_contents /= void

end -- class CORBA_CONTAINER_IMPL

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
--                                                                    --
------------------------------------------------------------------------
