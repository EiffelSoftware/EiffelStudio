indexing

	description: 
		"Information about a call in the calling stack.";
	date: "$Date$";
	revision: "$Revision $"

class CALL_STACK_ELEMENT

inherit

	OBJECT_ADDR;
	RECV_VALUE
		export
			{NONE} all;
			{EIFFEL_CALL_STACK} error
		end;
	COMPILER_EXPORTER;
	SHARED_EIFFEL_PROJECT;
	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

creation {EIFFEL_CALL_STACK}

	make

feature {NONE} -- Initialization

	make is
		local
			l_count: INTEGER;
		do
debug ("DEBUGGER_TRACE")
	io.error.putstring ("%T%TCreating CALL_STACK_ELEMENT: ");
end

			!! unprocessed_values.make (10);
			init_recv_c;
			init_rout_c;

			c_recv_rout_info (Current);

debug ("DEBUGGER_TRACE")
	if is_exhausted then
		io.error.putstring ("EXHAUSTED");
	else
		io.error.putstring (routine_name);
	end;
	io.error.new_line
end


			if is_melted then
					-- Receive the arguments.
					-- (`item' is set to Void when no more values 
					-- are expected.)
				from
					if not error then 	
						c_recv_value (Current) 
					end
				until
					error or item = Void
				loop
					unprocessed_values.extend (item);
					c_recv_value (Current);
				end;

					-- Receive the local entities. 
					-- (user-defined, then loop variants and old expr,
					-- and finally the result if any. `item' is set to
					-- Void when no more values are expected).
				from
					if not error then 
						c_recv_value (Current) 
					end
				until
					error or item = Void
				loop
					unprocessed_values.extend (item);
					c_recv_value (Current)
				end;
			end;
debug ("DEBUGGER_TRACE")
	io.error.putstring ("%T%TFinished creating CALL_STACK_ELEMENT%N");
end
		end;

feature -- Properties

	routine_name: STRING;
			-- Associated routine name

	is_melted: BOOLEAN;
			-- Is the associated routine melted.
			-- Only in that case can we request the locals
			-- and the arguments.

	dynamic_class: CLASS_C;
			-- Dynamic class where routine is called from

	origin_class: CLASS_C;
			-- Class where routine is written in

	routine: E_FEATURE is
			-- Routine being called
		do
			if private_routine = Void then
				private_routine := origin_class.feature_with_name (routine_name);
			end;
			Result := private_routine;
		end;

	result_value: DEBUG_VALUE is
			-- Result value of routine
		do
			if not initialized then
				initialize_stack;
			end;
			Result := private_result;
		ensure
			is_function_non_void: routine.is_function implies Result /= Void
		end;

	locals: LIST [DEBUG_VALUE] is
			-- Value of local variables
		do
			if not initialized then
				initialize_stack;
			end;
			Result := private_locals;
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.empty
		end;

	arguments: LIST [DEBUG_VALUE] is
			-- Value of arguments
		do
			if not initialized then
				initialize_stack;
			end;
			Result := private_arguments;
		ensure
			non_void_implies_not_empty: Result /= Void implies not Result.empty
		end

	object_address: STRING;
			-- Hector address of associated object 
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr' routine.

feature -- Output

	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		local
			args_list: like arguments
		do
			args_list := arguments;
			if args_list /= Void then
				from
					args_list.start;
					st.add_new_line;
					st.add_string ("Arguments:");
					st.add_new_line
				until
					args_list.after
				loop
					st.add_indent;
					args_list.item.append_to (st, 0);
					args_list.forth;
				end;
			end;
		end;

	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of 
			-- the routine associated with Current call.
		local
			local_names: SORTED_TWO_WAY_LIST [DEBUG_VALUE];
			local_decl_grps: EIFFEL_LIST [TYPE_DEC_AS];
			locals_list: like locals;
		do
			locals_list := locals;
			if locals_list /= Void or else private_result /= Void then
				st.add_new_line;
				st.add_string ("Local entities:");
				st.add_new_line
			end;
			if locals_list /= Void then
				!! local_names.make;
				from
					locals_list.start
				until	
					locals_list.after
				loop
					local_names.put_front (locals_list.item);
					locals_list.forth
				end;
				local_names.sort;
				local_decl_grps := routine.locals;
				if local_decl_grps /= Void then
					from
						local_names.start
					until
						local_names.after
					loop
						st.add_indent;
						local_names.item.append_to (st, 0);
						local_names.forth	
					end
				end
			end;
			if private_result /= Void then
					-- Display the Result entity value.
				st.add_indent;
				private_result.append_to (st, 0);
			end;
		end; 

	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		local
			c, oc: CLASS_C;
			ef: E_FEATURE;
			ft: FEATURE_TABLE;
			last_pos: INTEGER
		do
			
			c := dynamic_class;
			oc := origin_class;
				-- Print object address (14 characters)
			st.add_string ("[");
			if c /= Void then
				st.add_address (object_address, routine_name, c)
				last_pos := object_address.count + 2;
			else
				st.add_string ("0x0");
				last_pos := 5;
			end
			st.add_string ("]");
			st.add_column_number (14);
				-- Print class name
			if c /= Void then
				c.append_name (st);
				last_pos := c.name.count + 14;
			else
				st.add_string ("NOT FOUND");
				last_pos := 9 + 14 
			end;
			st.add_column_number (26);

			if is_melted then
				st.add_string ("*")
			end;
			st.add_feature_name (routine_name, oc);
			if oc /= c then
				st.add_string (" (From ");
				if oc /= Void then
					oc.append_name (st);
				else
					st.add_string ("Void")
				end;
				st.add_string (")");
			end;
		ensure
			initialized_not_changed: old initialized = initialized
		end;

feature {EIFFEL_CALL_STACK} -- Implementation

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		local
			l: like unprocessed_values
		do
			object_address := hector_addr (object_address)
			l := unprocessed_values;
			check
				not_initialized: not initialized;
				valid_unprocessed_values: l /= Void
			end;
			from
				l.start
			until
				l.after
			loop
				l.item.set_hector_addr;
				l.forth
			end;
		end;

feature {NONE} -- Implementation

	initialize_stack is
		require
			not_initialized: not initialized
		local
			local_decl_grps: EIFFEL_LIST [TYPE_DEC_AS];
			id_list: EIFFEL_LIST [ID_AS];
			l_count: INTEGER;
			locals_list: like private_locals;
			value: DEBUG_VALUE;
			unprocessed_l: like unprocessed_values;
			args_list: like private_arguments;
			feat_args: E_FEATURE_ARGUMENTS;
			arg_names: LIST [STRING];
			rout: like routine
		do
debug ("DEBUGGER_TRACE")
	io.error.putstring ("%TInitializing stack (CALL_STACK_ELEMENT): ");
	io.error.putstring (routine_name);
	io.error.putstring (" from: ");
	io.error.putstring (dynamic_class.name);
	io.error.new_line;
end
			if is_melted then
				rout := routine;
				unprocessed_l := unprocessed_values;
				unprocessed_l.start;
				if rout /= Void then
					local_decl_grps := rout.locals;
					l_count := rout.argument_count;
					if l_count > 0 then
						arg_names := rout.argument_names;
						!! args_list.make_filled (l_count);	
						from
							arg_names.start;
							args_list.start
						until
							args_list.after
						loop
							value := unprocessed_l.item;
							value.set_name (arg_names.item);
							args_list.replace (value);
							args_list.forth;
							arg_names.forth;
							unprocessed_l.forth;
						end;
					end;
					if local_decl_grps /= Void then
						!! locals_list.make (5)
						from
							l_count := 0;
							local_decl_grps.start
						until
							local_decl_grps.after
						loop 
							from
								id_list := local_decl_grps.item.id_list;
								id_list.start;
							until
								id_list.after
							loop
								value := unprocessed_l.item;
								value.set_name (id_list.item);
								locals_list.extend (value);
								id_list.forth
								unprocessed_l.forth
							end;
							local_decl_grps.forth
						end;
					end;
					if rout.is_function then
						private_result := unprocessed_values.last;
						private_result.set_name ("Result")
					end
				end
			end;
			private_arguments := args_list;
			private_locals := locals_list;
			private_locals := locals_list;
			private_routine := rout;
			unprocessed_values := Void;
			initialized := True
debug ("DEBUGGER_TRACE")
	io.error.putstring ("%TFinished initializating stack: ");
	io.error.putstring (routine_name);
	io.error.new_line
end
		ensure
			initialized: initialized;
			void_unprocessed: unprocessed_values = Void
		end;

feature {NONE} -- Implementation Properties

	initialized: BOOLEAN;
			-- Is the stack initialized

	private_routine: like routine;
			-- Associated routine

	private_locals: ARRAYED_LIST [DEBUG_VALUE];
			-- Associated locals

	private_arguments: FIXED_LIST [DEBUG_VALUE];
			-- Associated arguments

	private_result: like result_value;
			-- Associated result

	unprocessed_values: ARRAYED_LIST [DEBUG_VALUE]
			-- Unprocessed values (locals and args) passed
			-- by the application

feature	{NONE} -- Initialization of the C/Eiffel interface

	init_rout_c is
			-- Pass routine address to C.
		once
			c_pass_set_rout ($set_rout)
		end;

	set_rout (melted, exhausted: BOOLEAN;
			object: STRING; origin: INTEGER; type: INTEGER; r_name: STRING)is
		do
			if exhausted then
				is_exhausted := true;
			else
				dynamic_class := Eiffel_system.class_of_dynamic_id (type + 1);
				origin_class := Eiffel_system.class_of_dynamic_id (origin + 1);
				object.to_upper;
				!! object_address.make (10);
				object_address.append ("0x");
				object_address.append (object);
				is_melted := melted;
				routine_name := clone (r_name);
			end;
		end;

feature {EIFFEL_CALL_STACK} -- Implementation

	is_exhausted: BOOLEAN;
			-- Has all the elements of the calling stack been 
			-- received ?

feature {NONE} -- externals

	c_recv_rout_info (c: like Current) is
		external
			"C"
		end;

	c_pass_set_rout (d_rout: POINTER) is
		external
			"C"
		end;		

invariant

	non_empty_args_if_exists: private_arguments /= Void implies 
				not private_arguments.empty;
	non_empty_locs_if_exists: private_locals /= Void implies 
				not private_locals.empty;

end -- class CALL_STACK_ELEMENT
