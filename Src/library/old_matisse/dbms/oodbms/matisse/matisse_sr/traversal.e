deferred class TRAVERSAL 

inherit
   
	EXT_INTERNAL
		export
			{NONE} all
		end

feature -- Traversal

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
		do
			debug;shifter.increase;end
			Result := arg_objects_count
			if object/=Void then
				mark (object)    -- mark object to avoid a cycle in traversal
				Result := Result + 1
				if is_special(object) then
					-- if object is an array then call appropriate feature
					Result := new_special_traversal (object,Result)
				else
					-- if object is not an array then continue with standard procedure
					-- the object action is performed each time we reach this point.
					-- it can be redefined.
					default_actions.normal_object_action (object) 
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
								debug io.putstring(shifter.out) end
								default_actions.field_action(i,object)
								es ?= object
								if es /= Void then 
									Result := es.new_deep_traversal (one_field,Result)
								else
									Result := new_deep_traversal (one_field,Result)
								end -- if
							end -- if
						-- is i-th field an expanded type ?
						elseif type_value=Expanded_type then
							debug;display_begin_expanded_object;end
							one_field := field (i, object)
							if one_field /= Void and then not is_marked (one_field) then
								-- Propagate the traversal to 
								-- referenced objects not traversed yet
								debug io.putstring(shifter.out) end
								default_actions.field_action(i,object) 
								Result := Result - 1
								es ?= object
								if es /= Void then
									Result := new_deep_traversal (one_field,Result)
								else
									Result := new_deep_traversal (one_field,Result) 
								end -- if
							end -- if
							debug;display_end_expanded_object;end
						else  -- simple object, just display if needed
							one_field := field (i, object)
							if one_field /= Void and then not is_marked (one_field) then
								debug io.putstring(shifter.out) end
								default_actions.field_action(i,object) 
								debug io.new_line end
							end --if
						end -- if
						i := i + 1
					end -- loop                
				end --if 
			else -- object is Void
				debug;display_is_void;end
			end -- if
			debug;shifter.decrease;end
		ensure
			consistent_count : Result >= arg_objects_count        
		end -- new_deep_traversal

feature -- Special

	new_special_traversal (special_object : ANY;arg_objects_count:INTEGER) : INTEGER is
		-- Scan though all item elements of special
		-- and propagate the deep traversal to those
		-- that are references to objects.
		require
			object_not_void: special_object /= Void
			arg_objects_count_positive_or_null : arg_objects_count >= 0
		local
			i: INTEGER
			one_field: ANY
			one_special_object : SPECIAL[ANY]
		do
			Result := arg_objects_count
			one_special_object ?= special_object
			check one_special_object /= Void end
			default_actions.special_object_action (special_object) 
			if not(is_special_simple($special_object)) then
				-- `one_array' is an array of elements
				-- that are of reference type.
				from
					i := 0
				until
					i = one_special_object.count 
				loop
					one_field := one_special_object.item (i)
					if one_field /= Void and then not is_marked (one_field) then
						-- Propagate traversal to the next object
						Result := new_deep_traversal (one_field,Result)
					end
					i := i + 1
				end -- loop
			else
				-- `one_array' is an array of elements that are NOT of reference type.
			end -- if
		ensure
			consistent_count : Result >= arg_objects_count
 		end  -- new_special_traversal


feature -- Actions
    
	default_actions : TRAVERSAL_ACTION is 
		deferred
		end

feature {TRAVERSAL} -- Display

	shifter : SHIFTER is
		-- a string displayed before each field information. Contains only tab chars
		once
			!!Result.make
		end -- shifter

	display_is_void is
		-- display string "void object
		do
			debug;io.putstring("Void object%N");end
		end -- display_is_void

	display_begin_expanded_object is
		-- display string "void object
		do
			debug;io.putstring(shifter.out)
			io.putstring("----- expanded object -----%N");end
		end -- display_begin_expanded_object

	display_end_expanded_object is
		-- display string "void object
		do
			debug;io.putstring(shifter.out)
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


end -- class TRAVERSAL
