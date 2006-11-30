indexing
	description: "String constants for configuration files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EWEASEL_CONFIGURATION_CONSTANTS

feature -- Access

	root_tag: STRING is "configuration"
	
	control_file_tag: STRING is "init_control_file"
	
	catalog_file_tag: STRING is "catalog_file"
	
	output_location_tag: STRING is "output_location"
	
	keep_tag: STRING is "keep"
	
	keep_eifgens_tag: STRING is "keep_eifgens_tag"
	
	include_tag: STRING is "include_dir"
	
	installation_tag: STRING is "eiffel_inst_dir"

	weasel_installation_tag: STRING is "eweasel_inst_dir"
	
	platform_tag: STRING is "platform"
	
	platform_type_tag: STRING is "platform_type"
	
	compiler_version_tag: STRING is "compiler_version";

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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


