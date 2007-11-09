indexing
	description : "Objects used to evaluate a DBG_EXPRESSION ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	DBG_EXPRESSION_EVALUATOR

inherit

	SHARED_DEBUGGER_MANAGER

	SHARED_BENCH_NAMES

feature {NONE} -- Initialization

	make_as_object (addr: like context_address) is
		do
			generic_make
			set_context_address (addr)
			set_as_object  (True)
			set_on_object  (True)
			set_on_context (False)
			set_on_class   (False)
		end

	make_with_expression (expr: like dbg_expression) is
			-- Create Current from `expr'.
		require
			expr_not_void: expr /= Void
		do
			generic_make
			dbg_expression := expr
		end

	generic_make is
		do
			error := 0
			create error_messages.make

			debugger_manager.reset_dbg_evaluator
			get_dbg_evaluator
		end

	get_dbg_evaluator is
			-- Get non void dbg_evaluator
		do
			if dbg_evaluator = Void then
				dbg_evaluator := debugger_manager.dbg_evaluator
			end
		end

	dbg_evaluator: DBG_EVALUATOR
			-- cached dbg evaluator

feature -- change

	set_on_class (v: like on_class) is
			-- set value of `on_class' with `v'
		do
			on_class := v
		end

	set_as_object (v: like as_object) is
			-- set value of `as_object' with `v'
		do
			as_object := v
		end

	set_on_object (v: like on_object) is
			-- set value of `on_object' with `v'	
		do
			on_object := v
		end

	set_on_context (v: like on_context) is
			-- set value of `on_context' with `v'	
		do
			on_context := v
		end

	set_context_class (c: like context_class) is
			-- set value of `context_class' with `c'
		do
			context_class := c
		end

	set_context_address (c: like context_address) is
			-- set value of `context_address' with `c'
		do
			context_address := c
		end

feature -- Properties

	dbg_expression: DBG_EXPRESSION
			-- Current expression to evaluate

	dbg_expression_has_syntax_error: BOOLEAN is
		do
			Result := dbg_expression.has_syntax_error
		end

	on_class: BOOLEAN
			-- Is the expression relative to a class ?

	as_object: BOOLEAN
			-- Is the expression pointing to the object ?

	on_object: BOOLEAN
			-- Is the expression relative to an object ?

	on_context: BOOLEAN
			-- Is the expression relative to a context ?	

	context_class_type: CLASS_TYPE
			-- Class related to the target, in on_object context	

	context_class: CLASS_C
			-- Class related to the expression

	context_address: STRING
			-- Object's address related to the expression	

	as_auto_expression: BOOLEAN
			-- Evaluate as auto expression ?

feature -- Change

	reset_error is
		do
			error := 0
			error_messages.wipe_out
		end

	set_as_auto_expression (b: like as_auto_expression) is
			-- Set `as_auto_expression' with `b'
		do
			as_auto_expression := b
		end

feature -- Error notification

	notify_error (a_code: INTEGER; a_tag, a_msg: STRING_GENERAL) is
		require
			valid_code: a_code /= 0
			valid_message: a_msg /= Void
		local
			l_tag: STRING_32
		do
			error := error | a_code
			if a_tag /= Void then
				l_tag := a_tag.as_string_32
			end
			error_messages.extend ([a_code, l_tag, a_msg.as_string_32])
		end

	notify_error_evaluation (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_evaluation, Void, mesg)
		end

	notify_error_exception (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_exception, Void, mesg)
		end

	notify_error_expression_and_tag (mesg: STRING_GENERAL; t: STRING_GENERAL) is
		do
			notify_error (cst_error_expression, t, mesg)
		end

	notify_error_list_expression_and_tag (error_list: LINKED_LIST [ERROR]) is
		local
			l_error: ERROR
			l_cursor: LINKED_LIST_CURSOR [ERROR]
		do
			if error_list /= Void then
				l_cursor := error_list.cursor
				from
					error_list.start
				until
					error_list.after
				loop
					l_error := error_list.item
					notify_error_expression_error (l_error)
					error_list.forth
				end
				error_list.go_to (l_cursor)
			end
		end

	notify_error_expression_error (err: ERROR) is
		local
			msg32: STRING_32
			tag: STRING
		do
			msg32 := "Error "
			msg32.append_string (err.code)
			msg32.append_character ('%N')
			msg32.append_string_general (error_to_string (err))
			tag := err.code
			if tag /= Void then
				notify_error_expression_and_tag (msg32, tag.as_string_32)
			else
				notify_error_expression (msg32)
			end
		end

	notify_error_expression (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_expression, Void, mesg)
		end

	notify_error_syntax (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_syntax, Void, mesg)
		end

	notify_error_not_implemented (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_not_implemented, Void, mesg)
		end

	notify_error_evaluation_limited_for_auto_expression is
		do
			notify_error (cst_error_evaluation, Void, debugger_names.cst_error_evaluation_limited_for_auto_expression)
		end

	notify_error_evaluation_call_on_void (fname: STRING_GENERAL) is
		do
			notify_error_evaluation (Debugger_names.msg_error_call_on_void_target (fname))
		end

	notify_error_evaluation_report_to_support (a: ANY) is
		require
			a_not_void: a /= Void
		do
			notify_error_evaluation (Debugger_names.msg_error_report_to_support (a))
		end

	notify_error_evaluation_during_call_evaluation (a: ANY; fname: STRING_GENERAL) is
		require
			a_not_void: a /= Void
			fname_not_void: fname /= Void
		do
			notify_error_evaluation (Debugger_names.msg_error_during_evaluation_of_call (a, fname))
		end

	notify_error_not_implemented_and_ready (a: ANY; s: STRING_GENERAL; t: STRING_GENERAL) is
		require
			a_not_void: a /= Void
		local
			s32: STRING_32
		do
			if s = Void then
				s32 := ""
			else
				s32 := s.as_string_32
			end
			if t = Void then
				notify_error_not_implemented (Debugger_names.msg_error_not_yet_ready (a, s32))
			else
				notify_error_not_implemented (Debugger_names.msg_error_not_yet_ready_for (a, s32, t))
			end
		end

feature {NONE} -- Utility Implementation

	error_to_string (e: ERROR): STRING_32 is
			-- Convert Error code to Error description STRING
		require
			error_not_void: e /= Void
		local
			yw: YANK_STRING_WINDOW
		do
			create yw.make
			e.trace (yw)
			Result := yw.stored_output
		end

feature {NONE} -- Error code

	cst_error_evaluation: INTEGER is 		0x01 		--|  0b00000001 -> 0x01
	cst_error_expression: INTEGER is 		0x02 		--|  0b00000010 -> 0x02
	cst_error_exception: INTEGER is  		0x04		--|  0b00000100 -> 0x04
	cst_error_syntax: INTEGER is     		0x08		--|  0b00001000 -> 0x08
	cst_error_not_implemented: INTEGER is 	0x10		--|  0b00010000 -> 0x10

feature -- Access

	has_error_evaluation: BOOLEAN is
		do
			Result := error & cst_error_evaluation > 0
		end

	has_error_expression: BOOLEAN is
		do
			Result := error & cst_error_expression > 0
		end

	has_error_exception: BOOLEAN is
		do
			Result := error & cst_error_exception > 0
		end

	has_error_syntax: BOOLEAN is
		do
			Result := error & cst_error_syntax > 0
		end

	has_error_not_implemented: BOOLEAN is
		do
			Result := error & cst_error_not_implemented > 0
		end

	error: INTEGER

	error_messages: LINKED_LIST [TUPLE [code: INTEGER; tag: STRING_32; msg: STRING_32]]
			-- List of [Code, Tag, Message]
			-- Error's message if any otherwise Void

	short_text_from_error_messages: STRING_32 is
		local
			details: TUPLE [code: INTEGER; tag: STRING_32; msg: STRING_32]
		do
			if not error_messages.is_empty then
				details := error_messages.first
				Result := details.tag
			end
		end

	text_from_error_messages: STRING_32 is
		local
			details: TUPLE [code: INTEGER; tag: STRING_32; msg: STRING_32]
			l_code: INTEGER
			l_tag, l_msg: STRING_32
		do
			create Result.make (0)
			from
				error_messages.start
			until
				error_messages.after
			loop
				details := error_messages.item
				l_code := details.code
				l_tag := details.tag
				l_msg := details.msg
				if l_tag /= Void then
					Result.append_character ('[')
					Result.append (l_tag)
					Result.append ("] ")
				end
				if l_msg /= Void then
					Result.append (l_msg)
				end
				error_messages.forth
				if not error_messages.after then
					Result.append ("%N-----------------------------------%N")
				end
			end
		end

	error_occurred: BOOLEAN is
			-- Did an error occurred ?
		do
			Result := error /= 0
		end

	is_boolean_expression (f: FEATURE_I): BOOLEAN is
			-- is feature `f' a boolean expression ?
		require
			valid_f: f /= Void
			no_error: not dbg_expression_has_syntax_error
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		deferred
		end

	final_result_type: CLASS_C
			-- Dynamic type of `final_result'.
			--| Should be its dynamic type, but for implementation reasons
			--| it may be the static type instead.
			--| Only valid after `evaluate' was called.

	final_result_value: DUMP_VALUE
			-- In case `Current' doesn't produce an ABSTRACT_DEBUG_VALUE,
			-- it returns a DUMP_VALUE (which doesn't represent an object, just a value).
			-- This is the case for constants.
			-- Note: it is not possible to call features on expressions that do not
			-- return an object.

	final_result_is_true_boolean_value: BOOLEAN is
			-- if final_result is a boolean
			-- return its value
			-- otherwise return False .
		local
			dmvb: DUMP_VALUE_BASIC
		do
			if final_result_type.is_basic then
				dmvb ?= final_result_value
				if dmvb = Void then
					dmvb ?= final_result_value.to_basic
				end
				if dmvb /= Void then
					Result := dmvb.is_type_boolean and then dmvb.value_boolean
				end
			end
		end

	final_result_static_type: CLASS_C
			-- Static type of `Current'.
			-- Only used and set in `is_condition', not in `evaluate' or `set_expression'.

feature {DBG_EXPRESSION} -- Evaluation

	evaluate (keep_assertion_checking: BOOLEAN) is
			-- Compute the value of the last message of `Current'.
		require
			dbg_expression_valid_syntax: as_object or else not dbg_expression.has_syntax_error
			running_and_stopped: debugger_manager.safe_application_is_stopped
		do
			reset_error
			get_dbg_evaluator

				--| Clean evaluation.
			final_result_static_type := Void
			final_result_type := Void
			final_result_value := Void
		end

invariant

	error_messages_not_void: error_messages /= Void

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

end -- class DBG_EXPRESSION_EVALUATOR
