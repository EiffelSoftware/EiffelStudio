class TRAVERSAL 

inherit
   
	STORE_HANDLE

	STORE_SHIFTER

	EXT_INTERNAL
		export
			{NONE} all
		end


    creation
	make

    feature -- Initialisation
	make(a_target:like target) is
	    require
	        Args_valid: a_target /= Void
	    do
		   target := a_target
	    end

feature -- Traversal
	execute(arg:ANY) is
	    local
			instance_count:INTEGER
	    do
			-- make sure we haven't already done this object...
			if not storer.item.sub_closures_in_progress.has(target) then
			    storer.item.sub_closures_in_progress.extend(target)

		        -- traverse to mark and count
		    --    instance_count := composition_mark_and_count(target, 0)

		        -- initialisation actions for this closure
		     --   actions.closure_init_action(target, instance_count)

		        -- go and do the traverse which sets off a chain reaction
		     --   traverse (target, dynamic_type(Current) = expanded_type, False, arg)

		        -- now back to me... finish my traversal
		     --   actions.closure_finish_action(target)
			end
	    end

	new_deep_traversal (object: ANY; arg_objects_count : INTEGER) : INTEGER is
			-- Perform a deep recursive traversal on 
			-- the transitive closure of the object network 
			-- reachable from root `object'.
			-- Return count of traversed objects 
		local
			type_value, nb_field, i: INTEGER
			one_field: ANY
			one_array: ARRAY [ANY]
			one_storer : STORER
			es : EXT_STORABLE
			a_special:SPECIAL[ANY]
		do
			debug("matisse-sr");shifter.increase;end
			Result := arg_objects_count
			if object/=Void then
				mark (object)    -- mark object to avoid a cycle in traversal
				Result := Result + 1
				if is_special(object) then
					-- if object is an array then call appropriate feature
					a_special ?= object
					check a_special /= Void end
					actions.special_object_action (a_special)
					if not(is_special_simple($object)) then
						-- `one_array' is an array of elements that are of reference type.
						from
							i := 0
							nb_field := a_special.count
						until
							i =  nb_field
						loop
							one_field := a_special.item (i)
							if one_field /= Void and then not is_marked (one_field) then
								-- Propagate traversal to the next object
								Result := new_deep_traversal (one_field,Result)
							end
							i := i + 1
						end -- loop
					else
						-- `one_array' is an array of elements that are NOT of reference type.
					end -- if
				else
					-- if object is not an array then continue with standard procedure
					-- the object action is performed each time we reach this point.
					-- it can be redefined.
					actions.normal_object_action (object, False) 
					-- loop to inspect each field of object
					from
						nb_field := field_count (object)
						i := 1
					until
						i > nb_field
					loop
						-- get type of field
						type_value := field_type (i, object)
						-- is i-th field a reference to another object ?
						if type_value = Reference_type then
							one_field := field (i, object)
							if one_field /= Void and then not is_marked (one_field) then
								-- Propagate the traversal to referenced objects not traversed yet
								debug("matisse-sr") io.putstring(shifter.out) end
								actions.field_action(i,object)
								es ?= object
								if es /= Void then 
								--	Result := es.new_deep_traversal (one_field,Result)
								else
									Result := new_deep_traversal (one_field,Result)
								end -- if
							end -- if
						-- is i-th field an expanded type ?
						elseif type_value=Expanded_type then
							debug("matisse-sr");display_begin_expanded_object;end
							one_field := field (i, object)
							if one_field /= Void and then not is_marked (one_field) then
								-- Propagate the traversal to 
								-- referenced objects not traversed yet
								debug("matisse-sr") io.putstring(shifter.out) end
								actions.field_action(i,object) 
								Result := Result - 1
								es ?= object
								if es /= Void then
									Result := new_deep_traversal (one_field,Result)
								else
									Result := new_deep_traversal (one_field,Result) 
								end -- if
							end -- if
							debug("matisse-sr");display_end_expanded_object;end
						else  -- simple object, just display if needed
							one_field := field (i, object)
							if one_field /= Void and then not is_marked (one_field) then
								debug("matisse-sr") io.putstring(shifter.out) end
								actions.field_action(i,object) 
								debug("matisse-sr") io.new_line end
							end --if
						end -- if
						i := i + 1
					end -- loop                
				end --if 
			else -- object is Void
				debug("matisse-sr");display_is_void;end
			end -- if
			debug("matisse-sr");shifter.decrease;end
		ensure
			consistent_count : Result >= arg_objects_count        
		end -- new_deep_traversal
	
    feature -- Access
	target:EXT_STORABLE

	actions: TRAVERSAL_ACTION is
	    do
	        Result := target.actions
	    end
  
feature {TRAVERSAL} -- Display 

	display_is_void is
		-- display string "void object
		do
			debug("matisse-trav");io.putstring("Void object%N");end
		end -- display_is_void

	display_begin_expanded_object is
		-- display string "void object
		do
			debug("matisse-trav");io.putstring(shifter.out)
			io.putstring("----- expanded object -----%N");end
		end -- display_begin_expanded_object

	display_end_expanded_object is
		-- display string "void object
		do
			debug("matisse-trav");io.putstring(shifter.out)
			io.putstring("----- end of expanded -----%N");end
		end -- display_end_expanded_object

feature {NONE} -- External C

	is_special_simple(object : POINTER) : BOOLEAN  is
		-- Is current object a special of pointers ?
		external 
			"C"
		alias
			"c_is_special_simples"
		end -- is_special_simple


end
