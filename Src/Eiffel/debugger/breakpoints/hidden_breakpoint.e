indexing
	description	: "[
					Describes a hidden breakpoint.
				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HIDDEN_BREAKPOINT

inherit
	BREAKPOINT

create {BREAKPOINTS_MANAGER}
	make_hidden

create {HIDDEN_BREAKPOINT}
	make_copy_for_saving

feature -- Run to cursor mode

	enable_run_to_cursor_mode is
			-- backup Current's data to process Run To This Point action
			-- This should be done only on hidden breakpoint
			-- since we do not this trick otherwise
		require
			backup_data = Void
			is_hidden_breakpoint: is_hidden
		do
			backup_data := [
							bench_status,
							condition_type, condition,
							continue_on_condition_failure,
							continue_execution,
							hits_count, hits_count_condition,
							when_hits_actions
							]

			bench_status := 0
			condition_type := 0
			condition := Void
			continue_on_condition_failure := False
			continue_execution := False
			hits_count := 0
			hits_count_condition := Void
			when_hits_actions := Void
		ensure
			backup_data /= Void
		end

	disable_run_to_cursor_mode is
			-- Restore Current's data after Run To This Point action is proceed
		require
			backup_data_not_void: backup_data /= Void
			is_hidden_breakpoint: is_hidden
		do
			if backup_data /= Void then
				bench_status := backup_data.bench_status
				condition_type := backup_data.condition_type
				condition := backup_data.condition
				continue_on_condition_failure := backup_data.continue_on_condition_failure
				continue_execution := backup_data.continue_execution
				hits_count := backup_data.hits_count
				hits_count_condition := backup_data.hits_count_condition
				when_hits_actions := backup_data.when_hits_actions
				backup_data := Void
			end
		ensure
			backup_data = Void
		end

	backup_data: TUPLE [
						bench_status: INTEGER;
						condition_type: INTEGER; condition: DBG_EXPRESSION;
						continue_on_condition_failure: BOOLEAN;
						continue_execution: BOOLEAN;
						hits_count: INTEGER; hits_count_condition: like hits_count_condition;
						when_hits_actions: like when_hits_actions
						]
			-- Backup data involved in "Run To This Point" action


invariant
	is_hidden: is_hidden

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
