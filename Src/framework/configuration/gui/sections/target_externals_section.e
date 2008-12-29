note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_EXTERNALS_SECTION

inherit
	TARGET_SECTION
		redefine
			name,
			icon,
			context_menu,
			create_select_actions,
			update_toolbar_sensitivity
		end

create
	make

feature -- Access

	includes: like internal_includes
			-- Include externals.
		do
			if internal_includes /= Void and then has (internal_includes) then
				Result := internal_includes
			end
		end

	objects: like internal_objects
			-- Object externals.
		do
			if internal_objects /= Void and then has (internal_objects) then
				Result := internal_objects
			end
		end

	libraries: like internal_libraries
			-- Library externals.
		do
			if internal_libraries /= Void and then has (internal_libraries) then
				Result := internal_libraries
			end
		end

	makefiles: like internal_makefiles
			-- Make externals.
		do
			if internal_makefiles /= Void and then has (internal_makefiles) then
				Result := internal_makefiles
			end
		end

	resources: like internal_resources
			-- Resource externals.
		do
			if internal_resources /= Void and then has (internal_resources) then
				Result := internal_resources
			end
		end

	name: STRING_GENERAL
			-- Name of the section.
		once
			Result := conf_interface_names.section_external
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.project_settings_externals_icon
		end

feature -- Element update

	add_include
			-- Add a new include external.
		do
			if includes = Void then
				create internal_includes.make (target, configuration_window)
				order_headers
				extend (internal_includes)
			end
			internal_includes.add_external
		end

	add_object
			-- Add a new object external.
		do
			if objects = Void then
				create internal_objects.make (target, configuration_window)
				order_headers
				extend (internal_objects)
			end
			internal_objects.add_external
		end

	add_library
			-- Add a new library external.
		do
			if libraries = Void then
				create internal_libraries.make (target, configuration_window)
				order_headers
				extend (internal_libraries)
			end
			internal_libraries.add_external
		end

	add_make
			-- Add a new make external.
		do
			if makefiles = Void then
				create internal_makefiles.make (target, configuration_window)
				order_headers
				extend (internal_makefiles)
			end
			internal_makefiles.add_external
		end

	add_resource
			-- Add a new resource external.
		do
			if resources = Void then
				create internal_resources.make (target, configuration_window)
				order_headers
				extend (internal_resources)
			end
			internal_resources.add_external
		end

	set_includes (a_externals: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE])
			-- Set include externals.
		local
			l_external: EXTERNAL_INCLUDE_SECTION
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create internal_includes.make (target, configuration_window)
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					internal_includes.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_objects (a_externals: ARRAYED_LIST [CONF_EXTERNAL_OBJECT])
			-- Set object externals.
		local
			l_external: EXTERNAL_OBJECT_SECTION
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create internal_objects.make (target, configuration_window)
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					internal_objects.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_libraries (a_externals: ARRAYED_LIST [CONF_EXTERNAL_LIBRARY])
			-- Set library externals.
		local
			l_external: EXTERNAL_LIBRARY_SECTION
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create internal_libraries.make (target, configuration_window)
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					internal_libraries.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_makefiles (a_externals: ARRAYED_LIST [CONF_EXTERNAL_MAKE])
			-- Set make externals.
		local
			l_external: EXTERNAL_MAKE_SECTION
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create internal_makefiles.make (target, configuration_window)
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					internal_makefiles.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_resources (a_externals: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE])
			-- Set resource externals.
		local
			l_external: EXTERNAL_RESOURCE_SECTION
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create internal_resources.make (target, configuration_window)
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					internal_resources.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (5)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_include, agent add_include)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_include_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_object, agent add_object)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_object_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_library, agent add_library)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_object_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_make, agent add_make)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_makefile_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_resource, agent add_resource)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_resource_icon)
		end

feature -- Simple operations

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_include_button.select_actions.wipe_out
			toolbar.add_include_button.select_actions.extend (agent add_include)
			toolbar.add_include_button.enable_sensitive

			toolbar.add_object_button.select_actions.wipe_out
			toolbar.add_object_button.select_actions.extend (agent add_object)
			toolbar.add_object_button.enable_sensitive

			toolbar.add_external_library_button.select_actions.wipe_out
			toolbar.add_external_library_button.select_actions.extend (agent add_library)
			toolbar.add_external_library_button.enable_sensitive

			toolbar.add_make_button.select_actions.wipe_out
			toolbar.add_make_button.select_actions.extend (agent add_make)
			toolbar.add_make_button.enable_sensitive

			toolbar.add_resource_button.select_actions.wipe_out
			toolbar.add_resource_button.select_actions.extend (agent add_resource)
			toolbar.add_resource_button.enable_sensitive
		end

feature {NONE} -- Implementation

	internal_includes: TARGET_INCLUDE_EXTERNALS_SECTION
			-- Include externals (Could still be present even if it removed from Current)

	internal_objects: TARGET_OBJECT_EXTERNALS_SECTION
			-- Object externals (Could still be present even if it removed from Current)

	internal_libraries: TARGET_LIBRARY_EXTERNALS_SECTION
			-- Library externals (Could still be present even if it removed from Current)

	internal_makefiles: TARGET_MAKE_EXTERNALS_SECTION
			-- Make externals (Could still be present even if it removed from Current)

	internal_resources: TARGET_RESOURCE_EXTERNALS_SECTION
			-- Resource externals (Could still be present even if it removed from Current)

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	order_headers
			-- Order headers in correct order.
		local
			l_inc, l_obj, l_lib, l_mak, l_res: BOOLEAN
		do
			if internal_includes /= Void then
				l_inc := internal_includes.is_expanded
			end
			if internal_objects /= Void then
				l_obj := internal_objects.is_expanded
			end
			if internal_libraries /= Void then
				l_lib := internal_libraries.is_expanded
			end
			if internal_makefiles /= Void then
				l_mak := internal_makefiles.is_expanded
			end
			if internal_resources /= Void then
				l_res := internal_resources.is_expanded
			end

			wipe_out

			if internal_includes /= Void and then not internal_includes.is_empty then
				extend (internal_includes)
				if l_inc then
					internal_includes.expand
				end
			end
			if internal_objects /= Void and then not internal_objects.is_empty then
				extend (internal_objects)
				if l_obj then
					internal_objects.expand
				end
			end
			if internal_libraries /= Void and then not internal_libraries.is_empty then
				extend (internal_libraries)
				if l_lib then
					internal_libraries.expand
				end
			end
			if internal_makefiles /= Void and then not internal_makefiles.is_empty then
				extend (internal_makefiles)
				if l_mak then
					internal_makefiles.expand
				end
			end
			if internal_resources /= Void and then not internal_resources.is_empty then
				extend (internal_resources)
				if l_res then
					internal_resources.expand
				end
			end
		end

note
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
