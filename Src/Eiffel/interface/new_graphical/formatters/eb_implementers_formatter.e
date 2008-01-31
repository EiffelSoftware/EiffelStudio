indexing
	description: "Command to display the implementers of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_IMPLEMENTERS_FORMATTER

inherit
	EB_FEATURE_CONTENT_FORMATTER
		redefine
			is_dotnet_formatter,
			browser
		end

create
	make

feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_FEATURE_RELATION_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_FEATURE_RELATION_TOOL_VIEW_MODES}.implementers
		end

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.feature_implementers_icon, 1)
			Result.put (pixmaps.icon_pixmaps.feature_implementers_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.feature_implementers_icon_buffer
		end

	menu_name: STRING_GENERAL is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showhistory
		end

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL is
			-- Name of the command.
		do
			Result := Interface_names.l_Implementers
		end

	post_fix: STRING is "imp"
			-- String symbol of the command, used as an extension when saving.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET XML types?
		do
			Result := True
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

feature {NONE} -- Implementation

	has_breakpoints: BOOLEAN is False
			-- Should breakpoints be shown in Current?

	criterion: QL_CRITERION is
			-- Criterion of current formatter
		do
			create {QL_FEATURE_IMPLEMENTORS_OF_CRI}Result.make (query_feature_item_from_e_feature (associated_feature).wrapped_domain)
		end

	rebuild_browser is
			-- Rebuild `browser'.
		do
			browser.set_is_branch_id_used (True)
			browser.set_is_written_class_used (False)
			browser.set_is_signature_displayed (True)
			browser.set_is_version_from_displayed (True)
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

end -- class EB_IMPLEMENTERS_FORMATTER

