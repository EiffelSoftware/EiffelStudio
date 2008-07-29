indexing
	description: "Command to display the homonyms of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HOMONYMS_FORMATTER

inherit
	EB_FEATURE_CONTENT_FORMATTER
		redefine
			is_dotnet_formatter,
			format,
			browser
		end

	EB_SHARED_PREFERENCES

create
	make

feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_FEATURE_RELATION_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_FEATURE_RELATION_TOOL_VIEW_MODES}.homonyms
		end

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.feature_homonyms_icon, 1)
			Result.put (pixmaps.icon_pixmaps.feature_homonyms_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.feature_homonyms_icon_buffer
		end

	menu_name: STRING_GENERAL is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showhomonyms
		end

	browser: EB_FEATURE_BROWSER_GRID_VIEW
			-- Browser

	displayer_generator: TUPLE [any_generator: FUNCTION [ANY, TUPLE, like displayer]; name: STRING] is
			-- Generator to generate proper `displayer' for Current formatter
		do
			Result := [agent displayer_generators.new_feature_displayer, displayer_generators.feature_displayer]
		end

	sorting_status_preference: STRING_PREFERENCE is
			-- Preference to store last sorting orders of Current formatter
		do
			Result := preferences.class_browser_data.feature_view_sorting_order_preference
		end

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL is
			-- Name of the command.
		do
			Result := Interface_names.l_Homonyms
		end

	post_fix: STRING is "hom"
			-- String symbol of the command, used as an extension when saving.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET XML types?
		do
			Result := True
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		local
			l_warning: ES_DISCARDABLE_WARNING_PROMPT
		do
			if associated_feature /= Void and then associated_feature.is_valid and then selected and then displayed and then actual_veto_format_result then
				retrieve_sorting_order
				display_temp_header
				setup_viewpoint
				confirmed := False
				create l_warning.make_standard_with_cancel (Interface_names.l_homonym_confirmation, "", preferences.dialog_data.generate_homonyms_string)
				l_warning.set_button_action (l_warning.dialog_buttons.ok_button, agent confirm_generate)
				l_warning.show_on_active_window
				if not widget.is_displayed then
					widget.show
				end
				if confirmed then
					last_was_error := False
					rebuild_browser
					generate_result
				else
					browser.update (Void, Void)
				end
				display_header
			end
		end

feature {NONE} -- Implementation

	confirm_generate is
			-- The user DOES want to generate the homonyms.
		do
			confirmed := True
		end

	confirmed: BOOLEAN
			-- Did the user confirm he wanted to generate the homonyms?

	has_breakpoints: BOOLEAN is False;
			-- Should breakpoints be shown in Current?

	criterion: QL_CRITERION is
			-- Criterion of current formatter
		do
			create {QL_FEATURE_NAME_IS_CRI}Result.make_with_setting (associated_feature.name, False, {QL_NAME_CRITERION}.identity_matching_strategy)
		end

	rebuild_browser is
			-- Rebuild `browser'.
		do
			browser.set_is_branch_id_used (False)
			browser.set_is_written_class_used (True)
			browser.set_is_signature_displayed (True)
			browser.set_is_version_from_displayed (False)
			browser.set_feature_item (associated_feature)
			browser.rebuild_interface
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

end -- class EB_HOMONYMS_FORMATTER

