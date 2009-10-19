note
	description: "[
		Task which generates statistics after performing random/replay testing.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_GENERATION_STATISTICS

inherit
	ROTA_SERIAL_TASK_I

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_generation: like generation)
			-- Initialize `Current'.
			--
			-- `a_generation': Creation session which launches `Current'.
		require
			a_generation_attached: a_generation /= Void
		do
			generation := a_generation
		end

feature -- Access

	generation: TEST_GENERATOR
			-- Creation session which launches `Current'

feature {NONE} -- Access

	sub_task: detachable AUT_HTML_STATISTICS_GENERATOR

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Status setting

	start (a_result_repository: AUT_TEST_CASE_RESULT_REPOSITORY; a_class_name_list: DS_ARRAYED_LIST [CLASS_C])
			-- Launch statistics generation.
			--
			-- `a_result_repository': Result repository from last testing.
			-- `a_class_name_list': List of class names which were targeted during last testing.
		require
			a_result_repository_attached: a_result_repository /= Void
			a_class_name_list_attached: a_class_name_list /= Void
		local
			l_generation: like generation
		do
			l_generation := generation
			if l_generation.is_text_statistics_format_enabled then
				generate_text_statistics (a_result_repository, a_class_name_list)
			end
			if l_generation.is_html_statistics_format_enabled then
				generate_html_statistics (a_result_repository, a_class_name_list)
			end
		end

feature {NONE} -- Basic operations

	generate_text_statistics (a_result_repository: AUT_TEST_CASE_RESULT_REPOSITORY; a_class_name_list: DS_ARRAYED_LIST [CLASS_C])
		require
			result_repository_not_void: a_result_repository /= Void
		local
			l_generator: AUT_TEXT_STATISTICS_GENERATOR
		do
			create l_generator.make ("", file_system.pathname (generation.output_dirname, "result"), generation.system, a_class_name_list)
			l_generator.generate (a_result_repository)
			if l_generator.has_fatal_error then
				generation.error_handler.report_text_generation_error
			else
				generation.error_handler.report_text_generation_finished (l_generator.absolute_index_filename)
			end
		end

	generate_html_statistics (a_result_repo: AUT_TEST_CASE_RESULT_REPOSITORY; a_class_name_list: DS_ARRAYED_LIST [CLASS_C])
			-- Generate statistics about executed tests.
		require
			result_repository_not_void: a_result_repo /= Void
		local
			l_generator: AUT_HTML_STATISTICS_GENERATOR
		do
			create l_generator.make (file_system.pathname (generation.output_dirname, "result"), generation.system, a_class_name_list)
			l_generator.set_repository (a_result_repo)
			l_generator.start
			sub_task := l_generator
		end

invariant

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
