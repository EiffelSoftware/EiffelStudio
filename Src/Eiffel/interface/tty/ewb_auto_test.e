indexing
	description: "Summary description for {EWB_AUTO_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_AUTO_TEST

inherit
	EWB_CMD

create
	default_create,
	make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_arguments: LINKED_LIST [STRING]) is
			-- Initialize `auto_test_arguments' with `a_arguments'.
		require
			a_arguments_attached: a_arguments /= Void
		do
			create {DS_LINKED_LIST [STRING]} auto_test_arguments.make
			a_arguments.do_all (agent auto_test_arguments.force_last)
		ensure
			auto_test_arguments_set: auto_test_arguments /= Void and then auto_test_arguments.count = a_arguments.count
		end

feature -- Properties

	name: STRING is
		do
			Result := "AutoTest"
		end

	help_message: STRING_GENERAL is
		do
			Result := "AutoTest"
		end

	abbreviation: CHARACTER is
		do
			Result := 'e'
		end

feature -- Execution

	execute is
			-- Action performed when invoked from the
			-- command line.
		do
			io.put_string ("AutoTest is only available in graphical version of EiffelStudio.%N%N")
		end

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
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
