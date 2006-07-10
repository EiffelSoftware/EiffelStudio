indexing
	description	: "Tool to view the favorites"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROPERTIES_TOOL

inherit
	EB_TOOL
		rename
			make as tool_make
		redefine
			menu_name,
			pixmap
		end

	GROUP_PROPERTIES
		redefine
			store_changes,
			refresh
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER) is
			-- Make a new properties tool.
		require
			a_manager_exists: a_manager /= Void
		do
			tool_make (a_manager)
			make_group_properties
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			create widget

			create properties
			widget.extend (properties)

			properties.drop_actions.extend (agent add_stone)
			properties.drop_actions.set_veto_pebble_function (agent dropable)
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			create explorer_bar_item.make (explorer_bar, widget, title, True)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Widget representing Current

	title: STRING is
			-- Title of the tool
		do
			Result := Interface_names.t_Properties_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Properties_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := pixmaps.icon_pixmaps.project_settings_system_icon
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
				explorer_bar_item := Void
			end
			manager := Void
		end

feature {EB_DEVELOPMENT_WINDOW} -- Actions

	add_stone (a_stone: STONE) is
			-- Add `a_stone'.
		require
			a_stone_not_void: a_stone /= Void
		local
			l_gs: CLUSTER_STONE
			l_group: CONF_GROUP
			l_lib_use: ARRAYED_LIST [CONF_LIBRARY]
			l_writable: BOOLEAN
			l_app_sys: CONF_SYSTEM
		do
			check
				properties: properties /= Void
			end
			stone := a_stone
			l_gs ?= a_stone
			if l_gs /= Void then
				l_group := l_gs.group
				current_system := l_group.target.system
				properties.reset
				add_group_properties (l_group, l_group.target)
				l_lib_use := l_group.target.used_in_libraries
				if l_lib_use /= Void then
					l_app_sys := l_group.target.application_target.system
					from
						l_lib_use.start
					until
						l_writable or l_lib_use.after
					loop
							-- to be writable, the library has to be not readonly in the application configuration
						l_writable := not l_lib_use.item.is_readonly and l_lib_use.item.target.system = l_app_sys
						l_lib_use.forth
					end
					if not l_writable then
						properties.mark_all_readonly
					end
				end
				properties.column(1).set_width (properties.column (1).required_width_of_item_span (1, properties.row_count) + 3)
			end
		ensure
			stone_set: stone = a_stone
		end

	dropable (a_pebble: ANY): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		require
			a_pebble_not_void: a_pebble /= Void
		local
			l_gs: CLUSTER_STONE
		do
			l_gs ?= a_pebble
			Result := l_gs /= Void
		end

feature {NONE} -- Implementation

	stone: STONE
			-- Stone we display properties for.

	current_system: CONF_SYSTEM
			-- System currently editing.	

	store_changes is
			-- Store changes to disk.
		do
			check
				current_system: current_system /= Void
			end
			current_system.store
			manager.cluster_manager.refresh
		end

	refresh is
			-- Refresh the displayed data.
		do
			properties.set_focus
			add_stone (stone)
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

end
