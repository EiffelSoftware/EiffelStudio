indexing
	description	: "Information about a call in the calling stack."
	date		: "$Date$"
	revision	: "$Revision $"

class CALL_STACK_ELEMENT

inherit
	OBJECT_ADDR

	RECV_VALUE
		export
			{NONE} all
			{EIFFEL_CALL_STACK} error
		end

	COMPILER_EXPORTER

	SHARED_EIFFEL_PROJECT

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	DEBUG_EXT
		export
			{NONE} all
		end

creation {EIFFEL_CALL_STACK}
	make

feature {NONE} -- Initialization

	make (level: INTEGER) is
		require
			valid_level: level >= 1
		do
				-- set the level
			level_in_stack := level

				-- set the private to a fake value
			private_body_index := -1

			debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: Creating item%N"); end
			create unprocessed_values.make(10)
			debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: init_recv_c%N"); end
			init_recv_c
			debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: init_rout_c%N"); end
			init_rout_c
			debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: c_recv_rout_info%N"); end
			c_recv_rout_info(Current)

			debug ("DEBUGGER_TRACE")
				if is_exhausted then
					io.error.putstring("%T%TEXHAUSTED")
				else
					io.error.putstring("%T%T")
					io.error.putstring(routine_name)
				end
				io.error.new_line
			end
			debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: Finished creating%N"); end
		end
	

feature -- Properties

	routine_name: STRING
			-- Associated routine name

	level_in_stack: INTEGER
			-- Where is this element situated in the call stack?
			-- 1 means on the top.

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

	break_index: INTEGER
			-- the "Line number" where application is stopped within current feature

	dynamic_class: CLASS_C
			-- Dynamic class where routine is called from

	origin_class: CLASS_C
			-- Class where routine is written in

	routine: E_FEATURE is
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose
		do
			if private_routine = Void then
				private_routine := origin_class.feature_with_name (routine_name)
			end
			Result := private_routine
		end

	result_value: ABSTRACT_DEBUG_VALUE is
			-- Result value of routine
		do
			if not initialized then
				initialize_stack
			end
			Result := private_result
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
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

	object_address: STRING
			-- Hector address of associated object 
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.

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
			
		ensure
			initialized_not_changed: old initialized = initialized
		end

feature {EIFFEL_CALL_STACK} -- Implementation

	set_hector_addr_for_locals_and_arguments is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		local
			l: like unprocessed_values
		do
			l := unprocessed_values
			check
				not_initialized: not initialized
				valid_unprocessed_values: l /= Void
			end
			from
				l.start
			until
				l.after
			loop
				l.item.set_hector_addr
				l.forth
			end
		end

	set_hector_addr_for_current_object is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			object_address := hector_addr (object_address)

				-- Now the address is correct and we can display it.
			display_object_address := object_address
		end

feature {NONE} -- Implementation

	retrieve_locals_and_arguments is
		do
				debug ("DEBUGGER_TRACE"); io.error.putstring ("CALL_STACK_ELEMENT: receiving locals & arguments%N"); end
				debug ("DEBUGGER_TRACE"); io.error.putstring ("CALL_STACK_ELEMENT: sending the request%N"); end
				-- send the request
			send_rqst_1 (Rqst_dump_variables, level_in_stack)

				-- Receive the arguments.
			retrieved_arguments_count := 0
			retrieved_locals_count := 0
				-- (`item' is set to Void when no more values are expected.)
				debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: receiving the arguments%N"); end
			from
					debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: c_recv_value%N"); end
				if not error then
					c_recv_value (Current)
				end
			until
				error or item = Void
			loop
					debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: processing value%N"); end
				unprocessed_values.extend (item)
				retrieved_arguments_count := retrieved_arguments_count + 1
					debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: c_recv_value%N"); end
				c_recv_value (Current)
			end

				-- Receive the local entities. 
				-- user-defined, then loop variants and old expr, and finally the result if any. 
				-- (`item' is set to Void when no more values are expected).
				debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: receiving the locals%N"); end
			from
					debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: c_recv_value%N"); end
				if not error then 
					c_recv_value (Current) 
				end
			until
				error or item = Void
			loop
					debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: processing value%N"); end
				unprocessed_values.extend (item)
				retrieved_locals_count := retrieved_locals_count + 1
					debug ("DEBUGGER_TRACE"); io.error.putstring ("%T%TCALL_STACK_ELEMENT: c_recv_value%N"); end
				c_recv_value (Current)
			end
		end

	initialize_stack is
		require
			not_initialized: not initialized
		local
			local_decl_grps	: EIFFEL_LIST [TYPE_DEC_AS]
			id_list			: EIFFEL_LIST [ID_AS]
			l_count			: INTEGER
			value			: ABSTRACT_DEBUG_VALUE
			unprocessed_l	: like unprocessed_values
			locals_list		: like private_locals
			args_list		: like private_arguments
			arg_names		: LIST [STRING]
			rout			: like routine
			counter			: INTEGER
		do
				debug ("DEBUGGER_TRACE"); io.putstring ("Initializing stack (CALL_STACK_ELEMENT): "+routine_name+" from: "+dynamic_class.name+"%N"); end
			if not is_exhausted then
				retrieve_locals_and_arguments
				set_hector_addr_for_locals_and_arguments
			end
				debug ("DEBUGGER_TRACE"); io.putstring ("Finished retrieving locals and argument"+"%N"); end
			rout := routine
			unprocessed_l := unprocessed_values
			unprocessed_l.start
			if rout /= Void then
				local_decl_grps := rout.locals
				--l_count := rout.argument_count
				l_count := retrieved_arguments_count
				if l_count > 0 then
					arg_names := rout.argument_names
					create args_list.make_filled (l_count)	
					from
						arg_names.start
						args_list.start
					until
						args_list.after
					loop
						value := unprocessed_l.item
						value.set_name (arg_names.item)
						args_list.replace (value)
						args_list.forth
						arg_names.forth
						unprocessed_l.forth
					end
				end
				if local_decl_grps /= Void then
					create locals_list.make (retrieved_locals_count)
					from
						l_count := 0
						local_decl_grps.start
					until
						local_decl_grps.after or
						l_count >= retrieved_locals_count
					loop 
						from
							id_list := local_decl_grps.item.id_list
							id_list.start
						until
							id_list.after or
							l_count >= retrieved_locals_count
						loop
							value := unprocessed_l.item
							value.set_name (id_list.item)
							locals_list.extend (value)
							id_list.forth
							unprocessed_l.forth
							l_count := l_count + 1
						end
						local_decl_grps.forth
					end
				end
				if rout.is_function and not unprocessed_values.is_empty then
					private_result := unprocessed_values.last
					private_result.set_name ("Result")
				end
			end
			
				-- initialize item numbers
			if args_list /= Void then
				from
					args_list.start
					counter := 1
				until
					args_list.after
				loop
					args_list.item.set_item_number(counter)
					args_list.forth
					counter := counter + 1
				end
			end

			if locals_list /= Void then
				from
					locals_list.start
					counter := 1
				until
					locals_list.after
				loop
					locals_list.item.set_item_number(counter)
					locals_list.forth
					counter := counter + 1
				end
			end

			private_arguments := args_list
			private_locals := locals_list
			unprocessed_values := Void
			initialized := True
				debug ("DEBUGGER_TRACE"); io.putstring ("%TFinished initializating stack: "+routine_name+"%N"); end
		ensure
			initialized: initialized
			void_unprocessed: unprocessed_values = Void
		end

feature {NONE} -- Implementation Properties

	initialized: BOOLEAN
			-- Is the stack initialized

	private_body_index: like body_index
			-- Associated body index

	private_routine: like routine
			-- Associated routine

	private_locals: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated locals

	private_arguments: FIXED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Associated arguments

	retrieved_arguments_count: INTEGER
			-- How many arguments were successfully retrieved from the run-time?

	retrieved_locals_count: INTEGER
			-- How many locals were successfully retrieved from the run-time (Result included if any)?

	private_result: like result_value
			-- Associated result

	unprocessed_values: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Unprocessed values (locals and args) passed
			-- by the application

	display_object_address: STRING
			-- String representing the Address of the current
			-- Object for display purpose (may contain "Unavailable")

feature	{NONE} -- Initialization of the C/Eiffel interface

	init_rout_c is
			-- Pass routine address to C.
		once
			c_pass_set_rout ($set_rout)
		end

	set_rout (melted, exhausted: BOOLEAN; object: STRING; origin: INTEGER; type: INTEGER; r_name: STRING; line_number: INTEGER) is
		do
			if exhausted then
				is_exhausted := true
			else
				dynamic_class := Eiffel_system.class_of_dynamic_id (type + 1)
				origin_class := Eiffel_system.class_of_dynamic_id (origin + 1)
				break_index := line_number
				object.to_upper
				display_object_address := "Unavailable"
				create object_address.make (10)
				object_address.append ("0x")
				object_address.append (object)
				is_melted := melted
				routine_name := clone (r_name)
			end
		end

feature {EIFFEL_CALL_STACK} -- Implementation

	is_exhausted: BOOLEAN
			-- Has all the elements of the calling stack been 
			-- received ?

feature {NONE} -- externals

	c_recv_rout_info (c: like Current) is
		external
			"C"
		end

	c_pass_set_rout (d_rout: POINTER) is
		external
			"C"
		end		

invariant

	non_empty_args_if_exists: private_arguments /= Void implies 
				not private_arguments.is_empty
	non_empty_locs_if_exists: private_locals /= Void implies 
				not private_locals.is_empty
	valid_level: level_in_stack >= 1

end -- class CALL_STACK_ELEMENT
