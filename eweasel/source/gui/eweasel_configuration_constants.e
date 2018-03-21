note
	description: "String constants for configuration files."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EWEASEL_CONFIGURATION_CONSTANTS

feature -- Access

	root_tag: STRING_32 = "configuration"

	control_file_tag: STRING_32 = "init_control_file"

	catalog_file_tag: STRING_32 = "catalog_file"

	output_location_tag: STRING_32 = "output_location"

	keep_tag: STRING_32 = "keep"

	keep_eifgens_tag: STRING_32 = "keep_eifgens_tag"

	include_tag: STRING_32 = "include_dir"

	installation_tag: STRING_32 = "eiffel_inst_dir"

	weasel_installation_tag: STRING_32 = "eweasel_inst_dir"

	platform_tag: STRING_32 = "platform"

	platform_type_tag: STRING_32 = "platform_type"

	compiler_version_tag: STRING_32 = "compiler_version"

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class EWEASEL_CONFIGURATION_CONSTANTS


