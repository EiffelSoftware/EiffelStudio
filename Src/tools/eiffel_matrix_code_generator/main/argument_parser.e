note
	description: "Argument parser for pixmap matix code generator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_single_parser
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_single_parser (False, True)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
		end

feature -- Access

	ini_file_option: detachable READABLE_STRING_32
			-- Frame template file name option
		require
			is_successful: is_successful
		do
			if has_non_switched_argument then
				Result := value
			end
		end

	frame_file_option: detachable ARGUMENT_OPTION
			-- Frame template file path option
		require
			is_successful: is_successful
			not_use_slice_mode: not use_slice_mode
		do
			if has_option (frame_switch) then
				Result := option_of_name (frame_switch)
			end
		end

	class_name_option: detachable ARGUMENT_OPTION
			-- Class name option
		require
			is_successful: is_successful
			not_use_slice_mode: not use_slice_mode
		do
			if has_option (class_switch) then
				Result := option_of_name (class_switch)
			end
		end

	output_file_name_option: detachable ARGUMENT_OPTION
			-- Generated output file name option
		require
			is_successful: is_successful
			not_use_slice_mode: not use_slice_mode
		do
			if has_option (output_switch) then
				Result := option_of_name (output_switch)
			end
		end

	slice_matrix: READABLE_STRING_32
			-- Location of PNG matix that needs to be sliced
		require
			is_successful: is_successful
			use_slice_mode: use_slice_mode
		do
			check
				attached option_of_name (slice_switch) as o
			then
				Result := o.value
			end
		ensure
			slice_matrix_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	png_slices_locations: PATH
			-- Location of where to store PNG slices.
		require
			is_successful: is_successful
			use_slice_mode: use_slice_mode
		do
			if has_parsed and then attached option_of_name (pngs_switch) as o then
				create Result.make_from_string (o.value)
			else
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_path
			end
		ensure
			png_slices_locations_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	use_slice_mode: BOOLEAN
			-- Indicates if tool should be used in slicing mode (slices a matrix into icons)
		require
			is_successful: is_successful
		do
			Result := has_option (slice_switch)
		end

feature {NONE} -- Usage

	name: STRING = "EiffelVision2 Pixmap Matrix Code Generator"
			-- <Precursor>

	version: STRING = "1.5.0"
			-- <Precursor>

	copyright: STRING = "Copyright Eiffel Software 1996-2024. All Rights Reserved."
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
			create Result.make (3)
			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (frame_switch, "Specification of a frame template file", True, False, "file", "Frame template file path.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (class_switch, "A class name for use in generated file", True, False, "name", "An Eiffel class name.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "An output file name", True, False, "file", "File name to give output file.", False))

			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (slice_switch, "Indicates to perform a slicing operation on a matrix PNG file.", False, False, "file", "File name to an associated matrix PNG file.", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (pngs_switch, "Specified the location to save sliced PNGs into.", True, False, "dir", "Location to store PNG slices into.", False))
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- <Precursor>
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (frame_switch), switch_of_name (class_switch), switch_of_name (output_switch)>>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (slice_switch), switch_of_name (pngs_switch)>>, True))
		end

feature {NONE} -- Option Names

	frame_switch: STRING = "f|frame"
		-- Frame file switch

	class_switch: STRING = "n|class_name"
		-- Alt class name switch

	output_switch: STRING = "o|output_file"
		-- Alt output file name switch

	slice_switch: STRING = "s|slice"
		-- Location of a PNG matix

	pngs_switch: STRING = "g|pngs"
		-- Location where sliced pngs will be stored

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
