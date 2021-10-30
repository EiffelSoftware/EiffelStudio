note
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
			if attached internal_includes as i and then has (i) then
				Result := i
			end
		end

	cflag: like internal_cflag
			-- C flag externals.
		do
			if attached internal_cflag as e and then has (e) then
				Result := e
			end
		end

	objects: like internal_objects
			-- Object externals.
		do
			if attached internal_objects as o and then has (o) then
				Result := o
			end
		end

	libraries: like internal_libraries
			-- Library externals.
		do
			if attached internal_libraries as l and then has (l) then
				Result := l
			end
		end

	resources: like internal_resources
			-- Resource externals.
		do
			if attached internal_resources as i and then has (i) then
				Result := i
			end
		end

	linker_flag: like internal_linker_flag
			-- Linker flag externals.
		do
			if attached internal_linker_flag as e and then has (e) then
				Result := e
			end
		end

	makefiles: like internal_makefiles
			-- Make externals.
		do
			if attached internal_makefiles as m and then has (m) then
				Result := m
			end
		end

	name: READABLE_STRING_32
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
		local
			i: like includes
		do
			i := includes
			if not attached i then
				create i.make (target, configuration_window)
				internal_includes := i
				order_headers
				extend (i)
			end
			i.add_external
		end

	add_cflag
			-- Add a new C flag external.
		local
			f: like cflag
		do
			f := cflag
			if not attached f then
				create f.make (target, configuration_window)
				internal_cflag := f
				order_headers
				extend (f)
			end
			f.add_external
		end

	add_object
			-- Add a new object external.
		local
			o: like objects
		do
			o := objects
			if not attached o then
				create o.make (target, configuration_window)
				internal_objects := o
				order_headers
				extend (o)
			end
			o.add_external
		end

	add_library
			-- Add a new library external.
		local
			l: like libraries
		do
			l := libraries
			if not attached l then
				create l.make (target, configuration_window)
				internal_libraries := l
				order_headers
				extend (l)
			end
			l.add_external
		end

	add_resource
			-- Add a new resource external.
		local
			r: like resources
		do
			r := resources
			if not attached r then
				create r.make (target, configuration_window)
				internal_resources := r
				order_headers
				extend (r)
			end
			r.add_external
		end

	add_linker_flag
			-- Add a new linker flag external.
		local
			f: like linker_flag
		do
			f := linker_flag
			if not attached f then
				create f.make (target, configuration_window)
				internal_linker_flag := f
				order_headers
				extend (f)
			end
			f.add_external
		end

	add_make
			-- Add a new make external.
		local
			m: like makefiles
		do
			m := makefiles
			if not attached m then
				create m.make (target, configuration_window)
				internal_makefiles := m
				order_headers
				extend (m)
			end
			m.add_external
		end

	set_includes (a_externals: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE])
			-- Set include externals.
		local
			l_external: EXTERNAL_INCLUDE_SECTION
			l_internal_includes: like internal_includes
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_internal_includes.make (target, configuration_window)
				internal_includes := l_internal_includes
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					l_internal_includes.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_cflag (e: ARRAYED_LIST [CONF_EXTERNAL_CFLAG])
			-- Set C flag externals.
		local
			l_internal_cflag: like internal_cflag
		do
			if attached e and then not e.is_empty then
				create l_internal_cflag.make (target, configuration_window)
				internal_cflag := l_internal_cflag
				across e as c loop
					l_internal_cflag.extend
						(create {EXTERNAL_CFLAG_SECTION}.make (c, target, configuration_window))
				end
				order_headers
			end
		end

	set_objects (a_externals: ARRAYED_LIST [CONF_EXTERNAL_OBJECT])
			-- Set object externals.
		local
			l_external: EXTERNAL_OBJECT_SECTION
			l_internal_objects: like internal_objects
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_internal_objects.make (target, configuration_window)
				internal_objects := l_internal_objects
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					l_internal_objects.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_libraries (a_externals: ARRAYED_LIST [CONF_EXTERNAL_LIBRARY])
			-- Set library externals.
		local
			l_external: EXTERNAL_LIBRARY_SECTION
			l_internal_libraries: like internal_libraries
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_internal_libraries.make (target, configuration_window)
				internal_libraries := l_internal_libraries
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					l_internal_libraries.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_resources (a_externals: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE])
			-- Set resource externals.
		local
			l_external: EXTERNAL_RESOURCE_SECTION
			l_internal_resources: like internal_resources
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_internal_resources.make (target, configuration_window)
				internal_resources := l_internal_resources
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					l_internal_resources.extend (l_external)
					a_externals.forth
				end
				order_headers
			end
		end

	set_linker_flag (e: ARRAYED_LIST [CONF_EXTERNAL_LINKER_FLAG])
			-- Set linker flag externals.
		local
			l_internal_linker_flag: like internal_linker_flag
		do
			if attached e and then not e.is_empty then
				create l_internal_linker_flag.make (target, configuration_window)
				internal_linker_flag := l_internal_linker_flag
				across e as c loop
					l_internal_linker_flag.extend
						(create {EXTERNAL_LINKER_FLAG_SECTION}.make (c, target, configuration_window))
				end
				order_headers
			end
		end

	set_makefiles (a_externals: ARRAYED_LIST [CONF_EXTERNAL_MAKE])
			-- Set make externals.
		local
			l_external: EXTERNAL_MAKE_SECTION
			l_internal_makefiles: like internal_makefiles
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_internal_makefiles.make (target, configuration_window)
				internal_makefiles := l_internal_makefiles
				from
					a_externals.start
				until
					a_externals.after
				loop
					create l_external.make (a_externals.item, target, configuration_window)
					l_internal_makefiles.extend (l_external)
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
			create Result.make (7)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_include, agent add_include)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_include_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_cflag, agent add_cflag)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_cflag_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_object, agent add_object)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_object_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_library, agent add_library)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_object_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_resource, agent add_resource)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_resource_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_linker_flag, agent add_linker_flag)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_linker_flag_icon)

			create l_item.make_with_text_and_action (conf_interface_names.external_add_make, agent add_make)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_makefile_icon)
		end

feature -- Simple operations

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_include_button.select_actions.wipe_out
			toolbar.add_include_button.select_actions.extend (agent add_include)
			toolbar.add_include_button.enable_sensitive

			toolbar.add_cflag_button.select_actions.wipe_out
			toolbar.add_cflag_button.select_actions.extend (agent add_cflag)
			toolbar.add_cflag_button.enable_sensitive

			toolbar.add_object_button.select_actions.wipe_out
			toolbar.add_object_button.select_actions.extend (agent add_object)
			toolbar.add_object_button.enable_sensitive

			toolbar.add_external_library_button.select_actions.wipe_out
			toolbar.add_external_library_button.select_actions.extend (agent add_library)
			toolbar.add_external_library_button.enable_sensitive

			toolbar.add_resource_button.select_actions.wipe_out
			toolbar.add_resource_button.select_actions.extend (agent add_resource)
			toolbar.add_resource_button.enable_sensitive

			toolbar.add_linker_flag_button.select_actions.wipe_out
			toolbar.add_linker_flag_button.select_actions.extend (agent add_linker_flag)
			toolbar.add_linker_flag_button.enable_sensitive

			toolbar.add_make_button.select_actions.wipe_out
			toolbar.add_make_button.select_actions.extend (agent add_make)
			toolbar.add_make_button.enable_sensitive
		end

feature {NONE} -- Implementation

	internal_includes: detachable TARGET_INCLUDE_EXTERNALS_SECTION
			-- Include externals (Could still be present even if it removed from Current)

	internal_cflag: detachable TARGET_CFLAG_EXTERNALS_SECTION
			-- C flag externals (Could still be present even if it removed from Current)

	internal_objects: detachable TARGET_OBJECT_EXTERNALS_SECTION
			-- Object externals (Could still be present even if it removed from Current)

	internal_libraries: detachable TARGET_LIBRARY_EXTERNALS_SECTION
			-- Library externals (Could still be present even if it removed from Current)

	internal_resources: detachable TARGET_RESOURCE_EXTERNALS_SECTION
			-- Resource externals (Could still be present even if it removed from Current)

	internal_linker_flag: detachable TARGET_LINKER_FLAG_EXTERNALS_SECTION
			-- Linker flag externals (Could still be present even if it removed from Current)

	internal_makefiles: detachable TARGET_MAKE_EXTERNALS_SECTION
			-- Make externals (Could still be present even if it removed from Current)

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	order_headers
			-- Order headers in correct order.
		local
			l_inc, l_cfl, l_obj, l_lib, l_res, l_lfl, l_mak: BOOLEAN
		do
			l_inc := attached internal_includes as e and then e.is_expanded
			l_cfl := attached internal_cflag as e and then e.is_expanded
			l_obj := attached internal_objects as e and then e.is_expanded
			l_lib := attached internal_libraries as e and then e.is_expanded
			l_res := attached internal_resources as e and then e.is_expanded
			l_lfl := attached internal_linker_flag as e and then e.is_expanded
			l_mak := attached internal_makefiles as e and then e.is_expanded

			wipe_out

			if attached internal_includes as e and then not e.is_empty then
				extend (e)
				if l_inc then
					e.expand
				end
			end
			if attached internal_cflag as e and then not e.is_empty then
				extend (e)
				if l_cfl then
					e.expand
				end
			end
			if attached internal_objects as e and then not e.is_empty then
				extend (e)
				if l_obj then
					e.expand
				end
			end
			if attached internal_libraries as e and then not e.is_empty then
				extend (e)
				if l_lib then
					e.expand
				end
			end
			if attached internal_resources as e and then not e.is_empty then
				extend (e)
				if l_res then
					e.expand
				end
			end
			if attached internal_linker_flag as e and then not e.is_empty then
				extend (e)
				if l_lfl then
					e.expand
				end
			end
			if attached internal_makefiles as e and then not e.is_empty then
				extend (e)
				if l_mak then
					e.expand
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
