indexing
	description : "eweasel_converter application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			create argument_parser.make
			argument_parser.execute (agent start (argument_parser))
		end

feature {NONE} -- Implementation

	start (a_parser: ARGUMENT_PARSER)
			-- Execution agent for {ARGUMENT_PARSER}
		require
			not_void: a_parser /= Void
		local
			l_src_option, l_dest_option: ?ARGUMENT_OPTION
			l_eweasel: EW_EQA_WINDOWS_SETUP
			l_src, l_dest: DIRECTORY
			l_src_name, l_dest_name: DIRECTORY_NAME
		do
			if a_parser.is_successful then
				l_src_option := a_parser.source_option
				if l_src_option /= Void and then l_src_option.has_value then
					l_dest_option := a_parser.destination_option
					if l_dest_option /= Void and then l_dest_option.has_value then
						create l_src.make (l_src_option.value)
						if l_src.exists then
							create l_dest.make (l_dest_option.value)
							if l_dest.exists then
								create l_src_name.make_from_string (l_src_option.value)
								create l_dest_name.make_from_string (l_dest_option.value)
								convert_test_cases_in (l_src_name, l_dest_name)
							else
								print ("%NError: destination directory not exists")
							end
						else
							print ("%NError: test case source directory not exists")
						end
					end
				end
			end
		end

	argument_parser: ARGUMENT_PARSER
			-- Argument parser

	convert_test_cases_in (a_top_source_dir: DIRECTORY_NAME; a_dest_test_case_dir: DIRECTORY_NAME)
			-- Convert all test cases in `a_top_source_dir'
		require
			a_top_source_dir_not_void: a_top_source_dir /= Void
			a_dest_test_case_dir_not_void: a_dest_test_case_dir /= Void
		local
			l_setup: EW_EQA_WINDOWS_SETUP
		do
			create l_setup.make
			l_setup.setup
			l_setup.convert_all_tcf_in (a_top_source_dir, a_dest_test_case_dir, "test")
		end

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
