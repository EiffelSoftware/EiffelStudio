indexing
	description: "Argument parser for pixmap matix code generator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_LITE_PARSER
		rename
			make as make_base
		redefine
			post_process_arguments
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize argument parser
		do
			make_base (False, True, False, False)
		end

feature -- Access

	ini_file_option: ARGUMENT_OPTION is
			-- Frame template file name option
		require
			--parsed: parsed
			successful: successful
		do
			Result := option_of_name (ini_switch)
		end

	frame_file_option: ARGUMENT_OPTION is
			-- Frame template file path option
		require
			--parsed: parsed
			successful: successful
		do
			Result := option_of_name (frame_switch)
		end

	class_name_option: ARGUMENT_OPTION is
			-- Class name option
		require
			--parsed: parsed
			successful: successful
		do
			Result := option_of_name (class_switch)
		end

	output_file_name_option: ARGUMENT_OPTION is
			-- Generated output file name option
		require
			--parsed: parsed
			successful: successful
		do
			Result := option_of_name (output_switch)
		end

feature {NONE} -- Parsing

	post_process_arguments is
			--
		local
			l_opt: ARGUMENT_OPTION
		do
			Precursor
			l_opt := option_of_name (frame_switch)
			if l_opt /= Void then

			end
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
			Result := "1.0"
		end

	switches: LIST [ARGUMENT_SWITCH] is
			-- Retrieve a list of available switch
		local
			l_result: ARRAYED_LIST [ARGUMENT_SWITCH]
		do
			create l_result.make (3)
			l_result.extend (create {ARGUMENT_FILE_SWITCH}.make (ini_switch, "Input INI file", False, "inifile", "INI file path containing pixmap descriptions.", False, False))
			l_result.extend (create {ARGUMENT_FILE_SWITCH}.make (frame_switch, "Optional output file name", True, "file", "Frame template file path.", False, False))
			l_result.extend (create {ARGUMENT_VALUE_SWITCH}.make (class_switch, "Optional class name for use in generated%Nfile", True, "name", "An Eiffel class name.", False, False))
			l_result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Optional output file name", True, "filename", "File name to give output file.", False, False))
			Result := l_result
		end

feature {NONE} -- Option Names

	ini_switch: STRING is "ini"
		-- INI source file switch

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
