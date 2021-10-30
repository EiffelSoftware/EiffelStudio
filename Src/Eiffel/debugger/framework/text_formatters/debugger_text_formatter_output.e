note
	description: "Routines for use by classes that need to display debugger related objects in {TEXT_FORMATTER}."

class
	DEBUGGER_TEXT_FORMATTER_OUTPUT

inherit
	DEBUGGER_TEXT_FORMATTER_VISITOR

	DEBUG_VALUE_EXPORTER

	APPLICATION_STATUS_EXPORTER

	SHARED_EIFFEL_PROJECT

	SHARED_DEBUGGER_MANAGER

	DBG_CHARACTER_ROUTINES

	SHARED_BENCH_NAMES
		rename
			names as interface_names
		end

	INTERNAL

create
	make

feature -- Make

	make
		do
		end

feature -- Generic

	append_to (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER; indent: INTEGER)
		do
			inspect v.debug_value_type_id
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.abstract_special_value_id then
				abstract_special_value_append_to (abstract_special_value (v), st, indent)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.expanded_value_id then
				expanded_value_append_to (expanded_value (v), st, indent)
			else
				abstract_debug_value_append_to (v, st, indent)
			end
		end

	append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER)
		do
			inspect v.debug_value_type_id
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.abstract_reference_value_id then
				abstract_reference_append_type_and_value (abstract_reference_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.expanded_value_id then
				expanded_value_append_type_and_value (expanded_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.abstract_special_value_id then
				abstract_special_value_append_type_and_value (abstract_special_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.character_value_id then
				character_value_append_type_and_value (character_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.character_32_value_id then
				character_32_value_append_type_and_value (character_32_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.dummy_message_debug_value_id then
				dummy_message_debug_value_append_type_and_value (dummy_message_debug_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.debug_basic_value_id then
				debug_basic_value_append_type_and_value (v, st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.exception_debug_value_id then
				exception_debug_value_append_type_and_value (exception_debug_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.eifnet_debug_unknown_type_value_id then
				eifnet_debug_unknown_type_value_append_type_and_value (eifnet_debug_unknown_type_value (v), st)
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.eifnet_debug_native_array_value_id then
				eifnet_debug_native_array_value_append_type_and_value (eifnet_debug_native_array_value (v), st)
			else
				abstract_debug_value_append_type_and_value (v, st)
			end
		end

feature -- Application status

	append_debugger_information (dbg: DEBUGGER_MANAGER; a_params: detachable DEBUGGER_EXECUTION_RESOLVED_PROFILE; tf: TEXT_FORMATTER)
			-- Append debugger information
		local
			params: detachable DEBUGGER_EXECUTION_RESOLVED_PROFILE
			ctlr: DEBUGGER_CONTROLLER
			app: APPLICATION_EXECUTION
			s: READABLE_STRING_32
			s32: STRING_32
		do
			ctlr := dbg.controller
			app := dbg.application
			if app /= Void then
				params := app.parameters
			else
				params := a_params
			end

				--| Display information
			tf.add_string ("Launching system :")
			if params /= Void then
				tf.add_new_line
				s32 := params.title
				if s32 /= Void then
					tf.add_comment ("  - profile = ")
					tf.add_quoted_text (s32)
					tf.add_new_line
				end
				tf.add_comment ("  - directory = ")
				if attached params.working_directory as wp then
					tf.add_quoted_text (wp.name)
				else
					tf.add_string ("<Empty>")
				end
				tf.add_new_line
				tf.add_comment_text ("  - arguments = ")
				s := params.arguments
				if s = Void or else s.is_empty then
					tf.add_string ("<Empty>")
				else
					tf.add_quoted_text (s)
				end
			end

--| For now useless since the output panel display those info just a few nanoseconds ...
--			if ctlr.environment_vars /= Void and then not ctlr.environment_vars.is_empty then
--				tf.add_comment_text ("  - environment : ")
--				from
--					ctlr.environment_vars.start
--				until
--					ctlr.environment_vars.after
--				loop
--					tf.add_new_line
--					tf.add_indent
--					tf.add_string (ctlr.environment_vars.key_for_iteration)
--					tf.add_string ("=")
--					tf.add_quoted_text (ctlr.environment_vars.item_for_iteration)
--					ctlr.environment_vars.forth
--				end
--			end
			tf.add_new_line
		end

	append_object (dobj: DEBUGGED_OBJECT; a_name: STRING; st: TEXT_FORMATTER)
			-- Display `dobj'
		local
			l_attr: DEBUG_VALUE_LIST
			l_cursor: like {DEBUG_VALUE_LIST}.new_cursor
			dc: CLASS_C
			n: STRING
			add: DBG_ADDRESS
		do
			dc := dobj.dynamic_class
			add := dobj.object_address
			n := a_name

			st.add_string (a_name)
			st.add_string (Colon_space_str)
			dc.append_name (st)
			st.add_string (Left_address_delim)
			if debugger_manager.safe_application_is_stopped then
				st.add_address (add.as_string, n, dc)
			else
				st.add_string (add.as_string)
			end
			st.add_string (Right_address_delim)
			st.add_new_line
			l_attr := dobj.attributes
			if l_attr /= Void then
				st.add_indent
				st.add_string ("-- Attributes --")
				st.add_new_line

				l_cursor := l_attr.new_cursor
				l_cursor.start
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					append_to (l_cursor.item, st, 2)
					l_cursor.forth
				end
				st.add_indent
				st.add_string ("-- end Attributes --");
			end
			st.add_new_line
		end

	append_status (appstatus: APPLICATION_STATUS; st: TEXT_FORMATTER)
			-- Display the status of the running application.
		local
			c, oc: CLASS_C
			f: E_FEATURE
			cs: CALL_STACK_ELEMENT
			stack_num: INTEGER
			ccs: EIFFEL_CALL_STACK
		do
			if not appstatus.is_stopped then
				st.add_string (interface_names.e_Running)
				st.add_new_line
			else -- Application is stopped.
				-- Print object address.
				st.add_string ("Stopped in object [")
				c := appstatus.dynamic_class
				f := appstatus.e_feature
				if f /= Void then
					st.add_address (appstatus.object_address.as_string, f.name_32, c)
				end
				st.add_string ("]")
				st.add_new_line
					-- Print class name.
				st.add_indent
				st.add_string ("Class: ")
				c.append_name (st)
				st.add_new_line
					-- Print routine name.
				st.add_indent
				st.add_string ("Feature: ")
				if f /= Void then
					oc := appstatus.origin_class
					f.append_name (st)
					if oc /= c then
						st.add_string (" (From ")
						oc.append_name (st)
						st.add_string (")")
					end
				else
					st.add_string ("Void")
				end
				st.add_new_line
					-- Print the reason for stopping.
				st.add_indent
				st.add_string ("Reason: ")
				inspect appstatus.reason
				when {APPLICATION_STATUS_CONSTANTS}.Pg_break then
					st.add_string (Interface_names.le_Stop_point_reached)
					st.add_new_line
				when {APPLICATION_STATUS_CONSTANTS}.Pg_interrupt then
					st.add_string (Interface_names.le_Execution_interrupted)
					st.add_new_line
				when {APPLICATION_STATUS_CONSTANTS}.Pg_raise then
					st.add_string (Interface_names.le_Explicit_exception_pending)
					st.add_new_line
					append_exception (appstatus, st)
				when {APPLICATION_STATUS_CONSTANTS}.Pg_viol then
					st.add_string (Interface_names.le_Implicit_exception_pending)
					st.add_new_line
					append_exception (appstatus, st)
				when {APPLICATION_STATUS_CONSTANTS}.Pg_update_breakpoint then
					st.add_string (Interface_names.le_Update_breakpoint)
					st.add_new_line
					append_exception (appstatus ,st)
				when {APPLICATION_STATUS_CONSTANTS}.Pg_step then
					st.add_string (Interface_names.le_Stepped)
					st.add_new_line
				else
					st.add_string (Interface_names.le_Unknown_status)
					st.add_new_line
				end
				ccs := appstatus.current_call_stack
				if not ccs.is_empty then
					stack_num := debugger_manager.application.current_execution_stack_number
					cs := ccs.i_th (stack_num)
					append_arguments (cs, st)
					append_locals (cs, st)
					append_stack (ccs, st)
				end
			end
		end

	append_exception (appstatus: APPLICATION_STATUS; st: TEXT_FORMATTER)
			-- Display exception in `st'.		
		do
			st.add_indent
			st.add_indent
			st.add_string (appstatus.exception_short_description)
			st.add_new_line
		end

feature -- Call stack

	append_stack (ecs: EIFFEL_CALL_STACK; st: TEXT_FORMATTER)
			-- Display callstack in `st'.
		local
			stack_num, i: INTEGER
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Displaying stack %N"); end
			st.add_new_line;
			st.add_string ("Call stack:");
			st.add_new_line;
			st.add_new_line;
			st.process_call_stack_item (0, False) -- For padding
			st.add_string ("Object");
			st.add_column_number (14);
			st.add_string ("Class");
			st.add_column_number (26);
			st.add_string ("Routine");
			st.add_new_line;
			st.process_call_stack_item (0, false) -- For padding
			st.add_string ("------");
			st.add_column_number (14);
			st.add_string ("-----");
			st.add_column_number (26);
			st.add_string ("-------");
			st.add_new_line;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": getting stack number %N"); end
			stack_num := debugger_manager.application.current_execution_stack_number;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": processing %N"); end
			from
				ecs.start;
				i := 1
			until
				ecs.after
			loop
				if i = stack_num then
					st.process_call_stack_item (i, true)
				else
					st.process_call_stack_item (i, false)
				end;
				append_feature (ecs.item, st)
				st.add_new_line
				ecs.forth
				i := i + 1
			end
			st.add_new_line
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": end displaying call stack %N"); end
		end

	append_arguments (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER)
			-- Display the arguments passed to the routine
			-- associated with Current call.
		local
			args_list: LIST [ABSTRACT_DEBUG_VALUE]
		do
			if attached {EIFFEL_CALL_STACK_ELEMENT} cse as ecse then
				args_list := ecse.arguments
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
						append_to (args_list.item, st, 0)
						args_list.forth
					end
				end
			end
		end

	append_locals (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER)
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		local
			resval: ABSTRACT_DEBUG_VALUE
			locals_list, ot_locals_list: LIST [ABSTRACT_DEBUG_VALUE]
		do
			if attached {EIFFEL_CALL_STACK_ELEMENT} cse as ecse then
				locals_list := ecse.locals
				ot_locals_list := ecse.object_test_locals
				resval := ecse.result_value

				if locals_list /= Void or else ot_locals_list /= Void or else resval /= Void then
					st.add_new_line
					st.add_string ("Local entities:")
					st.add_new_line
				end
				if locals_list /= Void then
					append_eiffel_locals_list (ecse, locals_list, st)
				end
				if ot_locals_list /= Void then
					append_eiffel_locals_list (ecse, ot_locals_list, st)
				end
				if resval /= Void then
						-- Display the Result entity value.
					st.add_indent
					append_to (resval, st, 0)
				end

			end
		end

	append_eiffel_locals_list (ecse: EIFFEL_CALL_STACK_ELEMENT; lst: LIST [ABSTRACT_DEBUG_VALUE]; st: TEXT_FORMATTER)
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		local
			l_names: SORTED_TWO_WAY_LIST [ABSTRACT_DEBUG_VALUE]
			local_decl_grps: EIFFEL_LIST [LIST_DEC_AS]
		do
			create l_names.make
			across
				lst as ic
			loop
				l_names.put_front (ic.item)
			end
			l_names.sort
			local_decl_grps := ecse.routine.locals
			if local_decl_grps /= Void then
				across
					l_names as ic
				loop
					st.add_indent
					append_to (ic.item, st, 0)
				end
			end
		end

	append_feature (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER)
			-- Display information about associated routine.
		local
			ecse: detachable EIFFEL_CALL_STACK_ELEMENT
			c, oc: CLASS_C
			last_pos: INTEGER
			oaddr: STRING
			s: STRING
		do
			oaddr := cse.object_address_to_string
			if attached {EIFFEL_CALL_STACK_ELEMENT} cse as l_ecse then
				ecse := l_ecse
				c := l_ecse.dynamic_class
				oc := l_ecse.written_class
			end

				-- Print object address (14 characters)
			st.add_string ("[")
			if oaddr = Void then
				st.add_string ("0x0")
				last_pos := 5
			else
				if c /= Void then
					st.add_address (oaddr, cse.routine_name_for_display, c)
					last_pos := oaddr.count + 2
				else
					st.add_string (oaddr)
					last_pos := oaddr.count + 2
				end
			end
			st.add_string ("] ")
			st.add_column_number (14)

					-- Print class name
			if c /= Void then
				c.append_name (st)
				st.add_string (" ")
				last_pos := c.name.count + 14
			elseif attached cse.class_name as l_class_name then
				st.add_string (l_class_name)
				last_pos := l_class_name.count + 14
			else
				st.add_string ("NOT FOUND ")
				last_pos := 9 + 14
			end
			st.add_column_number (26)

			if oc /= Void then
				st.add_feature_name (cse.routine_name_for_display, oc)
				if oc /= c then
					st.add_string (" (From ")
					if oc /= Void then
						oc.append_name (st)
					else
						st.add_string ("Void")
					end
					st.add_string (")")
				end
			else
				st.add_string (cse.routine_name_for_display)
			end
			if ecse /= Void then
				create s.make_empty
				if ecse.is_melted then
					s.append_character ('*')
				end
				if ecse.has_rescue then
					s.append_character ('R')
				end
				if not s.is_empty then
					st.add_string (" <")
					st.add_string (s)
					st.add_string (">")
				end
			end

				-- print line number
			st.add_string(" ( @ ")
			st.add_int(cse.break_index)
			st.add_string(" )")
		end

feature {NONE} -- append_to implementation

	abstract_debug_value_append_to (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER; indent: INTEGER)
		require
			valid_st: st /= Void;
			valid_indent: indent >= 0;
			valid_name: v.name /= Void
		do
			append_tabs (st, indent)
			if v.is_attribute then
				st.add_feature_name (v.name, v.e_class)
			else
				st.add_string (v.name)
			end
			st.add (Colon_space_str)
			append_type_and_value (v, st)
			st.add_new_line
		end

	abstract_special_value_append_to (v: ABSTRACT_SPECIAL_VALUE; st: TEXT_FORMATTER; indent: INTEGER)
		local
			is_special_of_char: BOOLEAN
			char_value: CHARACTER_VALUE
			l_items: DEBUG_VALUE_LIST
			l_cursor: like {DEBUG_VALUE_LIST}.new_cursor
			dc: CLASS_C
			n: STRING
			add: DBG_ADDRESS
		do
--| fixme : what about character_32 ?
			append_tabs (st, indent)
			n := v.name
			st.add_feature_name (n, v.e_class)
			st.add_string (Colon_space_str)
			dc := v.dynamic_class
			dc.append_name (st)
			st.add_string (Left_address_delim)
			add := v.address
			if debugger_manager.safe_application_is_stopped then
				st.add_address (add.as_string, n, dc)
			else
				st.add_string (add.as_string)
			end
			st.add_string (Right_address_delim)
			l_items := v.items
			if l_items /= Void then
				st.add_new_line
				append_tabs (st, indent + 1)
				st.add_string ("-- begin special object --")
				st.add_new_line

				if v.sp_lower > 0 then
					append_tabs (st, indent + 2)
					st.add_string ("... Items skipped ...")
					st.add_new_line
				end

				l_cursor := l_items.new_cursor
				if l_items.count /= 0 then
					l_cursor.start
					if attached {CHARACTER_VALUE} l_cursor.item as cv then
						char_value := cv
						is_special_of_char := True
					else
						char_value := Void
						is_special_of_char := False
					end
				end
				if not is_special_of_char then
					from
						l_cursor.start
					until
						l_cursor.after
					loop
						append_to (l_cursor.item, st, indent + 2)
						l_cursor.forth
					end;
				else
					st.add_string ("%"")
					from
						l_cursor.start
					until
						l_cursor.after
					loop
						if attached {CHARACTER_VALUE} l_cursor.item as cv then
							char_value := cv
						else
							char_value := Void
						end
						check valid_character_element: char_value /= Void end
						st.add_char (char_value.value)
						l_cursor.forth
					end;
					st.add_string ("%"")
					st.add_new_line
				end
				if 0 <= v.sp_upper and v.sp_upper < v.capacity - 1 then
					append_tabs (st, indent + 2);
					st.add_string ("... More items ...");
					st.add_new_line
				end
				append_tabs (st, indent + 1);
				st.add_string ("-- end special object --");
			end

			st.add_new_line
		end

	expanded_value_append_to (v: EXPANDED_VALUE; st: TEXT_FORMATTER; indent: INTEGER)
		local
			ec: CLASS_C;
			l_cursor: like {DEBUG_VALUE_LIST}.new_cursor
		do
			append_tabs (st, indent);
			st.add_feature_name (v.name, v.e_class)
			st.add_string (": expanded ");
			ec := v.dynamic_class;
			if ec /= Void then
				ec.append_name (st);
				st.add_new_line;
				append_tabs (st, indent + 1);
				st.add_string ("-- begin sub-object --");
				st.add_new_line;
				from
					l_cursor := v.attributes.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					append_to (l_cursor.item, st, indent + 2)
					l_cursor.forth
				end;
				append_tabs (st, indent + 1);
				st.add_string ("-- end sub-object --");
				st.add_new_line
			else
				Any_class.append_name (st);
				st.add_string (Is_unknown)
			end
		end

feature {NONE} -- append_type_and_value implementation

	abstract_debug_value_append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
		end

	abstract_reference_append_type_and_value (v: ABSTRACT_REFERENCE_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		local
			ec: CLASS_C
			add: DBG_ADDRESS
		do
			if v.is_null then
				st.add_string (NONE_representation)
			else
				ec := v.dynamic_class;
				if ec /= Void then
					ec.append_name (st);
					st.add_string (Left_address_delim)
					add := v.address
					if debugger_manager.safe_application_is_stopped then
						st.add_address (add.as_string, v.name, ec)
					else
						st.add_string (add.as_string)
					end;
					st.add_string (Right_address_delim);
					if attached v.string_value as s then
						st.add_string (Equal_sign_str)
						st.add_string (s)
					end
				else
					Any_class.append_name (st)
					st.add_string (" = Unknown")
				end
			end
		end

	expanded_value_append_type_and_value (v: EXPANDED_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		local
			ec: CLASS_C;
		do
			ec := v.dynamic_class
			if ec /= Void then
				ec.append_name (st)
			end
		end

	abstract_special_value_append_type_and_value (v: ABSTRACT_SPECIAL_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		local
			ec: CLASS_C
		do
			if v.address = Void then
				st.add_string (NONE_representation)
			else
				ec := v.dynamic_class;
				if ec /= Void then
					ec.append_name (st);
					st.add_string (Left_address_delim);
					if debugger_manager.safe_application_is_stopped then
						st.add_address (v.address.as_string, v.name, ec)
					else
						st.add_string (v.address.as_string)
					end
					st.add_string (Right_address_delim)
				else
					Any_class.append_name (st)
					st.add_string (Is_unknown)
				end
			end
		end

	character_value_append_type_and_value (v: CHARACTER_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			v.dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_char ('%'');
			st.add_string (char_text (v.value));
			st.add_char ('%'')
		end

	character_32_value_append_type_and_value (v: CHARACTER_32_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			v.dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_char ('%'');
			st.add_string (wchar_text (v.value));
			st.add_char ('%'')
		end

	dummy_message_debug_value_append_type_and_value (v: DUMMY_MESSAGE_DEBUG_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			if attached v.display_message as s then
				st.add_string (s)
			end
		end

	debug_basic_value_append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			v.dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_string (v.output_value)
		end

	exception_debug_value_append_type_and_value (v: EXCEPTION_DEBUG_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			st.add_string (v.short_description)
		end

	eifnet_debug_unknown_type_value_append_type_and_value (v: EIFNET_DEBUG_UNKNOWN_TYPE_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			st.add_string ("ERROR: Unknown type")
			st.add_string (Equal_sign_str);
			st.add_string (v.address.as_string)
		end

	eifnet_debug_native_array_value_append_type_and_value (v: EIFNET_DEBUG_NATIVE_ARRAY_VALUE; st: TEXT_FORMATTER)
		require
			v_set: v /= Void
		do
			st.add_string (v.type_and_value)
		end

feature {NONE} -- Conversion

	abstract_reference_value (v: ABSTRACT_DEBUG_VALUE): ABSTRACT_REFERENCE_VALUE
		require
			is_abstract_reference_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.abstract_reference_value_id
		do
			check is_abstract_reference_value: attached {ABSTRACT_REFERENCE_VALUE} v as rf then
				Result := rf
			end
		end

	expanded_value (v: ABSTRACT_DEBUG_VALUE): EXPANDED_VALUE
		require
			is_expanded_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.expanded_value_id
		do
			check is_expanded_value: attached {EXPANDED_VALUE} v as ev then
				Result := ev
			end
		end

	abstract_special_value (v: ABSTRACT_DEBUG_VALUE): ABSTRACT_SPECIAL_VALUE
		require
			is_abstract_special_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.abstract_special_value_id
		do
			check is_abstract_special_value: attached {ABSTRACT_SPECIAL_VALUE} v as sv then
				Result := sv
			end
		end

	character_value (v: ABSTRACT_DEBUG_VALUE): CHARACTER_VALUE
		require
			is_character_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.character_value_id
		do
			check is_character_value: attached {CHARACTER_VALUE} v as cv then
				Result := cv
			end
		end

	character_32_value (v: ABSTRACT_DEBUG_VALUE): CHARACTER_32_VALUE
		require
			is_character_32_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.character_32_value_id
		do
			check is_character_32_value: attached {CHARACTER_32_VALUE} v as l_value then
				Result := l_value
			end
		end

	dummy_message_debug_value (v: ABSTRACT_DEBUG_VALUE): DUMMY_MESSAGE_DEBUG_VALUE
		require
			is_dummy_message_debug_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.dummy_message_debug_value_id
		do
			check is_dummy_message_debug_value: attached {DUMMY_MESSAGE_DEBUG_VALUE} v as l_value then
				Result := l_value
			end
		end

	exception_debug_value (v: ABSTRACT_DEBUG_VALUE): EXCEPTION_DEBUG_VALUE
		require
			is_exception_debug_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.exception_debug_value_id
		do
			check is_exception_debug_value: attached {EXCEPTION_DEBUG_VALUE} v as l_value then
				Result := l_value
			end
		end

	eifnet_debug_unknown_type_value (v: ABSTRACT_DEBUG_VALUE): EIFNET_DEBUG_UNKNOWN_TYPE_VALUE
		require
			is_eifnet_debug_unknown_type_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.eifnet_debug_unknown_type_value_id
		do
			check is_eifnet_debug_unknown_type_value: attached {EIFNET_DEBUG_UNKNOWN_TYPE_VALUE} v as l_value then
				Result := l_value
			end
		end

	eifnet_debug_native_array_value (v: ABSTRACT_DEBUG_VALUE): EIFNET_DEBUG_NATIVE_ARRAY_VALUE
		require
			is_eifnet_debug_native_array_value: v.debug_value_type_id = {ABSTRACT_DEBUG_VALUE_CONSTANTS}.eifnet_debug_native_array_value_id
		do
			check is_eifnet_debug_native_array_value: attached {EIFNET_DEBUG_NATIVE_ARRAY_VALUE} v as l_value then
				Result := l_value
			end
		end

feature {NONE} -- Implementation

	Any_class: CLASS_C
		once
			Result := Eiffel_system.any_class.compiled_class
		end

feature {NONE} -- Constants		

	NONE_representation: STRING = "NONE = Void"

	Space_str: STRING = " "

	Left_address_delim: STRING = " <"

	Right_address_delim: STRING = ">"

	Colon_space_str: STRING = ": "

	Left_bracket: STRING = " ["

	Right_bracket: STRING = "]"

	Equal_sign_str: STRING = " = "

	Is_unknown: STRING = " = Unknown"

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
