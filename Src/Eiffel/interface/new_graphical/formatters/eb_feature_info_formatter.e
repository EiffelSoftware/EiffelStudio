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
		redefine
			new_button
		end

feature -- Access

	new_button: EV_TOOL_BAR_RADIO_BUTTON is
			-- Create a new toolbar button and associate it with `Current'.
		do
			Result := Precursor
			Result.drop_actions.extend (agent on_feature_drop)
		end

feature -- Properties

	associated_feature: E_FEATURE
			-- Feature about which information is displayed.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET class texts?
		deferred
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

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored.
		require else
			class_non_void: associated_feature /= Void
		do
			create Result.make_from_string (associated_feature.name)
			Result.add_extension (post_fix)
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

	empty_widget: EV_WIDGET is
			-- Widget displayed when no information can be displayed.
		do
			if internal_empty_widget = Void then
				new_empty_widget
			end
			Result := internal_empty_widget
		end

	internal_empty_widget: EV_WIDGET
			-- Widget displayed when no information can be displayed.	

	on_feature_drop (fs: FEATURE_STONE) is
			-- Notify `manager' of the dropping of `fs'.
		do
			if not selected then
				execute
			end
			if fs.e_feature /= associated_feature then
				manager.set_stone (fs)
			end
		end

	new_empty_widget is
			-- Initialize a default empty_widget.
		local
			def: EV_STOCK_COLORS
			manag: EB_FEATURES_VIEW
		do
			create def
			create {EV_CELL} internal_empty_widget
			internal_empty_widget.set_background_color (def.White)
			manag ?= widget_owner
			if manag = Void then
				internal_empty_widget.drop_actions.extend (agent on_feature_drop)
			else
				internal_empty_widget.drop_actions.extend (agent manag.drop_stone)
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

end -- class EB_FEATURE_INFO_FORMATTER
