note
	description: "Tool to view the favorites"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FAVORITES_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EB_FAVORITES_TREE]
		redefine
			on_show,
			create_mini_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization: User interface

    build_tool_interface (a_widget: attached EB_FAVORITES_TREE)
            -- <Precursor>
		do

		end

feature {NONE} -- Access

	favorites_manager: attached EB_FAVORITES_MANAGER
			-- Associated favorites manager.
		do
			Result := develop_window.favorites_manager
		end

feature {NONE} -- Access: User interface

	edit_tool_bar_button: detachable SD_TOOL_BAR_BUTTON
			-- Edit tool bar button.

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "75CFEDA2-3823-EF29-130A-39E686116F40"
		end

feature {NONE} -- Action handlers

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		local
			l_stone: like stone
		do
			l_stone := stone
			if l_stone /= Void then
				favorites_manager.add_stone (l_stone)
			end
		end

	on_show
			-- <Precursor>
		do
			Precursor
			user_widget.set_focus
		end

feature {NONE} -- Factory

    create_widget: attached EB_FAVORITES_TREE
    		-- <Precursor>
		do
			Result := favorites_manager.widget
		end

    create_mini_tool_bar_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
    		-- <Precursor>
    	local
    		l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (1)

				-- `edit_tool_bar_button'
			create l_button.make
			l_button.set_tooltip (Interface_names.t_organize_favorites)
			l_button.select_actions.extend (agent favorites_manager.organize_favorites)
			l_button.set_pixel_buffer (stock_mini_pixmaps.general_edit_icon_buffer)
			l_button.set_pixmap (stock_mini_pixmaps.general_edit_icon)
			edit_tool_bar_button := l_button

			Result.extend (l_button)
		end

    create_tool_bar_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
    		-- <Precursor>
		do
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
