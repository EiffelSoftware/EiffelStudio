note
	description: "Summary description for {ARUGMENT_PARSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
		end

feature -- Query

	source_option: ?ARGUMENT_OPTION
			-- Source option
		do
			Result := option_of_name (source_switch)
		end

	destination_option: ?ARGUMENT_OPTION
			-- Destination option
		do
			Result := option_of_name (destination_switch)
		end

feature {NONE} -- Usage

	name: STRING = "Eiffel Eweasel Converter"
			-- <Precursor>

	version: STRING = "1.0"
			-- <Precursor>

	non_switched_argument_name: STRING = "cfg_file"
			-- <Precursor>

	non_switched_argument_description: STRING = "Configuration file, representing a pixmap matrix, to generate an Eiffel class for."
			-- <Precursor>

	non_switched_argument_type: STRING = "Configuration File"
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

	switch_groups: !ARRAYED_LIST [!ARGUMENT_GROUP]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (source_switch), switch_of_name (destination_switch)>>, True))
		end

note
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
