note
	description: "Tool that displays SCM information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_show,
			create_mini_tool_bar_items
		end

	SCM_OBSERVER
		redefine
			on_workspace_updated,
			on_configuration_updated,
			on_changelist_updated,
			on_statuses_updated
		end

	SHARED_SOURCE_CONTROL_MANAGEMENT_SERVICE

	SHARED_SCM_NAMES

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	EB_VETO_FACTORY

create
	make

feature {NONE} -- Initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		do
			main_box := a_widget
			if attached scm_s.service as scm then
				scm.register_observer (Current)
				scm.check_scm_availability
			end
			update
		end

feature -- Widgets

	main_box: EV_VERTICAL_BOX

feature -- Status

	is_scm_available: BOOLEAN

feature -- Operations

	update
		do
			refresh
		end

feature {NONE} -- Factory		

	create_widget: EV_VERTICAL_BOX
			-- Create a new container widget upon request.
			-- Note: You may build the tool elements here or in build_tool_interface
			-- (export status {NONE})
		do
			create Result
			Result.set_border_width (layout_constants.default_border_size)
			Result.set_padding_width (layout_constants.default_padding_size)
		end

    create_mini_tool_bar_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		local
			togb: SD_TOOL_BAR_TOGGLE_BUTTON
			but: SD_TOOL_BAR_BUTTON
        do
        	create Result.make (2)

        	create togb.make
        	togb.set_text (scm_names.button_project)
        	togb.set_tooltip (scm_names.tooltip_button_project)
        	togb.select_actions.extend (agent on_setup_selected)
        	Result.extend (togb)
        	toggle_button_setup := togb

        	create but.make
			but.set_text (scm_names.button_config)
			but.set_pixmap (pixmaps.icon_pixmaps.tool_preferences_icon)
			but.set_pixel_buffer (pixmaps.icon_pixmaps.tool_preferences_icon_buffer)
        	but.set_tooltip (scm_names.tooltip_button_config)
        	but.select_actions.extend (agent on_preferences_selected)
        	Result.extend (but)

        end

    create_tool_bar_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		local
--			but: SD_TOOL_BAR_TOGGLE_BUTTON
        do
--       	
--        	create but.make
--        	but.set_text (interface_names.b_advanced)
--        	but.select_actions.extend (agent on_advanced_event (but))

--        	create Result.make (1)
--        	Result.extend (but)
        end

feature -- Widgets

	toggle_button_setup: detachable SD_TOOL_BAR_TOGGLE_BUTTON

	setup_box: detachable SCM_SETUP_BOX

	status_box: detachable SCM_STATUS_BOX

	is_status_mode: BOOLEAN
		do
			Result := not is_setup_mode
		end

	is_setup_mode: BOOLEAN

feature -- Change

	set_setup_mode
		do
			is_setup_mode := True
		end

	set_status_mode
		do
			is_setup_mode := False
		end

feature {NONE} -- Action handlers

	on_workspace_updated (ws: detachable SCM_WORKSPACE)
		do
			if attached status_box as l_status then
				if ws /= Void then
					l_status.set_workspace (ws)
				else
					l_status.reset
				end
			end
			if attached setup_box as l_setup then
				if ws /= Void then
					l_setup.set_workspace (ws)
				else
					l_setup.reset
				end
			end
			update_associated_interface_elements
		end

	on_configuration_updated (cfg: SCM_CONFIG)
		local
			l_status: SCM_STATUS_BOX
		do
			l_status := status_box
			if l_status /= Void then
				l_status.on_configuration_updated
			end
			update_associated_interface_elements
		end

	on_changelist_updated (ch: SCM_CHANGELIST_COLLECTION)
		local
			l_status: SCM_STATUS_BOX
		do
			l_status := status_box
			if
				l_status /= Void and then
				attached l_status.active_changelist_name as l_name and then
				l_name.same_string (ch.name)
			then
				l_status.on_changelist_selected (ch)
			end
		end

	on_statuses_updated (a_root: SCM_LOCATION; a_location: PATH; a_statuses: detachable SCM_STATUS_LIST)
		local
			l_status: SCM_STATUS_BOX
		do
			l_status := status_box
			if l_status /= Void then
				l_status.on_statuses_updated (a_root, a_location, a_statuses)
			end
			update_associated_interface_elements
		end

	on_setup_selected
		local
			b: like main_box
			l_setup: SCM_SETUP_BOX
			l_status: SCM_STATUS_BOX
		do
			b := main_box
			b.wipe_out
			if
				attached scm_s.service as scm and then
				attached scm.workspace as ws
			then
				if attached toggle_button_setup as tb and then tb.is_selected then
					set_setup_mode
					create l_setup
					setup_box := l_setup
					l_setup.set_workspace (ws)
					b.extend (l_setup)
					status_box := Void
				else
					set_status_mode
					create l_status.make (scm, develop_window)
					status_box := l_status
					l_status.set_workspace (ws)
					b.extend (l_status)
					setup_box := Void
				end
			else
				set_status_mode
				setup_box := Void
				status_box := Void
			end
		end

	on_preferences_selected
		local
			dlg: SCM_CONFIG_DIALOG
		do
			if attached scm_s.service as scm then
				create dlg.make (scm)
				dlg.show_on_active_window
			end
		end

	on_show
			-- Performs actions when the user widget is displayed.
		do
			Precursor
			if is_initialized then
				refresh
			end
		end

	refresh
		local
			b: like main_box
			l_status: SCM_STATUS_BOX
			l_setup: SCM_SETUP_BOX
			l_style: EV_POINTER_STYLE
			but: EV_BUTTON
			lab: EV_LABEL
			wlab: EVS_LABEL
			cl: EV_CELL
		do
			l_style := widget.pointer_style
			widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

			b := main_box
			b.wipe_out
			if attached scm_s.service as scm then
				if attached scm.workspace as ws then
					if is_status_mode then
						l_status := status_box
						if l_status = Void then
							create l_status.make (scm, develop_window)
							status_box := l_status
						end
						l_status.set_workspace (ws)
						b.extend (l_status)
					else
						l_setup := setup_box
						if l_setup = Void then
							create l_setup
							setup_box := l_setup
						end
						l_setup.set_workspace (ws)
						b.extend (l_setup)
					end
				else
					create wlab.make_with_text (scm_names.text_about_source_control_tool)
					wlab.set_is_text_ellipsed (False)
					wlab.set_minimum_width (100)
					wlab.set_is_text_wrapped (True)
					b.extend (wlab)
					b.disable_item_expand (wlab)

					create lab.make_with_text (scm_names.label_git_support_status (scm.is_git_available))
					b.extend (lab)
					b.disable_item_expand (lab)

					create lab.make_with_text (scm_names.label_svn_support_status (scm.is_svn_available))
					b.extend (lab)
					b.disable_item_expand (lab)

					create but.make_with_text_and_action (scm_names.button_config, agent on_preferences_selected)
					but.set_tooltip (scm_names.tooltip_button_config)
					b.extend (but)
					b.disable_item_expand (but)

					create but.make_with_text_and_action (scm_names.button_project, agent on_setup_selected)
					but.set_tooltip (scm_names.tooltip_button_project)
					b.extend (but)
					b.disable_item_expand (but)

					create but.make_with_text_and_action (interface_names.b_update, agent refresh)
					b.extend (but)
					b.disable_item_expand (but)

					create cl
					b.extend (cl)
				end
			else
				create lab.make_with_text ("Source control tool is not available.")
				b.extend (lab)
			end
			widget.set_pointer_style (l_style)
			update_associated_interface_elements
		end

	update_associated_interface_elements
		local
			w: EB_DEVELOPMENT_WINDOW
		do
			if attached Window_manager.development_windows as win_lst then
				across
					win_lst as ic
				loop
					w := ic.item
--					w.tools.scm_tool.update
					if attached w.source_control_cmd as cmd then
						cmd.refresh
					end
				end
			end
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "6109AFC3-43A4-4524-9ED8-C02B486CABAF"
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
