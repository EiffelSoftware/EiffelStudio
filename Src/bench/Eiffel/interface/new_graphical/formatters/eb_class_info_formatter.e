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

	SHARED_FORMAT_INFO

feature -- Properties

	associated_class: CLASS_C
			-- Class about which information is displayed.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET class texts?
		deferred
		end

	is_dotnet_mode: BOOLEAN
			-- Is Current class a .NET class? 		

feature -- Status setting

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate current formatter with class contained in `a_stone'.
		local
			a_stone: CLASSC_STONE
		do
			force_stone (new_stone)
			a_stone ?= new_stone
			if a_stone /= Void then
				if (not a_stone.class_i.is_external_class) or is_dotnet_formatter then
					set_class (a_stone.e_class)
				end
			else
				associated_class := Void
				class_cmd := Void
				reset_display
				if
					selected and then
					not widget.is_displayed
				then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					display_header
				end
			end
		end

	set_class (a_class: CLASS_C) is
			-- Associate current formatter with `a_class'.
		do
			associated_class := a_class
			if a_class = Void or else not a_class.has_feature_table then
				class_cmd := Void
				associated_class := Void
			else
				create_class_cmd
			end
			must_format := True
			format
			if selected then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		ensure
			class_set: (a_class /= Void and then a_class.has_feature_table) implies (a_class = associated_class)
			cmd_created_if_possible: (a_class = Void or else not a_class.has_feature_table) = (class_cmd = Void)
		end

	set_dotnet_mode (a_flag: BOOLEAN) is
			-- Set whether formatting in .NET mode to 'a_flag'
		do
			is_dotnet_mode := a_flag
		ensure
			mode_is_flag: is_dotnet_mode = a_flag
		end

feature -- Formatting

	formatted_text: STRUCTURED_TEXT is
			-- Structured text representing information concerning `class'.
		do
			if class_cmd /= Void then
				Result := class_cmd.structured_text
			else
				create Result.make
			end
		ensure
			result_non_void: Result /= Void
		end

	save_in_file is
			-- Save output format to a file.
		require else
			class_non_void: associated_class /= Void
		do
--|FIXME XR: To be implemented.
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		deferred
		end

	create_class_cmd is
			-- Create `class_cmd' depending on its actual type.
		require
			associated_class_non_void: associated_class /= Void
			associated_class_is_compiled: associated_class.has_feature_table
		deferred
		ensure
			class_cmd /= Void
		end

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored.
		require else
			class_non_void: associated_class /= Void
		do
			create Result.make_from_string (associated_class.name)
			Result.add_extension (post_fix)
		end

	generate_text is
			-- Fill `formatted_text' with information concerning `class'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if class_cmd /= Void then
					if formatted_text /= Void then
						formatted_text.wipe_out
					end
					if has_breakpoints then
						set_is_with_breakable
					else
						set_is_without_breakable
					end
					class_cmd.execute
				end
				last_was_error := False
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	temp_header: STRING is
			-- Temporary header displayed during the format processing.
		do
			Result := Interface_names.l_Working_formatter.twin
			Result.append (command_name)
			Result.append (Interface_names.l_Of_class)
			if associated_class /= Void then
				Result.append (associated_class.name)
			else

			end

			Result.append (Interface_names.l_Three_dots)
		end

	header: STRING is
			-- Header displayed when current formatter is selected.
		do
			if associated_class /= Void then
				Result := capital_command_name.twin
				Result.append (Interface_names.l_Of_class)
				Result.append (associated_class.name_in_upper)
			else
				Result := Interface_names.l_Not_in_system_no_info
			end
		end

feature {NONE} -- Properties

	class_cmd: E_CLASS_CMD;
			-- Class command that is used to generate text output (especially in files).

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

end -- class EB_CLASS_INFO_FORMATTER

