indexing
	description: "Objects that handles debugger evaluation error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	fixme: "use MULTI_ERROR_MANAGER"

class
	DBG_ERROR_HANDLER

inherit
	SHARED_ERROR_TRACER
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialixation

	make
			-- Initialize Current
		do
			error := 0
			create error_list.make
			initialized := True
		ensure
			initialized: initialized
		end

feature -- Element change

	append (errhdl: DBG_ERROR_HANDLER)
			-- Append error from `errhdl'
		do
			error := error | errhdl.error
			error_list.append (errhdl.error_list)
		end

feature -- Access

	error: INTEGER
			-- Error code
			--| 4 main error categories
			--| 	- Syntax:
			--| 	- Expression: issue getting the context or the byte node
			--| 	- Evaluation: exception catched at the dbg level, or not yet implemented ...
			--| 	- Exception: unhandled exception, mainly internal issue from the debugger's code
			--|
			--| the left  4 bits are used to specify the category of the error
			--| the right 4 bits are used to identified each error whithin its category

	error_list: LINKED_LIST [DBG_ERROR]
			-- List of [Code, Tag, Message]
			-- Error's message if any otherwise Void

feature -- Status report

	initialized: BOOLEAN
			-- Is Current initialized?

	error_occurred: BOOLEAN is
			-- Did an error occurred ?
		do
			Result := error /= 0
		end

	has_error_syntax: BOOLEAN is
			-- Syntax error occurred?
		do
			Result := error & (cst_error_syntax |>> 4) > 0
		end

	has_error_expression: BOOLEAN is
			-- Error occurred during expression analysis, or context setting?
		do
			Result := error & (cst_error_expression |>> 4) > 0
		end

	has_error_evaluation: BOOLEAN is
			-- Error occurred during expession evaluation?
		do
			Result := error & (cst_error_evaluation |>> 4) > 0
		end

	has_error_exception: BOOLEAN is
			-- Exception occurred during expession evaluation?	
			--| Internal error (debugger)
		do
			Result := error & (cst_error_exception |>> 4) > 0
		end

	has_error_evaluation_aborted: BOOLEAN
			-- Has an error due to evaluation aborted?
		do
			Result := has_error_with_code (Cst_error_evaluation_aborted)
		end

feature -- Error notification: main categories

	notify_error (a_code: INTEGER; a_tag, a_msg: STRING_GENERAL) is
			-- Notify error with `a_code', `a_tag' and `a_msg'
		require
			valid_code: a_code /= 0
		local
			l_tag: STRING_32
			l_msg: STRING_32
			err: DBG_ERROR
		do
			error := error | a_code
			create err
			err.code := a_code

			if a_tag /= Void then
				err.tag := a_tag.as_string_32
			end
			if a_msg /= Void then
				err.msg := a_msg.as_string_32
			end
			error_list.extend (err)
		end

	notify_error_syntax (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_syntax, Void, mesg)
		end

	notify_error_expression (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_expression, Void, mesg)
		end

	notify_error_evaluation (mesg: STRING_GENERAL) is
		do
			if mesg = Void then
				notify_error (cst_error_evaluation, Void, Debugger_names.Cst_error_occurred)
			else
				notify_error (cst_error_evaluation, Void, mesg)
			end
		end

	notify_error_exception (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_exception, Void, mesg)
		end

feature -- Error notification: expression error

	notify_error_expression_and_tag (mesg: STRING_GENERAL; t: STRING_GENERAL) is
		do
			notify_error (cst_error_expression, t, mesg)
		end

	notify_error_list_expression_and_tag (a_error_list: LINKED_LIST [ERROR])
		local
			l_error: ERROR
			l_cursor: LINKED_LIST_CURSOR [ERROR]
		do
			if a_error_list /= Void then
				l_cursor := a_error_list.cursor
				from
					a_error_list.start
				until
					a_error_list.after
				loop
					l_error := a_error_list.item
					notify_error_expression_error (l_error)
					a_error_list.forth
				end
				a_error_list.go_to (l_cursor)
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

	notify_error_expression_during_analyse
		do
			notify_error_expression (Debugger_names.Cst_error_during_expression_analyse)
		end

	notify_error_expression_during_context_preparation
		do
			notify_error_expression (Debugger_names.Cst_error_during_context_preparation)
		end

	notify_error_expression_type_checking_failed
		do
			notify_error_expression (Debugger_names.Cst_error_type_checking_failed)
		end

feature -- Error notification: evaluation error

	notify_error_evaluation_side_effect_forbidden is
		do
			notify_error_evaluation (Debugger_names.Cst_error_evaluation_side_effect_forbidden)
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

	notify_error_evaluation_parameter (a: ANY)
		do
			notify_error_evaluation (Debugger_names.msg_error_evaluating_parameter (a))
		end

	notify_error_evaluation_unknown_constant_type_for (fn: STRING_GENERAL)
		do
			notify_error_evaluation (Debugger_names.msg_error_unknown_constant_type_for (fn))
		end

	notify_error_evaluation_VST1_on_class_context (cn, fn: STRING_GENERAL)
		do
			notify_error_evaluation (Debugger_names.msg_error_vst1_on_class_context (cn, fn))
		end

	notify_error_evaluation_aborted (m: STRING_GENERAL)
		do
			if m = Void then
				notify_error (Cst_error_evaluation_aborted, Void, Debugger_names.Cst_error_evaluation_aborted)
			else
				notify_error (Cst_error_evaluation_aborted, Void, m)
			end
		end

	notify_error_not_implemented (mesg: STRING_GENERAL) is
		do
			notify_error (cst_error_not_implemented, Void, mesg)
		end

	notify_error_not_supported (a: ANY) is
		require
			a_not_void: a /= Void
		do
			notify_error_not_implemented (Debugger_names.msg_error_not_supported (a))
		end

	notify_error_should_not_occur_in_expression_evaluation (a: ANY) is
		require
			a_not_void: a /= Void
		do
			notify_error_not_implemented (Debugger_names.msg_error_should_not_occur_during_evaluation (a))
		end

	notify_error_evaluation_creation_expression_not_implemented (tn: STRING_GENERAL)
		do
			notify_error_not_implemented (Debugger_names.msg_error_unable_to_evaluate_creation_expression (tn))
		end

	notify_error_evaluation_instanciation_of_type_failed (tn: STRING_GENERAL)
		do
			notify_error_not_implemented (Debugger_names.msg_error_instanciation_of_type_raised_error (tn))
		end

feature -- Error notification : exception error

	notify_error_exception_context_corrupted_or_not_found
		do
			notify_error_exception (Debugger_names.Cst_error_context_corrupted_or_not_found)
		end

	notify_error_exception_internal_issue
		do
			notify_error_exception (Debugger_names.cst_error_evaluation_failed_with_internal_exception)
		end

	notify_error_exception_during_evaluation (m: STRING_GENERAL)
		do
			if m = Void then
				notify_error_exception (Debugger_names.cst_error_exception_during_evaluation)
			else
				notify_error_exception (m)
			end
		end

feature -- Query

	short_text_from_errors: STRING_32 is
			-- Short text from errors
		local
			details: DBG_ERROR
		do
			if not error_list.is_empty then
				details := error_list.first
				Result := details.tag
			end
		end

	full_text_from_errors: STRING_32 is
			-- Full text from errors
		local
			details: DBG_ERROR
			l_code: INTEGER
			l_tag, l_msg: STRING_32
			s: STRING_32
		do
			create Result.make (0)
			from
				create s.make_empty
				error_list.start
			until
				error_list.after
			loop
				details := error_list.item
				l_code := details.code
				l_tag := details.tag
				l_msg := details.msg
				if l_tag /= Void then
					s.append_character ('[')
					s.append (l_tag)
					s.append_character (']')
					s.append_character (' ')
				end
				if l_msg /= Void then
					s.append (l_msg)
				end
				if s.is_empty then
					s.append (Debugger_names.Cst_error_occurred)
				end

				error_list.forth
				Result.append (s)
				s.wipe_out
				if not error_list.after then
					Result.append ("%N-----------------------------------%N")
				end
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Basic operations

	reset
			-- Reset errors
		do
			error := 0
			error_list.wipe_out
		end

feature {NONE} -- Error: category constants

	--| 4 main error categories
	--| 	- Syntax:
	--| 	- Expression: issue getting the context or the byte node
	--| 	- Evaluation: exception catched at the dbg level, or not yet implemented ...
	--| 	- Exception: unhandled exception, mainly internal issue from the debugger's code
	--|
	--| the left  4 bits are used to specify the category of the error
	--| the right 4 bits are used to identified each error whithin its category

	Cst_error_syntax: INTEGER =     		0b0001_0000
			-- Syntax error in expression's text

	Cst_error_expression: INTEGER = 		0b0010_0000
			-- Expression error (raised during analysis)

	Cst_error_evaluation: INTEGER = 		0b0100_0000
			-- Evaluation error
			--| either exception catched at the debugger's level
			--| or evaluator limitation

	Cst_error_exception: INTEGER =  		0b1000_0000
			-- Exception occurred during evaluation
			--| mainly exception in debugger's code

feature {NONE} -- Error: specified constants			

	Cst_error_not_implemented: INTEGER = 	0b0100_0001
			-- Error due to non implemented evaluation feature

	Cst_error_evaluation_aborted: INTEGER= 	0b0100_0010
			-- Evaluation aborted

feature {NONE} -- Implementation: Status report

	has_error_with_code (a_code: INTEGER): BOOLEAN
			-- Has error with code `a_code'
		do
			if error_occurred and not error_list.is_empty then
				from
					error_list.finish
				until
					error_list.before or Result
				loop
					Result := error_list.item.code = a_code
					error_list.back
				end
			end
		end

feature {NONE} -- Implementation

	error_to_string (e: ERROR): STRING_32 is
			-- Convert Error code to Error description STRING
		require
			error_not_void: e /= Void
		local
			yw: YANK_STRING_WINDOW
		do
			create yw.make
			tracer.trace (yw, e, {ERROR_TRACER}.normal)
			Result := yw.stored_output
		end

invariant
	error_list_attached: error_list /= Void

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
