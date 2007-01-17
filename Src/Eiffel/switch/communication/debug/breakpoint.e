indexing
	description	: "[
					Describes a breakpoint. A breakpoint is represented by its `body_index' 
				  	and its `breakable_line_number' (line number in stop points view). 
					The run-time handles breakpoints through `real_body_id' 
					and `breakable_line_number'.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

class BREAKPOINT

inherit

	BREAKPOINT_KEY
		redefine
			make
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

	E_FEATURE_COMPARER
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end
create
	make

feature {DEBUG_INFO, BREAK_LIST} -- Creation

	make (a_feature: E_FEATURE; a_breakable_index: INTEGER) is
			-- Create a breakpoint in the feature `a_feature'
			-- at the line `a_breakable_index'.
		do
			Precursor {BREAKPOINT_KEY} (a_feature, a_breakable_index)
			if not is_corrupted then
				application_status := Application_breakpoint_not_set
				bench_status := Bench_breakpoint_set
			end
		end

feature -- debug output

	debug_output: STRING is
		do
			Result := string_representation (True)
		end

feature -- Output

	string_representation (wih_details: BOOLEAN): STRING is
			-- String representation of current Breakpoint.
		local
			lcl: CLASS_C
		do
			Result := "{"
			if routine /= Void then
				lcl := routine.associated_class
			end
			if lcl /= Void then
				Result.append_string (lcl.name_in_upper)
			else
				Result.append_string ("???")
			end
			Result.append_string ("}.")
			if routine /= Void then
				Result.append_string (routine.name)
			else
				Result.append_string ("???")
			end
			Result.append_string (" [" + breakable_line_number.out + "] ")
			if has_condition then
				Result.append_string ("(C)")
			end
			if has_message then
				Result.append_string ("(M)")
			end
			if wih_details then
				if is_corrupted then
					Result.append_string (" <corrupted> ")
				end
				if is_set then
					if is_enabled then
						Result.append_string (" <enabled> ")
					end
					if is_disabled then
						Result.append_string (" <disabled> ")
					end
				else
					Result.append_string (" <not set> ")
				end
				if is_set_for_application then
					Result.append_string (" <set for application> ")
				end
			end
		end

feature -- Properties

	hits_count_condition: TUPLE [mode:INTEGER; value:INTEGER]
			--| mode: 0x0 always
			--| mode: 0x2 equal
			--| mode: 0x4 multiple of
			--| mode: 0x8 greater or equal

	condition: EB_EXPRESSION
			-- Condition to stop.

	condition_as_is_true: BOOLEAN is
			-- Condition is a "Is True" condition.
		do
			Result := condition_type = Condition_is_type_is_true
		end

	condition_as_has_changed: BOOLEAN is
			-- Condition is a "Has Changed" condition.
		do
			Result := condition_type = Condition_is_type_has_changed
		end

	message: STRING
			-- Message to be print when Current is reached.
			-- If Void, no message is printed.
			--| You can include value of expression in the message
			--| by placing it in curly braces , such as "value of x is {x}."
			--| to insert a curly braces, use "\{" to insert a backslash use "\\"
			--| Special keywords:
			--|   $ADDRESS
			--|   $CALLSTACK - Current call stack
			--|	  $FEATURE - Current feature name
			--|	  $THEADID - Current thread id

	continue_execution: BOOLEAN
			-- Continue execution when Current is reached ?
			-- Default: stop.

feature -- Access

	condition_respected: BOOLEAN is
			-- Is condition respected ?
		require
			condition.expression_evaluator /= Void
		local
			eval: DBG_EXPRESSION_EVALUATOR
			ncv: like last_condition_value
		do
			Result := True
			eval := condition.expression_evaluator
			if not eval.error_occurred then
				inspect condition_type
				when Condition_is_type_is_true then
					Result := eval.final_result_is_true_boolean_value
				when Condition_is_type_has_changed then
					ncv := eval.final_result_value
					Result := last_condition_value = Void or ncv = Void
						or else (not ncv.same_as (last_condition_value))
					last_condition_value:= ncv
				else
				end
			end
		end

feature {NONE} -- Internal properties

	condition_type: INTEGER
			-- Type of condition
			--| default: condition_is_true_type

feature -- Status and live properties

	bench_status: INTEGER
			-- Current status within $EiffelGraphicalCompiler$.
			--
			-- See the private constants at the end of the class to see the
			-- different possible values taken.

	application_status: INTEGER
			-- Last status sent to the application, this is the current
			-- status of this breakpoint from the application point of view
			--
			-- See the private constants at the end of the class to see the
			-- different possible values taken.

	hits_count: INTEGER
			-- Number of times Current is reached (and satisfied condition if any).

feature {NONE} -- Internal value

	last_condition_value: DUMP_VALUE
			-- Last condition's value			

feature -- Change

	set_continue_execution (b: BOOLEAN) is
			-- Set `continue_execution' to `b'
		do
			continue_execution := b
		end

	set_message (s: STRING) is
			-- Set `message' to `s'
		do
			message := s
		end

	increase_hits_count is
			-- Increase hits_count by one
		do
			hits_count := hits_count + 1
		end

	reset_hits_count is
		do
			hits_count := 0
		end

	set_hits_count_condition (m,v: INTEGER) is
			-- Set `hits_count_condition'
		do
			if m = 0 then
				hits_count_condition := Void
			else
				hits_count_condition := [m, v]
			end
		end

	set_condition_as_is_true is
			-- Set `condition_type' as `Condition_is_type_is_true'
		do
			condition_type := Condition_is_type_is_true
		end

	set_condition_as_has_changed is
			-- Set `condition_type' as `Condition_is_type_has_changed'
		do
			condition_type := Condition_is_type_has_changed
		end

	reset_session_data is
		do
			reset_hits_count
			last_condition_value := Void
		end

feature -- Status

	has_condition: BOOLEAN is
			-- Is `Current' a conditional breakpoint?
		do
			Result := condition /= Void
		end

	has_message: BOOLEAN is
			-- Is `Current' a tracepoint?
		do
			Result := message /= Void
		end

	has_hit_count_condition: BOOLEAN is
			-- Is `Current' has a condition on `hit_count' ?
		do
			Result := hits_count_condition /= Void and then hits_count_condition.mode /= hits_count_condition_always
		end

feature -- Query

	real_body_ids_list: LIST [INTEGER] is
		local
			l_class_type_list: LIST [CLASS_TYPE]
			fi: FEATURE_I
			lcurs: CURSOR
		do
			if routine /= Void and then routine.written_class /= Void then
				l_class_type_list := routine.written_class.types
				if l_class_type_list /= Void then
					check routine_not_void: routine /= Void end
					if routine.associated_class /= Void then
						fi := routine.associated_feature_i
						if fi /= Void then
							create {ARRAYED_LIST [INTEGER]} Result.make (l_class_type_list.count)
							lcurs := l_class_type_list.cursor
							from
								l_class_type_list.start
							until
								l_class_type_list.after
							loop
								Result.extend (fi.real_body_id (l_class_type_list.item))
								l_class_type_list.forth
							end
							if l_class_type_list.valid_cursor (lcurs) then
								l_class_type_list.go_to (lcurs)
							end
						end
					end
				end
			end
		end

feature -- Access

	is_not_useful: BOOLEAN is
			-- Is the structure still useful?
			--
			-- If the bench and the application status are set to
			-- 'removed breakpoint', we don't need this structure
			-- anymore, and we can destroy it...
		do
			Result := bench_status = Bench_breakpoint_not_set and then application_status = Application_breakpoint_not_set
		ensure
			is_not_usefull: Result implies bench_status = Bench_breakpoint_not_set and application_status = Application_breakpoint_not_set
		end

	is_valid: BOOLEAN is
				-- Is using `Current' safe?
		local
			l_feat_i: FEATURE_I
			l_feat: E_FEATURE
		do
			Result := not is_corrupted and routine /= Void
				and then routine.associated_class /= Void
				and then routine.is_debuggable
				and then same_feature (routine, routine.associated_class.feature_with_rout_id (routine.rout_id_set.first))
			if Result then
				if routine.is_inline_agent then
					l_feat_i := routine.associated_class.eiffel_class_c.inline_agent_of_rout_id (routine.rout_id_set.first)
					if l_feat_i /= Void then
						l_feat := l_feat_i.api_feature (routine.written_in)
					end
				else
					l_feat := routine.associated_class.feature_with_rout_id (routine.rout_id_set.first)
				end
				Result := same_feature (routine, l_feat)
			end
		end

	is_set: BOOLEAN is
			-- Is the breakpoint set (enabled or disabled)?
		do
			Result := (bench_status = Bench_breakpoint_set) or (bench_status = Bench_breakpoint_disabled)
		end

	is_disabled: BOOLEAN is
			-- Is the breakpoint set but disabled?
		do
			Result := (bench_status = Bench_breakpoint_disabled)
		end

	is_enabled: BOOLEAN is
			-- Is the breakpoint set and enabled?
		do
			Result := (bench_status = Bench_breakpoint_set)
		end

	trace is
			-- Display the status of this breakpoint.
			-- Note: Should only be called in Debug mode.
		do
			io.put_string ("BREAKPOINT: trace%N")

			io.put_string ("%T")
			if routine /= Void then
				io.put_string (routine.name)
			else
				io.put_string ("unknown_routine(routine=Void)")
			end
			io.put_string (" @")
			io.put_integer (breakable_line_number)
			io.put_new_line

			io.put_string ("%Tbench status: ")
			inspect bench_status
			when Bench_breakpoint_set then
				io.put_string ("set & enabled%N")
			when Bench_breakpoint_disabled then
				io.put_string ("set & disabled%N")
			when Bench_breakpoint_not_set then
				io.put_string ("not set%N")
			end

			io.put_string ("%Tapplication status: ")
			inspect application_status
			when Application_breakpoint_set then
				io.put_string ("set%N")
			when Application_breakpoint_not_set then
				io.put_string ("not set%N")
			end
		end

feature -- application status access

	is_set_for_application: BOOLEAN is
			-- Is the breakpoint set for the application?
		do
			Result := (application_status = Application_breakpoint_set)
		end

feature -- Setting

	discard is
			-- Set the breakpoint to be removed.
		do
			bench_status := Bench_breakpoint_not_set
			condition := Void
		ensure
			breakpoint_is_removed: bench_status = Bench_breakpoint_not_set
		end

	enable is
			-- Set and enable the breakpoint.
		do
			bench_status := Bench_breakpoint_set
		ensure
			breakpoint_is_enabled: bench_status = Bench_breakpoint_set
		end

	switch is
			-- Set the breakpoint if it was not set, and
			-- discard it if it was set.
			-- If the breakpoint is disabled, enable it.
		do
			if bench_status = Bench_breakpoint_set then
				bench_status := Bench_breakpoint_not_set
				condition := Void
			else
				bench_status := Bench_breakpoint_set
			end
		end

	disable is
			-- Disable the breakpoint.
		do
			bench_status := Bench_breakpoint_disabled
		ensure
			breakpoint_is_disabled: bench_status = Bench_breakpoint_disabled
		end

	set_application_set is
			-- Tell that this breakpoint has been added in the application.
		do
			application_status := Application_breakpoint_set
		ensure
			breakpoint_is_set_for_application: application_status = Application_breakpoint_set
		end

	set_application_not_set is
			-- Tell that this breakpoint has been removed in the application.
		do
			application_status := Application_breakpoint_not_set
		ensure
			breakpoint_is_not_set_for_application: application_status = Application_breakpoint_not_set
		end

	update_status: INTEGER is
			-- Update the status between Bench and the application.
			--
			-- See the public constants below to see the
			-- different possible value taken.
		do
			Result := Breakpoint_do_nothing

			if (bench_status /= application_status) then
				inspect bench_status
					when Bench_breakpoint_set then
						-- bench breakpoint is set, application breakpoint is not set
						Result := Breakpoint_to_add

					when Bench_breakpoint_not_set then
						-- bench breakpoint is not set, application breakpoint is set
						Result := Breakpoint_to_remove

					when Bench_breakpoint_disabled then
						if application_status = Application_breakpoint_set then
							-- bench breakpoint is disabled but application breakpoint is set
							-- so remove it
							Result := Breakpoint_to_remove
						end
				end
			end
		end

	synchronize is
			-- Resychronize the breakpoint after a recompilation.
		local
			invalid_breakpoint: BOOLEAN
		do
			if not invalid_breakpoint then
					-- update the feature
				check routine_not_void: routine /= Void end
				routine := routine.updated_version
				if routine /= Void and then routine.is_debuggable and then routine.written_class /= Void then
					if not (breakable_line_number > routine.number_of_breakpoint_slots) then
							-- The line of the breakpoint still exists.
							-- Update `real_body_id' since it may have changed
							-- during recompilation (`body_index' is not supposed to change but
							-- we update it as well in case of)
						body_index := routine.body_index -- update the body_index as well
						if condition /= Void then
							condition.recycle
							if condition_as_is_true and not condition.is_boolean_expression (routine) then
								condition := Void
							end
						end
					else
							-- set the breakpoint to be removed: the line does no longer exist
						discard
						is_corrupted := True
					end
				else
						-- The breakpoint is now invalid since its feature has been removed
						-- or is no longer debuggable.
					discard
					is_corrupted := True
				end
			else
					-- This is an invalid breakpoint. Discard it.
				discard
				is_corrupted := True
			end
		ensure
			is_set implies routine /= Void
		rescue
				-- The synchronization of the breakpoint has failed.
				-- We declare the breakpoint as "invalid".
			invalid_breakpoint := True
			retry
		end

feature -- Condition change

	set_condition (expr: EB_EXPRESSION) is
			-- Set `Current's condition.
		require
			valid_expression: expr /= Void and then not expr.syntax_error_occurred
				and then (condition_as_is_true implies expr.is_boolean_expression (routine))
		do
			condition := expr
		end

	remove_condition is
			-- Remove any condition on `Current'.
		do
			condition := Void
		end

feature {DEBUG_INFO} -- Saving protocol.

	prepare_for_save is
			-- To be used before storing breakpoints: we store the condition as the string only.
		do
			if condition /= Void then
				expression := condition.expression
				condition := Void
			else
				expression := Void
			end
			last_condition_value := Void
		end

	reload is
			-- To be used after save and load operations, to restore the condition.
		do
			if expression /= Void then
				create condition.make_for_context (expression)
				if
					condition.syntax_error_occurred
					or else (condition_as_is_true and not condition.is_boolean_expression (routine) )
				then
					condition := Void
				end
				expression := Void
			end
		end

feature {NONE} -- Implementation

	expression: STRING_32
			-- String representation of the condition, if any, during save and load operations.

feature -- Public constants
	Breakpoint_do_nothing: INTEGER is 0 --| Default
	Breakpoint_to_remove: INTEGER is 1
	Breakpoint_to_add: INTEGER is 2

	Hits_count_condition_always: INTEGER is 0 --| Default
	Hits_count_condition_equal: INTEGER is 1
	Hits_count_condition_multiple: INTEGER is 2
	Hits_count_condition_greater: INTEGER is 3

feature {NONE} -- Private constants

	Condition_is_type_is_true: INTEGER is 0 --| Default
	Condition_is_type_has_changed: INTEGER is 1

	Bench_breakpoint_set, Application_breakpoint_set 			: INTEGER is 0
	Bench_breakpoint_not_set, Application_breakpoint_not_set	: INTEGER is 1
	Bench_breakpoint_disabled									: INTEGER is 2;

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

end -- class BREAKPOINT

