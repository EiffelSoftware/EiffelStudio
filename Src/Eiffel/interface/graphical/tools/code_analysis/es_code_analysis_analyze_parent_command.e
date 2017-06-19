note
	description: "[
		Command to launch Code Analyzer on a parent cluster of recently analyzed item.
		
		Can be added to toolbars and menus.
		Can be executed using stones.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_ANALYSIS_ANALYZE_PARENT_COMMAND

inherit

	ES_CODE_ANALYSIS_COMMAND
		redefine
			description,
			menu_name,
			name,
			new_sd_toolbar_item,
			on_finish,
			on_put,
			on_start,
			pixel_buffer,
			pixmap,
			tooltext,
			tooltip
		end

create
	make

feature -- Items

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- <Precursor>
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			if display_text then
				Result.set_text (tooltext)
			end
			Result.set_tooltip (tooltip)
			Result.select_actions.extend (agent analyze_parent_cluster)
		ensure then
			valid_result: Result /= Void
		end

feature {CODE_ANALYZER_S} -- Event handlers

	on_put (service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]; item: STONE)
			-- <Precursor>
		do
			update_sensitive
		end

	on_start (service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION])
			-- <Precursor>
		do
			disable_sensitive
		end

	on_finish (service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]; exceptions: ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- <Precursor>
		do
			update_sensitive
		end

feature -- Visibility

	update_sensitive
			-- Update visibility status.
		do
			if attached parent_stone then
				enable_sensitive
			end
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.analyzer_analyze_cluster_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.analyzer_analyze_cluster_icon_buffer
		end

feature -- Access

	name: STRING = "Analyze_parent"
			-- <Precursor>

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := ca_messages.analyze_parent_menu (Void)
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := ca_names.analyze_parent_tool_text
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := ca_names.analyze_parent_tooltip
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := ca_messages.analyze_parent_description
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
