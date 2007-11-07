indexing
	description: "Objects that manage breakpoints"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BREAKPOINTS_MANAGER

feature -- Properties

	debugger_data: DEBUGGER_DATA is
		deferred
		end

	notify_newbreakpoint is
		deferred
		end

feature -- Breakpoints status

	error_in_bkpts: BOOLEAN is
			-- Has an error occurred in the last modification/examination of breakpoints?
		do
			Result := debugger_data.error_in_bkpts
		end

	has_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints (enabled or disabled) ?
		do
			Result := debugger_data.has_breakpoints
		end

	has_enabled_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints enabled ?
		do
			Result := debugger_data.has_enabled_breakpoints
		end

	has_disabled_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints disabled ?
		do
			Result := debugger_data.has_disabled_breakpoints
		end

	has_conditional_stop (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Does breakpoint located at (`f', `i') have a condition ?
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			Result := condition (f, i) /= Void
		end

feature -- Breakpoints update

	resynchronize_breakpoints is
			-- Resychronize the breakpoints (for instance after a compilation).
		do
			debugger_data.resynchronize_breakpoints
		end

	update_debugger_data is
		do
			debugger_data.update
		end

feature -- Breakpoints access

	condition (f: E_FEATURE; i: INTEGER): DBG_EXPRESSION is
			-- Breakpoint's condition located at (`f',`i').
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			Result := debugger_data.condition (f, i)
		end

	breakpoints: BREAK_LIST is
			-- list of all breakpoints set, disabled and recently switched.	
		do
			Result := debugger_data.breakpoints
		end

	breakpoint (f: E_FEATURE; i: INTEGER): BREAKPOINT is
			-- Breakpoint located at (`f',`i').
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			Result := debugger_data.breakpoint (f, i)
		end

	is_breakpoint_set (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set (enabled or disabled) ?
		do
			Result := debugger_data.is_breakpoint_set(f, i)
		end

	is_breakpoint_enabled (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' enabled?
		do
			Result := debugger_data.is_breakpoint_enabled(f, i)
		end

	breakpoint_status (f: E_FEATURE; i: INTEGER): INTEGER is
			-- Returns value from DEBUGGER_DATA class:
			--	`breakpoint_not_set' if breakpoint is not set,
			--  `breakpoint_set' if breakpoint is set,
			--	`breakpoint_condition_set' if breakpoint is enabled and has a condition,
			--  `breakpoint_disabled' if breakpoint is set but disabled,
			--	`breakpoint_condition_disabled' if breakpoint is disabled and has a condition
		do
			Result := debugger_data.breakpoint_status (f, i)
		end

	has_breakpoint_set (f: E_FEATURE): BOOLEAN is
			-- Has `f' a breakpoint set to stop?
		require
			non_void_f: f /= Void
		do
			Result := debugger_data.has_breakpoint_set(f)
		end

	breakpoints_set_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set for feature `f'
		do
			Result := debugger_data.breakpoints_set_for(f)
		ensure
			non_void_result: Result /= Void
		end

	breakpoints_enabled_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set & enabled for feature `f'
		do
			Result := debugger_data.breakpoints_enabled_for(f)
		ensure
			non_void_result: Result /= Void
		end

	breakpoints_disabled_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set & disabled for feature `f'
		do
			Result := debugger_data.breakpoints_disabled_for(f)
		ensure
			non_void_result: Result /= Void
		end

	features_with_breakpoint_set: LIST[E_FEATURE] is
			-- returns the list of all features that contains at
			-- least one breakpoint set (enabled or disabled)
		do
			Result := debugger_data.features_with_breakpoint_set
		ensure
			non_void_result: Result /= Void
		end

feature -- Breakpoints change

	remove_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- remove the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', do nothing
		require
			positive_i: i > 0
		do
			debugger_data.remove_breakpoint (f, i)
			notify_newbreakpoint
		end

	enable_breakpoint, set_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		require
			positive_i: i > 0
		do
			debugger_data.enable_breakpoint (f, i)
			notify_newbreakpoint
		end

	disable_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- disable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a disabled breakpoint is created
		require
			positive_i: i > 0
		do
			debugger_data.disable_breakpoint (f, i)
				notify_newbreakpoint
		end

	set_breakpoint_status (f: E_FEATURE; i: INTEGER; bp_status: INTEGER) is
			-- Set  status of  `i'-th breakpoint of `f', on bench side.
			-- DO NOT NOTIFY application of change if application
			-- is running.
			--
			-- Possible value of `bp_status' are taken from DEBUGGER_DATA class:
			-- bp_status =  Breakpoint_not_set <=> the breakpoint is not set,
			-- bp_status =  Breakpoint_set, Breakpoint_condition_set <=> the breakpoint is set,
			-- bp_status =  Breakpoint_disabled, Breakpoint_condition_disabled <=> the breakpoint is disabled
		do
			inspect bp_status
			when
				{DEBUGGER_DATA}.breakpoint_not_set
			then
				debugger_data.remove_breakpoint (f, i)

			when
				{DEBUGGER_DATA}.Breakpoint_set,
				{DEBUGGER_DATA}.Breakpoint_condition_set
			then
				debugger_data.enable_breakpoint (f, i)

			when
				{DEBUGGER_DATA}.Breakpoint_disabled,
				{DEBUGGER_DATA}.Breakpoint_condition_disabled
			then
				debugger_data.disable_breakpoint (f, i)
			end
		end

	set_condition (f: E_FEATURE; i: INTEGER; expr: DBG_EXPRESSION) is
			-- Make the breakpoint located at (`f',`i') conditional with condition `expr'.
			-- Create an enabled breakpoint if is doesn't already exist.
		require
			valid_f: f /= Void and then f.is_debuggable
			valid_i: i > 0 and i <= f.number_of_breakpoint_slots
			valid_expr: expr /= Void and then not expr.syntax_error_occurred
			good_semantics: expr.is_boolean_expression (f)
		do
			debugger_data.set_condition (f, i, expr)
		end

	remove_condition (f: E_FEATURE; i: INTEGER) is
			-- Make the breakpoint located at (`f',`i') unconditional.
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			debugger_data.remove_condition (f, i)
		end

	remove_breakpoints_in_feature (f: E_FEATURE) is
		require
			non_void_f: f /= Void
		do
			debugger_data.remove_breakpoints_in_feature(f)
			notify_newbreakpoint
		end

	disable_breakpoints_in_feature (f: E_FEATURE) is
		require
			non_void_f: f /= Void
		do
			debugger_data.disable_breakpoints_in_feature (f)
			notify_newbreakpoint
		end

	enable_breakpoints_in_feature (f: E_FEATURE) is
		require
			non_void_f: f /= Void
		do
			if f.is_debuggable then
				debugger_data.enable_breakpoints_in_feature (f)
				notify_newbreakpoint
			end
		end

	enable_first_breakpoint_of_feature (f: E_FEATURE) is
		require
			non_void_f: f /= Void
			debuggable: f.is_debuggable
		do
			debugger_data.enable_first_breakpoint_of_feature (f)
			notify_newbreakpoint
		end

	enable_first_breakpoints_in_class (c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debugger_data.enable_first_breakpoints_in_class (c)
			notify_newbreakpoint
		end

	remove_breakpoints_in_class (c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debugger_data.remove_breakpoints_in_class(c)
			notify_newbreakpoint
		end

	disable_breakpoints_in_class(c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debugger_data.disable_breakpoints_in_class(c)
			notify_newbreakpoint
		end

	enable_breakpoints_in_class(c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debugger_data.enable_breakpoints_in_class(c)
			notify_newbreakpoint
		end

	disable_all_breakpoints is
			-- disable all enabled breakpoints
		do
			debugger_data.disable_all_breakpoints
			notify_newbreakpoint
		end

	enable_all_breakpoints is
			-- enable all enabled breakpoints
		do
			debugger_data.enable_all_breakpoints
			notify_newbreakpoint
		end

	clear_breakpoints is
			-- Clear the debugging information.
			-- Save the information if we want to restore it
			-- after the compilation (do not save the information
			-- if there are compilation errors).
		do
				-- Need to individually remove the breakpoints
				-- since the sent_bp must be updated to
				-- not stop.
			debugger_data.remove_all_breakpoints
			notify_newbreakpoint
		end

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
