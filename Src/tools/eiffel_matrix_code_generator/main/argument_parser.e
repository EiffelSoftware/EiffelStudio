indexing
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
			make as make_parser
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize argument parser
		do
			make_parser (False, False, False)
			set_loose_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
			set_use_separated_switch_values (True)
			set_show_switch_arguments_inline (True)
		end

feature -- Access

	ini_file_option: STRING is
			-- Frame template file name option
		require
			successful: successful
		do
			if values /= Void and then not values.is_empty then
				Result := values.first
			end
		end

	frame_file_option: ARGUMENT_OPTION is
			-- Frame template file path option
		require
			successful: successful
		do
			Result := option_of_name (frame_switch)
		end

	class_name_option: ARGUMENT_OPTION is
			-- Class name option
		require
			successful: successful
		do
			Result := option_of_name (class_switch)
		end

	output_file_name_option: ARGUMENT_OPTION is
			-- Generated output file name option
		require
			successful: successful
		do
			Result := option_of_name (output_switch)
		end

feature {NONE} -- Usage

	name: STRING is
			-- Full name of application
		once
			Result := "EiffelVision2 Pixmap Matrix Code Generator"
		end

	version: STRING is
			-- Version number of application
		once
			Result := "1.2.2"
		end

	loose_argument_name: STRING_8 is
			-- Name of lose argument, used in usage information
		do
			Result := "cfg_file"
		end

	loose_argument_description: STRING_8 is
			-- Description of lose argument, used in usage information
		do
			Result := "Configuration file, representing a pixmap matrix, to generate an Eiffel class for."
		end

	loose_argument_type: STRING_8 is
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"
		do
			Result := "Configuration File"
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH] is
			-- Retrieve a list of available switch
		once
			create Result.make (3)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (frame_switch, "Optional specification of a frame template file", True, False, "file", "Frame template file path.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (class_switch, "Optional class name for use in generated file", True, False, "name", "An Eiffel class name.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Optional output file name", True, False, "filename", "File name to give output file.", False))
		end

feature {NONE} -- Option Names

	frame_switch: STRING is "frame"
		-- Frame file switch

	class_switch: STRING is "class"
		-- Alt class name switch

	output_switch: STRING is "output";
		-- Alt output file name switch

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {ARGUMENT_PARSER}
