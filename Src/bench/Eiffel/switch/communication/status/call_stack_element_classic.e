indexing
	description	: "Information about a call in the calling stack."
	date		: "$Date$"
	revision	: "$Revision $"

class CALL_STACK_ELEMENT_CLASSIC

inherit

	EIFFEL_CALL_STACK_ELEMENT

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

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create {EIFFEL_CALL_STACK}
	make
create {STOPPED_HDLR,APPLICATION_EXECUTION_CLASSIC}
	dummy_make

feature {NONE} -- Initialization

	make (level: INTEGER) is
		do
				-- set the level
			level_in_stack := level

				-- set the private to a fake value
			private_body_index := -1

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": Creating item%N"); end
			create unprocessed_values.make(10)
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": init_recv_c%N"); end
			Init_recv_c
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%%T" + generator + ": init_rout_c%N"); end
			Init_rout_c
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%%T" + generator + ": c_recv_rout_info%N"); end
			c_recv_rout_info (Current)

			debug ("DEBUGGER_TRACE")
				if is_exhausted then
					io.error.put_string("%T%TEXHAUSTED")
				else
					io.error.put_string("%T%T")
					io.error.put_string(routine_name)
				end
				io.error.put_new_line
			end
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": Finished creating%N"); end
		end
	
	dummy_make (fn: STRING; lvl: INTEGER; mlt: BOOLEAN; br: INTEGER; addr: STRING; type, origin: INTEGER) is
			-- Initialize `Current' with no calls to the run-time.
		do
			routine_name := fn
			level_in_stack := lvl
			is_melted := mlt
			break_index := br
			dynamic_type := Eiffel_system.type_of_dynamic_id (type + 1)
			if dynamic_type /= Void then
				dynamic_class := dynamic_type.associated_class	
			end
			written_class := Eiffel_system.class_of_dynamic_id (origin + 1)
			object_address := addr
			display_object_address := object_address
				-- set the private body index to a fake value
			private_body_index := -1

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": Creating item%N"); end
			create unprocessed_values.make(10)
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": init_recv_c%N"); end
			init_recv_c
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": init_rout_c%N"); end
			init_rout_c
		end

feature -- Properties

	routine: E_FEATURE is
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose
		do
			if private_routine = Void then
				private_routine := written_class.feature_with_name (routine_name)
			end
			Result := private_routine
		end

	object_address: STRING
			-- Hector address of associated object 
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.


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
			debug ("DEBUGGER_TRACE"); 
				io.error.put_string (generator + ": receiving locals & arguments%N")
				io.error.put_string (generator + ": sending the request%N")
			end
				-- send the request
			send_rqst_1 (Rqst_dump_variables, level_in_stack)

				-- Receive the arguments.
			retrieved_arguments_count := 0
			retrieved_locals_count := 0
				-- (`item' is set to Void when no more values are expected.)
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": receiving the arguments%N"); end
			from
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				if not error then
					c_recv_value (Current)
				end
			until
				error or item = Void
			loop
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": processing value%N"); end
				unprocessed_values.extend (item)
				retrieved_arguments_count := retrieved_arguments_count + 1
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				c_recv_value (Current)
			end

				-- Receive the local entities. 
				-- user-defined, then loop variants and old expr, and finally the result if any. 
				-- (`item' is set to Void when no more values are expected).
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": receiving the locals%N"); end
			from
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				if not error then 
					c_recv_value (Current) 
				end
			until
				error or item = Void
			loop
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": processing value%N"); end
				unprocessed_values.extend (item)
				retrieved_locals_count := retrieved_locals_count + 1
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				c_recv_value (Current)
			end
		end

	initialize_stack is
		local
			local_decl_grps	: EIFFEL_LIST [TYPE_DEC_AS]
			id_list			: ARRAYED_LIST [INTEGER]
			l_count			: INTEGER
			value			: ABSTRACT_DEBUG_VALUE
			unprocessed_l	: like unprocessed_values
			locals_list		: like private_locals
			args_list		: like private_arguments
			arg_names		: LIST [STRING]
			rout			: like routine
			counter			: INTEGER
			l_names_heap: like Names_heap
		do
			debug ("DEBUGGER_TRACE_CALLSTACK")
				io.put_string (generator + ".initializing_stack: " + routine_name + " from "+dynamic_class.name+"%N")
			end
			if not is_exhausted then
				retrieve_locals_and_arguments
				set_hector_addr_for_locals_and_arguments
			end
			debug ("DEBUGGER_TRACE_CALLSTACK"); io.put_string ("Finished retrieving locals and argument"+"%N"); end
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
						l_names_heap := Names_heap
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
							value.set_name (l_names_heap.item (id_list.item))
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
					args_list.item.set_item_number (counter)
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
					locals_list.item.set_item_number (counter)
					locals_list.forth
					counter := counter + 1
				end
			end

			private_arguments := args_list
			private_locals := locals_list
			unprocessed_values := Void
			initialized := True
			debug ("DEBUGGER_TRACE_CALLSTACK"); io.put_string ("%TFinished initializating stack: "+routine_name+"%N"); end
		ensure then
			void_unprocessed: unprocessed_values = Void
		end

feature {NONE} -- Implementation Properties

	private_routine: like routine
			-- Associated routine

	retrieved_arguments_count: INTEGER
			-- How many arguments were successfully retrieved from the run-time?

	retrieved_locals_count: INTEGER
			-- How many locals were successfully retrieved from the run-time (Result included if any)?

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
				is_exhausted := True
			else
				dynamic_type := Eiffel_system.type_of_dynamic_id (type + 1)
				if dynamic_type /= Void then
					dynamic_class := dynamic_type.associated_class
					class_name := dynamic_class.name_in_upper
				end
				written_class := Eiffel_system.class_of_dynamic_id (origin + 1)

				break_index := line_number
				object.to_upper
				display_object_address := "Unavailable"
				create object_address.make (10)
				object_address.append ("0x")
				object_address.append (object)
				is_melted := melted
				routine_name := r_name

--				break_index := line_number
--				display_object_address := "Unavailable"
--				create object_address.make (10)
--				object_address.append (object)
--				object_address.to_upper
--				object_address.prepend ("0x")
--				is_melted := melted
--				routine_name := clone (r_name)
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

end -- class CALL_STACK_ELEMENT_CLASSIC
