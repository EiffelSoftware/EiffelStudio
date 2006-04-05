indexing
	description: "Formatter that displays information about a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FEATURE_INFO_FORMATTER

inherit
	EB_FORMATTER

feature -- Properties

	associated_feature: E_FEATURE
			-- Feature about which information is displayed.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET class texts?
		deferred
		end

feature -- Status setting

	set_stone (new_stone: FEATURE_STONE) is
			-- Associate current formatter with feature contained in `new_stone'.
		do
			force_stone (new_stone)
			if new_stone /= Void then
				if (not new_stone.class_i.is_external_class) or is_dotnet_formatter then
					set_feature (new_stone.e_feature)
				end
			else
				associated_feature := Void
				feature_cmd := Void
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

	set_feature (a_feature: E_FEATURE) is
			-- Associate current formatter with `a_feature'.
		do
			associated_feature := a_feature
			if a_feature = Void or else not a_feature.associated_class.has_feature_table then
				feature_cmd := Void
				associated_feature := Void
			else
				create_feature_cmd
			end
			must_format := True
			format
			if
				selected and then
				not widget.is_displayed
			then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		ensure
			feature_set: a_feature = associated_feature
			cmd_created_if_possible: (a_feature = Void) = (feature_cmd = Void)
		end

feature -- Formatting

	save_in_file is
			-- Save output format to a file.
		require else
			feature_non_void: associated_feature /= Void
		do
--|FIXME XR: To be implemented.
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		deferred
		end

	create_feature_cmd is
			-- Create `feature_cmd' depending on `Current's actual type.
		require
			associated_feature_non_void: associated_feature /= Void
		deferred
		ensure
			feature_cmd /= Void
		end

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored.
		require else
			class_non_void: associated_feature /= Void
		do
			create Result.make_from_string (associated_feature.name)
			Result.add_extension (post_fix)
		end

	generate_text is
			-- Fill `formatted_text' with information concerning `associated_feature'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if feature_cmd /= Void then
					editor.handle_before_processing (false)
					feature_cmd.execute
					editor.handle_after_processing
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
			Result.append (Interface_names.l_Of_feature)
			Result.append (associated_feature.name)
			Result.append (Interface_names.l_Three_dots)
		end

	header: STRING is
			-- Header displayed when current formatter is selected.
		do
			if associated_feature /= Void then
				Result := capital_command_name.twin
				Result.append (Interface_names.l_Of_feature)
				Result.append (associated_feature.name)
				Result.append (Interface_names.l_Of_class)
				Result.append (associated_feature.associated_class.name_in_upper)
			else
				Result := Interface_names.l_No_feature
			end
		end

	line_numbers_allowed: BOOLEAN is False
		-- Does it make sense to show line numbers in Current?

feature {NONE} -- Properties	

	feature_cmd: E_FEATURE_CMD;
			-- Feature command that is used to generate text output (especially in files).

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

end -- class EB_FEATURE_INFO_FORMATTER
