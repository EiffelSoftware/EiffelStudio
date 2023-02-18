note
	description: "Test extraction implementation."
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

	make (a_test_suite: like test_suite; a_etest_suite: like etest_suite; a_is_gui: BOOLEAN)
			-- <Precursor>
		do
			Precursor (a_test_suite, a_etest_suite, a_is_gui)
			create capturer.make
			create internal_call_stack_levels.make (10)
		end

feature -- Access

	call_stack_levels: SEARCH_TABLE [INTEGER]
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
			internal_call_stack_levels.force (a_level)
		ensure
			added: call_stack_levels.has (a_level)
		end

feature -- Status setting: Task

	step
			-- <Precursor>
		do
			create_new_class
			proceeded_event.publish ([Current])
			cancel
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
			clean_record
		end

feature {NONE} -- Status setting

	start_creation
			-- <Precursor>
		do
			has_next_step := True
			progress := {REAL_32} 0.5
		end

	print_new_class (a_file: KL_TEXT_OUTPUT_FILE_32; a_class_name: READABLE_STRING_32)
			-- <Precursor>
		local
			l_source_writer: TEST_EXTRACTED_SOURCE_WRITER
			l_app_stat: detachable APPLICATION_STATUS
			l_cs: detachable EIFFEL_CALL_STACK
			l_routines: detachable TAG_HASH_TABLE [NATURAL]
			i: NATURAL
			l_name: STRING_32
		do
			create l_source_writer.make
			capturer.observers.force (l_source_writer)

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
					l_routines := l_source_writer.used_routine_names.twin
					capturer.capture_objects
				end
			else
				error_event.publish ([Current, locale.translation (e_no_application_status)])
			end

			capturer.observers.start
			capturer.observers.search (l_source_writer)
			check
				observer_found: not capturer.observers.off
			end
			capturer.observers.remove

			if l_routines /= Void then
				across
					l_routines as r
				loop
					create l_name.make (30)
					l_name.append (a_class_name)
					l_name.append_string_general (".test_")
					l_name.append (@ r.key)
					from
						i := 1
					until
						i > r
					loop
						publish_test_creation (if i > 1 then l_name + "_" + i.out else l_name end)
						i := i + 1
					end
				end
			end
		end

feature -- Query

	is_valid_call_stack_element (a_index: INTEGER): BOOLEAN
			-- <Precursor>
		do
			if
				debugger_manager.application_is_executing and then
				debugger_manager.application_is_stopped and then
				attached debugger_manager.application_status.current_call_stack as l_cs and then
				l_cs.count >= a_index and then
				attached {EIFFEL_CALL_STACK_ELEMENT} l_cs.i_th(a_index) as l_cse
			then
				Result := capturer.is_valid_call_stack_element (l_cse)
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
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
