indexing
	description: "Trvaversal for COMPOSED_OBJECTs."
	keywords:    "composed object, traversal"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class AGGREGATE_TRAVERSAL 

inherit
	TRAVERSAL
	    redefine
	        target, execute
	    end

	ES_ACTIONS

creation
	make

feature -- Traversal
	execute(root_target:COMPOSED_OBJECT) is
	    local
			instance_count:INTEGER
	    do
debug("matisse-sr")
	shifter.increase
	io.put_string(shifter.out)
	io.put_string("AGGREGATE_TRAVERSAL.execute ")
	io.put_string(target.generator)
    io.new_line
end
			-- make sure we haven't already done this object...
			if not storer.item.sub_closures_in_progress.has(target) then
			    storer.item.sub_closures_in_progress.extend(target)

		    	-- if not proceeding with this closure (e.g. it's not marked for store), just update storer ref tables
			    if actions.closure_proceed(target) then
			        -- traverse to mark and count
			        instance_count := composition_mark_and_count(target, 0)

		    	    -- initialisation actions for this closure
		        	actions.closure_init_action(target, instance_count)

			        -- go and do the traverse which sets off a chain reaction
			        traverse (target, dynamic_type(Current) = expanded_type, False, root_target)

			        -- now back to me... finish my traversal
		    	    actions.closure_finish_action(target)
			    else
					debug("matisse-sr") io.putstring(shifter.out) io.putstring("--------> updating for not MARKED for STORE --> ") io.new_line end
			        storer.item.update_ref_tables(target)
		    	end
			end
			debug("matisse-sr") shifter.decrease end
		end

	traverse (object:ANY; is_exp, continue:BOOLEAN; root_target:COMPOSED_OBJECT) is
	        -- traverse and aggregation closure and perform pre-set actions
		local
			type_value, nb_field, i: INTEGER
			one_field: ANY
			one_array: ARRAY [ANY]
			one_storer : STORER
			a_special : SPECIAL[ANY]
			co_object, co_field : COMPOSED_OBJECT	
		do
			debug("matisse-trav");shifter.increase;end

			if object/=Void and then (is_exp or else is_marked(object)) then
				unmark (object)

				co_object ?= object

				if is_special(object) then
					-- Scan though all item elements of special and propagate the traversal to those that are references to objects.
					a_special ?= object
					check a_special /= Void end
					if not(is_special_simple($a_special)) then
						-- `one_array' is an array of elements of reference type.
						from
							i := 0
							nb_field := a_special.count
						until
							i =  nb_field
						loop
							one_field := a_special.item (i)

							-- decide whether and how to continue traversal
							if one_field /= Void and then actions.special_object_test(one_field) then
								co_field ?= one_field
								if co_field = Void then
									debug("matisse-sr") io.putstring(shifter.out) io.putstring(">>>>>>>>>> following COMP special >>> ") io.new_line end
									traverse (one_field, dynamic_type(one_field) = expanded_type, continue, root_target)

								elseif co_field.is_in_aggregation(root_target) or else continue then
									debug("matisse-sr") io.putstring(shifter.out) io.putstring("=========> following AGG special ==> ") io.new_line end
									co_field.closure_execute(root_target)

								else	-- have hit another composition; record its root object in store ref tables
									debug("matisse-sr") io.putstring(shifter.out) io.putstring("--------> updating for ASSOC special --> ") io.new_line end
									storer.item.update_ref_tables(co_field)
								end
							end
							i := i + 1
						end
					else
						-- `one_array' is an array of elements that are NOT of reference type.
					end
					actions.special_object_action (object)
				else
					-- loop to inspect each field of object
					from
						nb_field := field_count (object)
						i := 1
					until
						i > nb_field
					loop
						-- get type of field
						type_value := field_type (i, object)
						one_field := field (i, object)

						if one_field /= Void then
							debug("matisse-trav") io.putstring(shifter.out) end
							target.default_actions.field_action(i,object) 

--			    				if actions.normal_object_test(one_field) then
-- TEMP: DYN TYPE handling; revert to commented version when fixed.
--
							if actions.normal_object_test(object,i) then

								if type_value = Reference_type then		-- is i-th field a reference to another object ?
									-- decide whether and how to continue traversal
									co_field ?= one_field
									if co_field = Void then
										debug("matisse-sr") io.putstring(shifter.out) io.putstring(">>>>>>>>>> following COMP ref >>> ") io.putstring(field_name(i,object)) io.new_line end
										traverse (one_field, False, continue, root_target)

									elseif co_field.is_in_aggregation(root_target) or else continue then
										debug("matisse-sr") io.putstring(shifter.out) io.putstring("=========> following AGG ref ==> ") io.putstring(field_name(i,object)) io.new_line end
										co_field.closure_execute(root_target)

									else	-- have hit another composition; record its root object in store ref tables
										debug("matisse-sr")  io.putstring(shifter.out) io.putstring("--------> updating for ASSOC ref --> ") io.putstring(field_name(i,object)) io.new_line end
										storer.item.update_ref_tables(co_field)
									end

								elseif type_value = Expanded_type then	-- is i-th field an expanded type ?
									debug("matisse-trav");display_begin_expanded_object;end

									-- decide whether and how to continue traversal
									co_field ?= one_field
									if co_field = Void then
										debug("matisse-sr") io.putstring(shifter.out) io.putstring(">>>>>>>>>> following COMP expanded >>> ") io.putstring(field_name(i,object)) io.new_line end
										traverse (one_field, True, continue, root_target)
									elseif co_field.is_in_aggregation(root_target) or else continue then
										debug("matisse-sr") io.putstring(shifter.out) io.putstring("=========> following AGG expanded ==> ") io.putstring(field_name(i,object)) io.new_line end
										co_field.closure_execute(root_target)
									else	-- have hit another composition; record its root object in store ref tables
										debug("matisse-sr") io.putstring(shifter.out) io.putstring("--------> updating for ASSOC expanded --> ") io.putstring(field_name(i,object)) io.new_line end
										storer.item.update_ref_tables(co_field)
									end

									debug("matisse-trav");display_end_expanded_object;end

								else  					-- simple object, just display if needed
									-- actions.composed_field_action(i,object) 
									debug("matisse-trav") io.new_line end
								end

							end
						end
						i := i + 1
					end -- loop                

					actions.normal_object_action (object, is_exp)
				end
			else -- object is Void
				debug("matisse-trav");display_is_void;end
			end
			debug("matisse-trav");shifter.decrease;end
		end

	composition_mark_and_count (object:ANY; arg_objects_count: INTEGER) : INTEGER is
	    local
			type_value, nb_field, i: INTEGER
			one_field: ANY
			one_array: ARRAY [ANY]
			a_special : SPECIAL[ANY]
			co_field : COMPOSED_OBJECT	
	    do
debug("matisse-trav");shifter.increase;end
			Result := arg_objects_count

			if object/=Void then
			    mark (object)    -- mark object to avoid a cycle in traversal
			    Result := Result + 1

		    	if is_special(object) then
					a_special ?= object
					check a_special /= Void end
					target.default_actions.special_object_action(a_special)
					if not(is_special_simple($a_special)) then
					    -- `one_array' is an array of elements of reference type.
						from
							i := 0
							nb_field := a_special.count
						until
							i =  nb_field
					    loop
							one_field := a_special.item (i)

							if one_field /= Void and then not is_marked (one_field) then
							    co_field ?= one_field
								if co_field = Void then
									Result := composition_mark_and_count (one_field, Result)
								end
							end
							i := i + 1
						end
					else
						-- `one_array' is an array of elements that are NOT of reference type.
					end
				else
					target.default_actions.normal_object_action(object, False)
					-- loop to inspect each field of object
					from
						nb_field := field_count (object)
						i := 1
					until
						i > nb_field
					loop
						-- get type of field
						type_value := field_type (i, object)
						one_field := field (i, object)
						co_field ?= one_field

						if one_field /= Void and then not is_marked (one_field) then
debug("matisse-trav") io.putstring(shifter.out) end
							target.default_actions.field_action(i, object)

							if type_value = Reference_type then		-- is i-th field a reference to another object ?
								if co_field = Void then
									Result := composition_mark_and_count (one_field, Result)
								end

							elseif type_value = Expanded_type then	-- is i-th field an expanded type ?
debug("matisse-trav");display_begin_expanded_object;end
								Result := Result - 1
								if co_field = Void then
									Result := composition_mark_and_count (one_field, Result)
								end
debug("matisse-trav");display_end_expanded_object;end

							else  					-- simple object, just display if needed
debug("matisse-trav") io.new_line end
						end

					end
					i := i + 1
				end -- loop                

		    end
		else -- object is Void
debug("matisse-trav");display_is_void;end
		end
debug("matisse-trav");shifter.decrease;end
	    ensure
			consistent_count : Result >= arg_objects_count        
	    end

feature -- Access
	target:COMPOSED_OBJECT
 
end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+
