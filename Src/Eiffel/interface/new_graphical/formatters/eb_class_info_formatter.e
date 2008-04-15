indexing
	description	: "Command to display information concerning a compiled class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_CLASS_INFO_FORMATTER

inherit
	EB_FORMATTER
		redefine
			veto_pebble_function
		end

	SHARED_FORMAT_INFO

feature -- Properties

	associated_class: CLASS_C
			-- Class about which information is displayed.

	element_name: STRING is
			-- name of associated element in current formatter.
			-- For exmaple, if a class stone is associated to current, `element_name' would be the class name.
		do
			if associated_class /= Void then
				Result := associated_class.name.twin
			end
		end

feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		deferred
		ensure
			result_is_valid_mode: (create {ES_CLASS_TOOL_VIEW_MODES}).is_valid_mode (Result)
		end

feature -- Status report

	is_dotnet_mode: BOOLEAN
			-- Is Current class a .NET class? 		

feature -- Status setting

	set_dotnet_mode (a_flag: BOOLEAN) is
			-- Set whether formatting in .NET mode to 'a_flag'
		do
			is_dotnet_mode := a_flag
		ensure
			mode_is_flag: is_dotnet_mode = a_flag
		end

feature {NONE} -- Implementation

	veto_pebble_function (a_any: ANY): BOOLEAN is
			-- Veto pebble function
		local
			l_classi_stone: CLASSI_STONE
		do
			l_classi_stone ?= a_any
			if l_classi_stone /= Void then
				Result := Precursor {EB_FORMATTER}(a_any)
			end
		end

	temp_header: STRING_GENERAL is
			-- Temporary header displayed during the format processing.
		do
			check associated_class /= Void end
			Result := interface_names.l_working_formatter (command_name, associated_class.name, True)
		end

	header: STRING_GENERAL is
			-- Header displayed when current formatter is selected.
		do
			if associated_class /= Void then
				Result := interface_names.l_Header_class (capital_command_name, associated_class.name_in_upper)
			else
				Result := Interface_names.l_Not_in_system_no_info
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_CLASS_INFO_FORMATTER

