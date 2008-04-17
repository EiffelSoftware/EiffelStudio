indexing
	description: "[
						Objects that identify a test case
						This class have all informations about a test case class
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_CASE_ITEM

feature -- Query

	tag: STRING_GENERAL
			-- End user defined tag

	class_id: STRING_GENERAL
			-- `class_i' id

	last_run_result: INTEGER
			-- Last test run result
			-- One value from {EWEASEL_RESULT_TYPE}

	changed_time: DT_DATE_TIME
			-- The time this test case have been modified

	last_run_time: DT_DATE_TIME
			-- Does this test case modified after last test run?

feature -- Command

	set_tag (a_tag: like tag) is
			-- Set `tag' with `a_tag'
		do
			tag := a_tag
		ensure
			set: tag = a_tag
		end

	set_last_run_result (a_result: INTEGER) is
			-- Set `last_run_result' with `a_result'
		require
			valid: (create {ES_EWEASEL_RESULT_TYPE}).is_valid (a_result)
		do
			last_run_result := a_result
		ensure
			set: last_run_result = a_result
		end

	set_changed_time (a_time: like changed_time) is
			-- Set `changed_time' with `a_time'
		do
			changed_time := a_time
		ensure
			set: changed_time = a_time
		end

	set_last_run_time (a_date: like last_run_time) is
			-- Set `last_run_time' with `a_date'
		do
			last_run_time := a_date
		ensure
			set: last_run_time = a_date
		end

	to_saving_state is
			-- Convert Current to state for saving
		require
			valid: is_valid_for_running
		local
			l_solution: EB_SHARED_ID_SOLUTION
		do
			create l_solution
			class_id := l_solution.id_of_class (class_i.config_class)

			set_class_i (Void)
		ensure
			done: is_valid_for_saving and not is_valid_for_running
		end

	to_running_state is
			-- Convert Current to state for running
		require
			valid: is_valid_for_saving
		local
			l_solution: EB_SHARED_ID_SOLUTION
		do
			create l_solution
			if {l_conf_class: CONF_CLASS} l_solution.class_of_id (class_id.as_string_8) then
				if {l_class_i: CLASS_I} l_conf_class then
					class_i:= l_class_i
					if class_i /= Void then
						class_id := Void
						check done: is_valid_for_running and not is_valid_for_saving end
					end
				else
					check not_possible: False end
				end
			else
				-- If class not found, we do nothing
			end
		end

feature -- Cache which should be void when saving

	class_i: CLASS_I
			-- Test case related root test class

	set_class_i (a_class: like class_i) is
			-- Set `class_i' with `a_class'
		do
			class_i := a_class
		ensure
			set: class_i = a_class
		end

feature -- Contract support

	is_valid_for_saving: BOOLEAN is
			-- If Current state valid for saving to session data?
		do
			Result :=	class_i = Void and -- We don't save `class_i'
						class_id /= Void
		end

	is_valid_for_running: BOOLEAN is
			-- If Current state valid for running ?
		do
			Result :=	class_i /= Void
		end

feature {NONE} -- Implementation

	internal_class_id: STRING_GENERAL;
			-- Cache of `class_id'

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
