indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	EIFFEL_CALL_STACK_ELEMENT

inherit
	CALL_STACK_ELEMENT

feature {NONE} -- Initialization

feature -- Properties

	body_index: INTEGER is
			-- body index of the associated routine
		do
			if private_body_index = -1 then
				private_body_index := routine.body_index
			end
			Result := private_body_index
		end			

	is_melted: BOOLEAN
			-- Is the associated routine melted.
			-- Only in that case can we request the locals
			-- and the arguments.

	dynamic_class: CLASS_C
			-- Dynamic class where routine is called from

	dynamic_type: CLASS_TYPE
			-- Dynamic class type where routine is called from

	origin_class: CLASS_C
			-- Class where routine is written in

	routine: E_FEATURE is
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose
		deferred
		end
		
	has_result: BOOLEAN is
			-- Does this routine has a Result ?
			-- ie: function or once
		do
			Result := routine /= Void and then routine.is_function
		end
		
	result_value: ABSTRACT_DEBUG_VALUE is
			-- Result value of routine
		do
			if not initialized then
				initialize_stack
			end
			Result := private_result
			if routine /= Void and then routine.is_function and then Result = Void then
				Result := error_value ("Result", "unable to get the value")
			end
		ensure
			is_function_non_void: routine.is_function implies Result /= Void
		end

	locals: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of local variables
		do
			if not initialized then
				initialize_stack
			end
			Result := private_locals
			if 
				Result = Void 
				and (
						routine /= Void 
						and then routine.locals /= Void
						and then not routine.locals.is_empty 
					)
			then
				create {LINKED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make
				Result.extend (error_value ("...", "unable to get the locals"))
			end
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

	arguments: LIST [ABSTRACT_DEBUG_VALUE] is
			-- Value of arguments
		do
			if not initialized then
				initialize_stack
			end
			Result := private_arguments
			if 
				Result = Void 
				and (
						routine /= Void 
						and then routine.arguments /= Void
						and then not routine.arguments.is_empty 
					)
			then
				create {LINKED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make
				Result.extend (error_value ("...", "unable to get the arguments"))
			end			
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

feature -- Output

	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		local
			args_list: like arguments
		do
			args_list := arguments
			if args_list /= Void then
				from
					args_list.start
					st.add_new_line
					st.add_string ("Arguments:")
					st.add_new_line
				until
					args_list.after
				loop
					st.add_indent
					args_list.item.append_to (st, 0)
					args_list.forth
				end
			end
		end

	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of 
			-- the routine associated with Current call.
		local
			local_names: SORTED_TWO_WAY_LIST [ABSTRACT_DEBUG_VALUE]
			local_decl_grps: EIFFEL_LIST [TYPE_DEC_AS]
			locals_list: like locals
		do
			locals_list := locals

			if locals_list /= Void or else private_result /= Void then
				st.add_new_line
				st.add_string ("Local entities:")
				st.add_new_line
			end
			if locals_list /= Void then
				create local_names.make
				from
					locals_list.start
				until	
					locals_list.after
				loop
					local_names.put_front (locals_list.item)
					locals_list.forth
				end
				local_names.sort
				local_decl_grps := routine.locals
				if local_decl_grps /= Void then
					from
						local_names.start
					until
						local_names.after
					loop
						st.add_indent
						local_names.item.append_to (st, 0)
						local_names.forth	
					end
				end
			end
			if private_result /= Void then
					-- Display the Result entity value.
				st.add_indent
				private_result.append_to (st, 0)
			end
		end 

	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		local
			c, oc	: CLASS_C
			last_pos: INTEGER
		do
			
			c := dynamic_class
			oc := origin_class
				-- Print object address (14 characters)
			st.add_string ("[")
			if c /= Void then
				st.add_address (display_object_address, routine_name, c)
				last_pos := display_object_address.count + 2
			else
				st.add_string ("0x0")
				last_pos := 5
			end
			st.add_string ("] ")
			st.add_column_number (14)
				-- Print class name
			if c /= Void then
				c.append_name (st)
				st.add_string (" ")
				last_pos := c.name.count + 14
			else
				st.add_string ("NOT FOUND ")
				last_pos := 9 + 14 
			end
			st.add_column_number (26)

			if is_melted then
				st.add_string ("*")
			end
			st.add_feature_name (routine_name, oc)
			if oc /= c then
				st.add_string (" (From ")
				if oc /= Void then
					oc.append_name (st)
				else
					st.add_string ("Void")
				end
				st.add_string (")")
			end
			
			-- print line number
			st.add_string(" ( @ ")
			st.add_int(break_index)
			st.add_string(" )")
			
		ensure then
			initialized_not_changed: old initialized = initialized
		end

feature {NONE} -- Implementation 

	initialize_stack is
		require
			not_initialized: not initialized
		deferred
		ensure
			initialized: initialized
		end

feature {NONE} -- Implementation Properties

	private_locals: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated locals

	private_arguments: FIXED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated arguments

	private_result: like result_value
			-- Associated result

	initialized: BOOLEAN
			-- Is the stack initialized

	private_body_index: like body_index
			-- Associated body index
			
feature {NONE} -- Implementation helper

	error_value (a_name, a_mesg: STRING): DUMMY_MESSAGE_DEBUG_VALUE is
		do		
			create Result.make_with_name (a_name)
			Result.set_message (a_mesg)
		end

invariant
--
--	non_empty_args_if_exists: private_arguments /= Void implies 
--				not private_arguments.is_empty
--	non_empty_locs_if_exists: private_locals /= Void implies 
--				not private_locals.is_empty
--	valid_level: level_in_stack >= 1


end -- class EIFFEL_CALL_STACK_ELEMENT
