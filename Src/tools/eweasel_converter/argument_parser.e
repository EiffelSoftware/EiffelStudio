class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_option_parser (False)
		end

feature -- Query

	source_option: detachable ARGUMENT_OPTION
			-- Source option
		do
			Result := option_of_name (source_switch)
		end

	destination_option: detachable ARGUMENT_OPTION
			-- Destination option
		do
			Result := option_of_name (destination_switch)
		end

feature {NONE} -- Usage

	name: STRING = "Eiffel Eweasel Converter"
			-- <Precursor>

	version: STRING = "1.0.2"
			-- <Precursor>

	copyright: STRING = "Copyright Eiffel Software 2009-2021. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (2)

			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (source_switch, "Specify the location where all eweasel test case exist.", False, False, "source dir", "Location where all eweasel test case exist.", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (destination_switch, "Specify the location where to put all generated eweasel test case classes.", False, False, "destination dir", "Location where to put all generated eweasel test case classes.", False))
		end

	source_switch: STRING = "source"
			-- Parameter name used in console

	destination_switch: STRING = "dest"
			-- Parameter name used in console

	switch_groups: attached ARRAYED_LIST [attached ARGUMENT_GROUP]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (source_switch), switch_of_name (destination_switch)>>, True))
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
