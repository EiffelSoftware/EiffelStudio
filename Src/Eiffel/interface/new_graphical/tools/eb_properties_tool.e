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
		undefine
			layout_constants
		redefine
			menu_name,
			pixmap
		end

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as cluster_manager
		redefine
			on_class_removed,
			on_cluster_removed,
			refresh
		end

	GROUP_PROPERTIES
		redefine
			handle_value_changes,
			refresh
		end

	TARGET_PROPERTIES
		rename
			conf_system as current_system
		redefine
			handle_value_changes,
			refresh
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	CONF_GUI_INTERFACE_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER) is
			-- Make a new properties tool.
		require
			a_manager_exists: a_manager /= Void
		do
			set_pixmaps (pixmaps)
			tool_make (a_manager)
			cluster_manager.extend (Current)
			create {CONF_COMP_FACTORY} conf_factory
			window := a_manager.window
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

	conf_factory: CONF_PARSE_FACTORY
			-- Factory to create new nodes.

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
			Result := pixmaps.icon_pixmaps.tool_properties_icon
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
			cluster_manager.remove_observer (Current)
			manager := Void
		end

feature {NONE} -- External changes to classes/clusters

	on_class_removed (a_class: EIFFEL_CLASS_I) is
			-- Refresh the properties to not display properties for `a_class'.
		do
			refresh
		end

	on_cluster_removed (a_group: EB_SORTED_CLUSTER; a_path: STRING_8) is
			-- Refresh the properties to not display properties for `a_group'.
		do
			refresh
		end

feature {EB_DEVELOPMENT_WINDOW} -- Actions

	add_stone (a_stone: STONE) is
			-- Add `a_stone'.
		require
			a_stone_ok: a_stone /= Void and then a_stone.is_valid
		local
			l_gs: CLUSTER_STONE
			l_cs: CLASSI_STONE
			l_ts: TARGET_STONE
			l_group: CONF_GROUP
			l_lib_use: ARRAYED_LIST [CONF_LIBRARY]
			l_writable: BOOLEAN
			l_app_sys: CONF_SYSTEM
			l_class_options, l_inh_options: CONF_OPTION
			l_name_prop: STRING_PROPERTY [STRING]
			l_extends: BOOLEAN
			l_debugs: SEARCH_TABLE [STRING]
		do
				-- sort debugs
			if workbench.system_defined then
				l_debugs := system.debug_clauses
			end
			if l_debugs /= Void then
				create debug_clauses.make (l_debugs.count)
				from
					l_debugs.start
				until
					l_debugs.after
				loop
					debug_clauses.put_last (l_debugs.item_for_iteration)
					l_debugs.forth
				end
				debug_clauses.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
			else
				create debug_clauses.make_default
			end

			check
				properties: properties /= Void
			end
			properties.lock_update

			stone := a_stone
			l_gs ?= a_stone
			l_cs ?= a_stone
			l_ts ?= a_stone
			if l_gs /= Void or l_cs /= Void then
				if l_gs /= Void then
					l_group := l_gs.group
					if l_group.is_cluster and l_group.is_used_in_library then
						l_group := l_group.target.system.lowest_used_in_library
					end
					current_system := l_group.target.system
					properties.reset
					add_group_properties (l_group, l_group.target)
					properties.column(1).set_width (properties.column (1).required_width_of_item_span (1, properties.row_count) + 3)
					properties.set_expanded_section_store (group_section_expanded_status)
				elseif l_cs /= Void then
					l_group := l_cs.class_i.group
					if l_group.is_used_in_library then
						l_group := l_group.target.system.lowest_used_in_library
					end
					current_system := l_group.target.system
					l_class_options := l_group.changeable_class_options (l_cs.class_name)
					create l_inh_options
					l_inh_options.merge (l_class_options)
					l_inh_options.merge (l_group.options)
					properties.reset
					properties.add_section (conf_interface_names.section_general)
					create l_name_prop.make (conf_interface_names.group_type_name)
					l_name_prop.set_value (conf_interface_names.properties_class_name)
					l_name_prop.enable_readonly
					properties.add_property (l_name_prop)
					create l_name_prop.make (conf_interface_names.class_option_class_name)
					l_name_prop.set_value (l_cs.class_name)
					l_name_prop.enable_readonly
					properties.add_property (l_name_prop)
					create l_name_prop.make (conf_interface_names.class_option_file_name)
					l_name_prop.set_value (l_cs.file_name)
					l_name_prop.enable_readonly
					properties.add_property (l_name_prop)
					add_misc_option_properties (l_class_options, l_inh_options, True)
					add_dotnet_option_properties (l_class_options, l_inh_options, True, l_group.target.setting_msil_generation)
					add_assertion_option_properties (l_class_options, l_inh_options, True)
					add_warning_option_properties (l_class_options, l_inh_options, True)
					add_debug_option_properties (l_class_options, l_inh_options, True)
					properties.set_expanded_section_store (class_section_expanded_status)
				else
					check should_not_reach: False end
				end
				l_lib_use := l_group.target.system.used_in_libraries
				if l_lib_use /= Void then
					l_app_sys := l_group.target.system.application_target.system
					l_writable := l_group.target.system = l_group.target.system.application_target.system
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
			elseif l_ts /= Void then
				properties.reset
				properties.add_section (conf_interface_names.section_general)
				create l_name_prop.make (conf_interface_names.group_type_name)
				l_name_prop.set_value (conf_interface_names.properties_target_name)
				l_name_prop.enable_readonly
				properties.add_property (l_name_prop)
				current_target := l_ts.target
				current_system := current_target.system
				l_extends := current_target.extends /= Void
				add_general_properties
				add_assertion_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)
				add_warning_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)
				add_debug_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)
				add_advanced_properties

				properties.set_expanded_section_store (target_section_expanded_status)
			end

			properties.unlock_update
		ensure
			stone_set: stone = a_stone
		end

	dropable (a_pebble: STONE): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		require
			a_pebble_not_void: a_pebble /= Void
		local
			l_gs: CLUSTER_STONE
			l_cs: CLASSI_STONE
			l_ts: TARGET_STONE
		do
			l_gs ?= a_pebble
			l_cs ?= a_pebble
			l_ts ?= a_pebble
			Result := l_gs /= Void or l_cs /= Void or l_ts /= Void
		end

feature {NONE} -- Implementation

	is_storing: BOOLEAN
			-- Are we at the moment storing the information to disk.

	stone: STONE
			-- Stone we display properties for.

	group_section_expanded_status: HASH_TABLE [BOOLEAN, STRING] is
			-- Expanded status of sections of groups.
		once
			create Result.make (5)
			Result.force (True, conf_interface_names.section_general)
			Result.force (True, conf_interface_names.section_assertions)
			Result.force (False, conf_interface_names.section_warning)
			Result.force (False, conf_interface_names.section_debug)
			Result.force (False, conf_interface_names.section_advanced)
		end

	class_section_expanded_status: HASH_TABLE [BOOLEAN, STRING] is
			-- Expanded status of sections of class options.
		once
			create Result.make (4)
			Result.force (True, conf_interface_names.section_general)
			Result.force (True, conf_interface_names.section_assertions)
			Result.force (False, conf_interface_names.section_warning)
			Result.force (False, conf_interface_names.section_debug)
		end

	target_section_expanded_status: HASH_TABLE [BOOLEAN, STRING] is
			-- Expanded status of sections of targets.
		once
			create Result.make (5)
			Result.force (True, conf_interface_names.section_general)
			Result.force (True, conf_interface_names.section_assertions)
			Result.force (False, conf_interface_names.section_warning)
			Result.force (False, conf_interface_names.section_debug)
			Result.force (False, conf_interface_names.section_advanced)
			Result.force (False, conf_interface_names.section_dotnet)
		end

	handle_value_changes (a_has_group_changed: BOOLEAN) is
			-- Store changes to disk.
		do
				-- only if the stone is still valid
			if stone.is_valid then
				check
					current_system: current_system /= Void
				end
				is_storing := True
				current_system.store
				manager.cluster_manager.refresh
				if a_has_group_changed then
					system.force_rebuild
				end
				is_storing := False
			end
		end

	refresh is
			-- Refresh the displayed data.
		do
			if not is_storing then
				if properties.is_displayed then
					properties.set_focus
				end
				if stone /= Void and then stone.is_valid then
					add_stone (stone)
				else
					properties.reset
				end
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

end
