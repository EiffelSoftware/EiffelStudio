note
	description: "Eiffel System Information tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ES_INFORMATION_TOOL

inherit
	ES_STONABLE_TOOL [ES_INFORMATION_TOOL_PANEL]

	ES_INFORMATION_TOOL_COMMANDER_I
		undefine
			out
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_watch_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_watch_icon
		end

	title: attached STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

feature -- Basic operations

	refresh_list
			-- <Precursor>
		local
			l_panel: like panel
		do
			l_panel := panel
			if l_panel.is_interface_usable then
				l_panel.refresh_list
			end
		end

	request_eis_visit
			-- <Precursor>
		local
			l_panel: like panel
		do
			l_panel := panel
			if l_panel.is_interface_usable then
				l_panel.request_eis_visit
			end
		end

	add_information_to (a_stone: ANY)
			-- <Precursor>
		local
			l_panel: like panel
		do
			l_panel := panel
			if l_panel.is_interface_usable then
				l_panel.add_information_to (a_stone)
			end
		end

	class_entries (a_classi: CLASS_I): SEARCH_TABLE [EIS_ENTRY]
			-- EIS entries corresponding to `a_classi'
		local
			l_panel: like panel
		do
			l_panel := panel
			if l_panel.is_interface_usable then
				Result := l_panel.class_entries (a_classi)
			else
				create Result.make (0)
			end
		end

feature -- Status Report

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := attached {CLASSI_STONE} a_stone or else
				attached {CLUSTER_STONE} a_stone or else
				attached {TARGET_STONE} a_stone
		end

feature {NONE} -- Factory

	new_tool: attached ES_INFORMATION_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Info"

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
