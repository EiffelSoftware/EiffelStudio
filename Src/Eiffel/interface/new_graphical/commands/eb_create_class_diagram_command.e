note
	description	: "Command to change links layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_CLASS_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			menu_name
		end

create
	make

feature -- Basic operations

	execute
			-- Display information about `Current'.
		local
			dialog: EB_CREATE_CLASS_DIALOG
			l_group: CONF_CLUSTER
			l_choose_dialog: EB_CHOOSE_CLASS_DIALOG
			l_class_name: STRING
			l_class_i_list: LIST [CLASS_I]
			l_class_i: CLASS_I
		do
			if add_existing_class then
					-- Popup dialog for adding an existing class to the system.
				create l_choose_dialog.make
				l_choose_dialog.show_on_active_window
				if l_choose_dialog.selected then
					l_class_name := l_choose_dialog.class_name
					l_class_i_list := tool.system.universe.classes_with_name (l_class_name)
					if l_class_i_list.count = 1 then
						l_class_i := l_class_i_list.i_th (1)
						if l_class_i /= Void then
							if tool.class_view /= Void then
								tool.class_view.add_to_diagram (l_class_i)
							elseif tool.cluster_view /= Void then
								tool.cluster_view.add_to_diagram (l_class_i)
							end
						end
					end
				end
			else
				if attached {CLASSI_STONE} tool.last_stone as l_class_i_stone then
					l_group ?= l_class_i_stone.group
				elseif attached {CLUSTER_STONE} tool.last_stone as l_cluster_stone then
					l_group ?= l_cluster_stone.group
				end
				if l_group /= Void and then not l_group.is_readonly then
					create dialog.make_default (tool.develop_window, False)
					dialog.preset_cluster (l_group)
					dialog.set_stone_when_finished
					dialog.call_default
				end
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Create a new toolbar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.set_menu_function (agent new_menu)

			Result.select_actions.force_extend (agent execute)
		end

	new_menu: EV_MENU
			-- Create dropdown menu for command mode.
		local
			l_check_menu_item: EV_CHECK_MENU_ITEM
		do
			create Result
			create l_check_menu_item.make_with_text (interface_names.l_diagram_new_class)

			if not add_existing_class then
				l_check_menu_item.enable_select
			end
			Result.extend (l_check_menu_item)
			l_check_menu_item.select_actions.extend (agent set_add_existing_class (False))
			create l_check_menu_item.make_with_text (interface_names.l_diagram_existing_class)
			if add_existing_class then
				l_check_menu_item.enable_select
			end
			Result.extend (l_check_menu_item)
			l_check_menu_item.select_actions.extend (agent set_add_existing_class (True))
		end

feature {NONE} -- Implementation

	set_add_existing_class (a_value: BOOLEAN)
			-- Set `add_existing_class' to `a_value' and adjust command accordingly.
		local
			l_sd_button: like new_sd_toolbar_item
			tt: STRING_GENERAL
		do
			add_existing_class := a_value
			if internal_managed_sd_toolbar_items /= Void then
				tt := tooltip.twin
				from
					internal_managed_sd_toolbar_items.start
				until
					internal_managed_sd_toolbar_items.after
				loop
					l_sd_button := internal_managed_sd_toolbar_items.item
					l_sd_button.set_pixel_buffer (pixel_buffer)
					l_sd_button.set_tooltip (tt)
					if is_sensitive then
						l_sd_button.enable_sensitive
					else
						l_sd_button.disable_sensitive
					end
					internal_managed_sd_toolbar_items.forth
				end
			end
		end

	add_existing_class: BOOLEAN
		-- Should command just add an existing class to the diagram?

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			if add_existing_class then
				Result := pixmaps.icon_pixmaps.new_class_icon
			else
				Result := pixmaps.icon_pixmaps.class_uncompiled_icon
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			if add_existing_class then
				Result := pixmaps.icon_pixmaps.new_class_icon_buffer
			else
				Result := pixmaps.icon_pixmaps.class_uncompiled_icon_buffer
			end
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			if add_existing_class then
				Result := Interface_names.l_diagram_existing_class
			else
				Result := Interface_names.l_diagram_new_class
			end
		end

	name: STRING = "Create_class"
			-- Name of the command. Used to store the command in the
			-- preferences.

	menu_name: STRING_GENERAL
			-- Menu name
		do
			Result := interface_names.m_create_new_class
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EB_CREATE_CLASS_DIAGRAM_COMMAND
