note
	description: "{
		Test extraction implementation.
	}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_EXTRACTION

inherit
	ETEST_CREATION
		redefine
			make
		end

	SHARED_DEBUGGER_MANAGER

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite; a_etest_suite: like etest_suite)
			-- <Precursor>
		do
			Precursor (a_test_suite, a_etest_suite)
			create capturer.make
			create internal_call_stack_levels.make_default
		end

feature -- Access

	call_stack_levels: DS_HASH_SET [INTEGER]
			-- Levels in call stack which will be extraced.
		do
			Result := internal_call_stack_levels.twin
		end

feature {NONE} -- Access

	internal_call_stack_levels: like call_stack_levels
			-- Internal storage for `call_stack_levels'

	capturer: TEST_CAPTURER
			-- Capturer retrieving objects from running application.

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	sleep_time: NATURAL = 0
			-- <Precursor>

	progress: REAL_32
			-- <Precursor>

feature {NONE} -- Status report

	creates_multiple_classes: BOOLEAN = False
			-- <Precursor>

feature -- Status setting

	add_call_stack_level (a_level: INTEGER)
			-- Add level to `call_stack_levels'
			--
			-- `a_level': Level of call stack frame to be extracted by `Current'.
		require
			valid_level: is_valid_call_stack_element (a_level)
		do
			internal_call_stack_levels.force_last (a_level)
		ensure
			added: call_stack_levels.has (a_level)
		end

feature -- Status setting: Task

	step
			-- <Precursor>
		do
			create_new_class
			cancel
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

feature {NONE} -- Status setting

	start_creation
			-- <Precursor>
		do
			has_next_step := True
			progress := {REAL_32} 0.5
		end

	print_new_class (a_file: KL_TEXT_OUTPUT_FILE; a_class_name: STRING)
			-- <Precursor>
		local
			l_source_writer: TEST_EXTRACTED_SOURCE_WRITER
			l_app_stat: detachable APPLICATION_STATUS
			l_cs: detachable EIFFEL_CALL_STACK
		do
			create l_source_writer.make
			capturer.observers.force_last (l_source_writer)

			l_source_writer.prepare (a_file, a_class_name)
			l_app_stat := debugger_manager.application_status
			if l_app_stat /= Void then
				l_cs := l_app_stat.current_call_stack
				if l_cs /= Void then
					from
						capturer.prepare
						l_cs.start
					until
						l_cs.after
					loop
						if
							attached {EIFFEL_CALL_STACK_ELEMENT} l_cs.item as l_cse and then
							call_stack_levels.has (l_cse.level_in_stack)
						then
							check valid: capturer.is_valid_call_stack_element (l_cse) end
							capturer.capture_call_stack_element (l_cse)
						end
						l_cs.forth
					end
					capturer.capture_objects
				end
			else
				error_event.publish ([Current, locale.translation (e_no_application_status)])
			end

			capturer.observers.start
			capturer.observers.search_forth (l_source_writer)
			check
				observer_found: not capturer.observers.off
			end
			capturer.observers.remove_at
		end

feature -- Query

	is_valid_call_stack_element (a_index: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_cs: EIFFEL_CALL_STACK
		do
			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				l_cs := debugger_manager.application_status.current_call_stack
				if l_cs /= Void and then l_cs.count >= a_index then
					if attached {EIFFEL_CALL_STACK_ELEMENT} l_cs.i_th(a_index) as l_cse then
						Result := capturer.is_valid_call_stack_element (l_cse)
					end
				end
			end
		end

feature {NONE} -- Implementation

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do

		end

feature {NONE} -- Constants

	e_no_application_status: STRING = "Could not retrieve application status"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
