indexing
	description	: "Describes a breakpoint. A breakpoint is represented by its `body_index' %
				  %and its `breakable_line_number' (line number in stop points view). We %
				  %also keep the 'real_body_id` because the run-time handles breakpoints %
				  %through `real_body_id' and `breakable_line_number'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class BREAKPOINT

inherit

	DEBUG_OUTPUT
		redefine
			is_equal
		end

	HASHABLE
		redefine
			is_equal
		end

	E_FEATURE_COMPARER
		redefine
			is_equal
		end

	COMPILER_EXPORTER
		redefine
			is_equal
		end

create
	make

feature -- Creation

	make (given_feature: E_FEATURE; given_breakable_line_number: INTEGER) is
			-- Create a breakpoint in the feature `given_feature'
			-- at the line `given_breakable_line_number'.
		require
			valid_breakpoint: 	given_feature /= Void and then
								given_breakable_line_number > 0 and then
								given_feature.body_index /= 0
		do
			if not is_corrupted then
				breakable_line_number := given_breakable_line_number
				routine := given_feature
				application_status := Application_breakpoint_not_set
				bench_status := Bench_breakpoint_set
				body_index := routine.body_index
			end
		rescue
			is_corrupted := True
			retry
		end

feature -- debug output

	debug_output: STRING is
		local
			lcl: CLASS_C
		do
			Result := "{"
			lcl := routine.associated_class
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
			if condition /= Void then
				Result.append_string (" (*) ")
			end
		end

feature -- Properties

	breakable_line_number: INTEGER
			-- Line number of the breakpoint in the stoppoint view under $EiffelGraphicalCompiler$.

	routine: E_FEATURE
			-- Feature where this breakpoint is situated.

	body_index: INTEGER
			-- `body_index' of the feature where this breakpoint is situated

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

	condition: EB_EXPRESSION
			-- Condition to stop.

feature -- Query

	real_body_ids_list: LIST [INTEGER] is
		local
			l_class_type_list: LIST [CLASS_TYPE]
			fi: FEATURE_I
			lcurs: CURSOR
		do
			l_class_type_list := class_type_list
			if l_class_type_list /= Void then
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

	class_type_list: LIST [CLASS_TYPE] is
		do
			Result := routine.written_class.types
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code for breakpoint.
		do
			Result := body_index * 100 + breakable_line_number
				-- here we take the absolute value of the
				-- result if  an overflow occurred
			if Result < 0 then
				Result := - Result
			end
		end

	is_not_usefull: BOOLEAN is
			-- Is the structure still usefull?
			--
			-- If the bench and the application status are set to
			-- 'removed breakpoint', we don't need this structure
			-- anymore, and we can destroy it...
		do
			Result := bench_status = Bench_breakpoint_not_set and then application_status = Application_breakpoint_not_set
		ensure
			is_not_usefull: Result implies bench_status = Bench_breakpoint_not_set and application_status = Application_breakpoint_not_set
		end

	is_corrupted: BOOLEAN
			-- False unless there was a problem at initialization (no feature).

	is_valid: BOOLEAN is
			-- Is using `Current' safe?
		do
			Result := 	not is_corrupted and routine /= Void
						and then routine.written_class /= Void
						and then routine.is_debuggable
						and then same_feature (routine, routine.associated_class.feature_with_rout_id (routine.rout_id_set.first))
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

	has_condition: BOOLEAN is
			-- Is `Current' a conditional breakpoint?
		do
			Result := condition /= Void
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
							if not condition.is_condition (routine) then
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

	set_condition (expr: EB_EXPRESSION) is
			-- Set `Current's condition.
		require
			valid_expression: expr /= Void and then not expr.syntax_error_occurred and then expr.is_condition (routine)
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
		end

	reload is
			-- To be used after save and load operations, to restore the condition.
		do
			if expression /= Void then
				create condition.make_for_context (expression)
				if condition.syntax_error_occurred or else not condition.is_condition (routine) then
					condition := Void
				end
				expression := Void
			end
		end

feature {EWB_REQUEST, APPLICATION_EXECUTION_IMP} -- application status access

	is_set_for_application: BOOLEAN is
			-- Is the breakpoint set for the application?
		do
			Result := (application_status = Application_breakpoint_set)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to `Current'?
			-- `other' equals to `Current' if they represent
			-- the same physical breakpoint, in other words they
			-- have the same `body_index' and `offset'.
			-- We use 'body_index' because it does not change after
			-- a recompilation
		do
			Result := (other.breakable_line_number = breakable_line_number) and (other.body_index = body_index)
		end

feature {NONE} -- Implementation

	expression: STRING_32
			-- String representation of the condition, if any, during save and load operations.

feature -- Public constants
	Breakpoint_do_nothing: INTEGER is 0 -- default value
	Breakpoint_to_remove: INTEGER is 1
	Breakpoint_to_add: INTEGER is 2

feature {NONE} -- Private constants
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

