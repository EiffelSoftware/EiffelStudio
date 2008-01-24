indexing
	description: "Routines for use by classes that need to display debugger related objects in TEXT_FORMATTER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_TEXT_FORMATTER_OUTPUT

inherit
	DEBUGGER_TEXT_FORMATTER_VISITOR

	DEBUG_VALUE_EXPORTER

	APPLICATION_STATUS_EXPORTER

	SHARED_EIFFEL_PROJECT

	SHARED_DEBUGGER_MANAGER

	CHARACTER_ROUTINES

	EB_CONSTANTS

	INTERNAL

create
	make

feature -- Make

	make is
		do
		end

feature -- Generic

	append_to (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER; indent: INTEGER) is
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

	append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER) is
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
			when {ABSTRACT_DEBUG_VALUE_CONSTANTS}.bits_value_id then
				bits_value_append_type_and_value (bits_value (v), st)
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

	append_debugger_information (dbg: DEBUGGER_MANAGER; a_params: DEBUGGER_EXECUTION_PARAMETERS; tf: TEXT_FORMATTER) is
			-- Append debugger information
		local
			params: DEBUGGER_EXECUTION_PARAMETERS
			ctlr: DEBUGGER_CONTROLLER
			app: APPLICATION_EXECUTION
			s: STRING
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
			tf.add_new_line
			tf.add_comment ("  - directory = ")
			if params /= Void then
				s := params.working_directory
			end
			if s /= Void then
				tf.add_quoted_text (s)
			else
				tf.add_string ("<Empty>")
			end
			tf.add_new_line
			tf.add_comment_text ("  - arguments = ")
			if params /= Void then
				s := params.arguments
			end
			if s = Void or else s.is_empty then
				tf.add_string ("<Empty>")
			else
				tf.add_quoted_text (s)
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

	append_object (dobj: DEBUGGED_OBJECT; a_name: STRING; st: TEXT_FORMATTER) is
			-- Display `dobj'
		local
			l_attr: DS_LIST [ABSTRACT_DEBUG_VALUE]
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			dc: CLASS_C
			n: STRING
			add: STRING
		do
			dc := dobj.dtype
			add := dobj.object_address
			n := a_name

			st.add_string (a_name)
			st.add_string (Colon_space_str)
			dc.append_name (st)
			st.add_string (Left_address_delim)
			if debugger_manager.safe_application_is_stopped then
				st.add_address (add, n, dc)
			else
				st.add_string (add)
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

	append_status (appstatus: APPLICATION_STATUS; st: TEXT_FORMATTER) is
			-- Display the status of the running application.
		local
			c, oc: CLASS_C
			f: E_FEATURE
			cs: CALL_STACK_ELEMENT
			stack_num: INTEGER
			ccs: EIFFEL_CALL_STACK
		do
			if not appstatus.is_stopped then
				st.add_string (interface_names.ee_Running)
				st.add_new_line
			else -- Application is stopped.
				-- Print object address.
				st.add_string ("Stopped in object [")
				c := appstatus.dynamic_class
				f := appstatus.e_feature
				if f /= Void then
					st.add_address (appstatus.object_address, f.name, c)
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
				when {APPLICATION_STATUS_CONSTANTS}.Pg_new_breakpoint then
					st.add_string (Interface_names.le_New_breakpoint)
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

	append_exception (appstatus: APPLICATION_STATUS; st: TEXT_FORMATTER) is
			-- Display exception in `st'.		
		do
			st.add_indent
			st.add_indent
			st.add_string (appstatus.exception_short_description)
			st.add_new_line
		end

feature -- Call stack

	append_stack (ecs: EIFFEL_CALL_STACK; st: TEXT_FORMATTER) is
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

	append_arguments (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		local
			ecse: EIFFEL_CALL_STACK_ELEMENT
			args_list: LIST [ABSTRACT_DEBUG_VALUE]
		do
			ecse ?= cse
			if ecse /= Void then
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

	append_locals (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER) is
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		local
			ecse: EIFFEL_CALL_STACK_ELEMENT
			resval: ABSTRACT_DEBUG_VALUE

			local_names: SORTED_TWO_WAY_LIST [ABSTRACT_DEBUG_VALUE]
			local_decl_grps: EIFFEL_LIST [TYPE_DEC_AS]
			locals_list: LIST [ABSTRACT_DEBUG_VALUE]
		do
			ecse ?= cse
			if ecse /= Void then
				locals_list := ecse.locals
				resval := ecse.result_value

				if locals_list /= Void or else resval /= Void then
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
					local_decl_grps := ecse.routine.locals
					if local_decl_grps /= Void then
						from
							local_names.start
						until
							local_names.after
						loop
							st.add_indent
							append_to (local_names.item, st, 0)
							local_names.forth
						end
					end
				end
				if resval /= Void then
						-- Display the Result entity value.
					st.add_indent
					append_to (resval, st, 0)
				end

			end
		end

	append_feature (cse: CALL_STACK_ELEMENT; st: TEXT_FORMATTER) is
			-- Display information about associated routine.
		local
			ecse: EIFFEL_CALL_STACK_ELEMENT
			c, oc	: CLASS_C
			last_pos: INTEGER
			oaddr: STRING
			s: STRING
		do
			oaddr := cse.display_object_address
			ecse ?= cse
			if ecse /= Void then
				c := ecse.dynamic_class
				oc := ecse.written_class
			end

				-- Print object address (14 characters)
			st.add_string ("[")
			if oaddr = Void then
				st.add_string ("0x0")
				last_pos := 5
			else
				if c /= Void then
					st.add_address (oaddr, cse.routine_name, c)
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
			elseif cse.class_name /= Void then
				st.add_string (cse.class_name)
				last_pos := cse.class_name.count + 14
			else
				st.add_string ("NOT FOUND ")
				last_pos := 9 + 14
			end
			st.add_column_number (26)

			if oc /= Void then
				st.add_feature_name (cse.routine_name, oc)
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
				st.add_string (cse.routine_name)
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

	abstract_debug_value_append_to (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER; indent: INTEGER) is
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

	abstract_special_value_append_to (v: ABSTRACT_SPECIAL_VALUE; st: TEXT_FORMATTER; indent: INTEGER) is
		local
			is_special_of_char: BOOLEAN
			char_value: CHARACTER_VALUE
			l_items: DS_LIST [ABSTRACT_DEBUG_VALUE]
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			dc: CLASS_C
			n: STRING
			add: STRING
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
				st.add_address (add, n, dc)
			else
				st.add_string (add)
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
					char_value ?= l_cursor.item
					is_special_of_char := char_value /= Void
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
						char_value ?= l_cursor.item
						check
							valid_character_element: char_value /= Void
						end
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

	expanded_value_append_to (v: EXPANDED_VALUE; st: TEXT_FORMATTER; indent: INTEGER) is
		local
			ec: CLASS_C;
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
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

	abstract_debug_value_append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER) is
		do
		end

	abstract_reference_append_type_and_value (v: ABSTRACT_REFERENCE_VALUE; st: TEXT_FORMATTER) is
		local
			ec: CLASS_C
			s: STRING_32
			add: STRING
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
						st.add_address (add, v.name, ec)
					else
						st.add_string (add)
					end;
					st.add_string (Right_address_delim);
					s := v.string_value
					if s /= Void then
						st.add_string (Equal_sign_str);
						st.add_string (s.as_string_8)
					end
				else
					Any_class.append_name (st);
					st.add_string (" = Unknown")
				end
			end
		end

	expanded_value_append_type_and_value (v: EXPANDED_VALUE; st: TEXT_FORMATTER) is
		local
			ec: CLASS_C;
		do
			ec := v.dynamic_class
			if ec /= Void then
				ec.append_name (st)
			end
		end

	abstract_special_value_append_type_and_value (v: ABSTRACT_SPECIAL_VALUE; st: TEXT_FORMATTER) is
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
						st.add_address (v.address, v.name, ec)
					else
						st.add_string (v.address)
					end
					st.add_string (Right_address_delim)
				else
					Any_class.append_name (st)
					st.add_string (Is_unknown)
				end
			end
		end

	character_value_append_type_and_value (v: CHARACTER_VALUE; st: TEXT_FORMATTER) is
		do
			v.dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_char ('%'');
			st.add_string (char_text (v.value));
			st.add_char ('%'')
		end

	character_32_value_append_type_and_value (v: CHARACTER_32_VALUE; st: TEXT_FORMATTER) is
		do
			v.dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_char ('%'');
			st.add_string (wchar_text (v.value));
			st.add_char ('%'')
		end

	bits_value_append_type_and_value (v: BITS_VALUE; st: TEXT_FORMATTER) is
		local
			val: STRING
		do
			st.add_classi (v.dynamic_class.lace_class, "BIT");
			st.add (Space_str);
			val := v.value
			st.add_int (val.count - 1);
			st.add (Equal_sign_str);
			st.add (val)
		end

	dummy_message_debug_value_append_type_and_value (v: DUMMY_MESSAGE_DEBUG_VALUE; st: TEXT_FORMATTER) is
		local
			s: STRING_GENERAL
		do
			s := v.display_message
			if s /= Void then
				st.add_string (s.as_string_8)
			end
		end

	debug_basic_value_append_type_and_value (v: ABSTRACT_DEBUG_VALUE; st: TEXT_FORMATTER) is
		do
			v.dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_string (v.output_value)
		end

	exception_debug_value_append_type_and_value (v: EXCEPTION_DEBUG_VALUE; st: TEXT_FORMATTER) is
		do
			st.add_string (v.short_description)
		end

	eifnet_debug_unknown_type_value_append_type_and_value (v: EIFNET_DEBUG_UNKNOWN_TYPE_VALUE; st: TEXT_FORMATTER) is
		do
			st.add_string ("ERROR: Unknown type")
			st.add_string (Equal_sign_str);
			st.add_string (v.address)
		end

	eifnet_debug_native_array_value_append_type_and_value (v: EIFNET_DEBUG_NATIVE_ARRAY_VALUE; st: TEXT_FORMATTER) is
		do
			st.add_string (v.type_and_value)
		end

feature {NONE} -- Conversion

	abstract_reference_value (v: ABSTRACT_DEBUG_VALUE): ABSTRACT_REFERENCE_VALUE is
		do
			Result ?= v
		end
	expanded_value (v: ABSTRACT_DEBUG_VALUE): EXPANDED_VALUE is
		do
			Result ?= v
		end
	abstract_special_value (v: ABSTRACT_DEBUG_VALUE): ABSTRACT_SPECIAL_VALUE is
		do
			Result ?= v
		end
	character_value (v: ABSTRACT_DEBUG_VALUE): CHARACTER_VALUE is
		do
			Result ?= v
		end
	character_32_value (v: ABSTRACT_DEBUG_VALUE): CHARACTER_32_VALUE is
		do
			Result ?= v
		end
	bits_value (v: ABSTRACT_DEBUG_VALUE): BITS_VALUE is
		do
			Result ?= v
		end
	dummy_message_debug_value (v: ABSTRACT_DEBUG_VALUE): DUMMY_MESSAGE_DEBUG_VALUE is
		do
			Result ?= v
		end
	exception_debug_value (v: ABSTRACT_DEBUG_VALUE): EXCEPTION_DEBUG_VALUE is
		do
			Result ?= v
		end
	eifnet_debug_unknown_type_value (v: ABSTRACT_DEBUG_VALUE): EIFNET_DEBUG_UNKNOWN_TYPE_VALUE is
		do
			Result ?= v
		end
	eifnet_debug_native_array_value (v: ABSTRACT_DEBUG_VALUE): EIFNET_DEBUG_NATIVE_ARRAY_VALUE is
		do
			Result ?= v
		end

feature {NONE} -- Implementation

	Any_class: CLASS_C is
		once
			Result := Eiffel_system.any_class.compiled_class
		end

feature {NONE} -- Constants		

	NONE_representation: STRING is "NONE = Void"

	Space_str: STRING is " "

	Left_address_delim: STRING is " <"

	Right_address_delim: STRING is ">"

	Colon_space_str: STRING is ": "

	Left_bracket: STRING is " ["

	Right_bracket: STRING is "]"

	Equal_sign_str: STRING is " = "

	Is_unknown: STRING is " = Unknown"

	Bit_label: STRING is "BIT ";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
