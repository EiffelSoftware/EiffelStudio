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
	ANY

	SHARED_DBG_EVALUATOR
		export
			{NONE} all
		end

	SHARED_DEBUG
		export
			{ANY} Application
			{NONE} all
		end

feature {NONE} -- Initialization

	make_as_object (addr: like context_address) is
		do
			generic_make
			reset_dbg_evaluator
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
		end

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

feature -- Change

	reset_error is
		do
			error := 0
			error_messages.wipe_out
		end

	notify_error (a_code: INTEGER; a_tag, a_msg: STRING) is
		require
			valid_code: a_code /= 0
			valid_message: a_msg /= Void
		do
			error := error | a_code
			error_messages.extend ([a_code, a_tag, a_msg])
		end

	notify_error_evaluation (mesg: STRING) is
		do
			notify_error (cst_error_evaluation, Void, mesg)
		end

	notify_error_exception (mesg: STRING) is
		do
			notify_error (cst_error_exception, Void, mesg)
		end

	notify_error_expression_and_tag (mesg: STRING; t: STRING) is
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
					notify_error_expression_and_tag ("Error " + l_error.code + "%N" + error_to_string (l_error), l_error.code)
					error_list.forth
				end
				error_list.go_to (l_cursor)
			end
		end

	notify_error_expression (mesg: STRING) is
		do
			notify_error (cst_error_expression, Void, mesg)
		end

	notify_error_syntax (mesg: STRING) is
		do
			notify_error (cst_error_syntax, Void, mesg)
		end

	notify_error_not_implemented (mesg: STRING) is
		do
			notify_error (cst_error_not_implemented, Void, mesg)
		end

feature {NONE} -- Utility Implementation

	error_to_string (e: ERROR): STRING is
			-- Convert Error code to Error description STRING
		require
			error_not_void: e /= Void
		local
			yw: YANK_STRING_WINDOW
		do
			e.trace (yw)
			Result := yw.stored_output
		end

feature {NONE} -- Error code

	cst_error_evaluation: INTEGER is 		0x01 		--|  0b00000001 -> 0x01
	cst_error_expression: INTEGER is 		0x02 		--|  0b00000010 -> 0x02
	cst_error_exception: INTEGER is  		0x04		--|  0b00000100 -> 0x04
	cst_error_syntax: INTEGER is     		0x08		--|  0b00001000 -> 0x08
	cst_error_not_implemented: INTEGER is 	0x10		--|  0b00010000 -> 0x10

feature {NONE} -- Error message values

	Cst_error_call_on_void_target: STRING is "Error: Call on void target for "

	Cst_error_context_corrupted_or_not_found:STRING is "Context corrupted or not found"

	Cst_error_during_context_preparation: STRING is "Error occurred while retrieving the expression's context"

	Cst_error_during_expression_analyse: STRING is "Error during expression analyse"

	Cst_error_type_checking_failed : STRING is "Type checking failed"

	Cst_error_evaluation_failed_with_exception: STRING is "Evaluation failed with an exception"

	Cst_error_not_yet_ready: STRING is " : sorry not yet ready"

	Cst_error_report_to_support: STRING is " => ERROR : please report to support"

	Cst_error_other_than_func_cst_once_not_available: STRING is " => ERROR : other than function, constant and once : not available"

	Cst_error_during_evaluation_of_external_call: STRING is " => ERROR during evaluation of external call : "

	Cst_error_evaluating_parameter: STRING is " => Error evaluating parameter"

	Cst_feature_name_left_limit: STRING is "`"
	Cst_feature_name_right_limit: STRING is "'"

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

	error_messages: LINKED_LIST [TUPLE [INTEGER, STRING, STRING]]
			-- List of [Code, Tag, Message]
			-- Error's message if any otherwise Void

	short_text_from_error_messages: STRING is
		local
			details: TUPLE [INTEGER, STRING, STRING]
		do
			if not error_messages.is_empty then
				details := error_messages.first
				Result ?= details.reference_item (2)
			end
		end

	text_from_error_messages: STRING is
		local
			details: TUPLE [INTEGER, STRING, STRING]
			l_code: INTEGER
			l_tag, l_msg: STRING
		do
			create Result.make (0)
			from
				error_messages.start
			until
				error_messages.after
			loop
				details := error_messages.item
				l_code := details.integer_32_item (1)
				l_tag ?= details.reference_item (2)
				l_msg ?= details.reference_item (3)
				if l_tag /= Void then
					Result.append_string ("[" + l_tag + "] ")
				end
				Result.append_string (l_msg)
				error_messages.forth
				if not error_messages.after then
					Result.append_string (once "%N-----------------------------------%N")
				end
			end
		end

	error_occurred: BOOLEAN is
			-- Did an error occurred ?
		do
			Result := error /= 0
		end

	is_condition (f: FEATURE_I): BOOLEAN is
			-- is feature `f' a condition ?
		require
			valid_f: f /= Void
			no_error: not dbg_expression.syntax_error
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
		do
			Result := final_result_type.is_basic
				and then final_result_value.is_type_boolean
				and then final_result_value.value_boolean
		end

	final_result_static_type: CLASS_C
			-- Static type of `Current'.
			-- Only used and set in `is_condition', not in `evaluate' or `set_expression'.

feature -- Evaluation

	evaluate is
			-- Compute the value of the last message of `Current'.
		require
			dbg_expression_valid_syntax: as_object or else not dbg_expression.syntax_error
			running_and_stopped: Application.is_running and Application.is_stopped
		deferred
		ensure
			error_message_if_failed: (final_result_value = Void
										and	final_result_static_type = Void
										and final_result_type = Void)
									implies (error_occurred)
		end

invariant

	error_messages_not_void: error_messages /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
