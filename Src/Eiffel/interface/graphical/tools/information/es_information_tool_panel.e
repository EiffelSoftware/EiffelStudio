note
	description: "Information (EIS) tool UI."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INFORMATION_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [ES_EIS_TOOL_WIDGET]
		redefine
			on_after_initialized,
			internal_recycle,
			on_show,
			on_focus_in,
			create_mini_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_INFORMATION_TOOL_COMMANDER_I
		export
			{ES_INFORMATION_TOOL_COMMANDER_I} all
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

--inhert {NONE}
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create {ES_INFORMATION_TOOL}
	make

feature {NONE} -- Initialization

    build_tool_interface (a_widget: like user_widget)
            -- <Precursor>
		do
			if attached {PROGRESS_OBSERVER} a_widget as lt_observer then
				eis_manager.add_observer (lt_observer)
			end

			if attached session_manager.service then
					-- Retrieve session data and set button states
				if attached {BOOLEAN_REF} session_data.value_or_default (auto_sweep_session_id, False) as l_toggle then
					if l_toggle.item then
						a_widget.auto_sweep_button.enable_select
					else
						a_widget.auto_sweep_button.disable_select
					end
				else
						-- Default to selected.
					a_widget.auto_sweep_button.enable_select
				end
			end
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}

			if attached session_manager.service then
				session_data.session_connection.connect_events (Current)
			end

				-- Request EIS background visiting post project load.
			if eiffel_project.manager.is_project_loaded then
				request_eis_visit
			else
				register_action (eiffel_project.manager.load_agents, agent request_eis_visit)
			end

			register_action (eiffel_project.manager.compile_stop_agents, agent (s: like {WORKBENCH_I}.compilation_status) do request_eis_visit end)

				-- Request EIS background visiting when focusing in.
			register_action (content.focus_in_actions, agent request_eis_visit)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if
				is_initialized and then
				attached session_manager.service as s and then
				session_data.session_connection.is_connected (Current)
			then
				session_data.session_connection.disconnect_events (Current)
			end
			if attached {PROGRESS_OBSERVER} user_widget as lt_observer then
				eis_manager.remove_observer (lt_observer)
			end
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "26E2C799-B48A-C588-CDF1-DD47B1994B09"
		end

feature {NONE} -- Status report

	is_visit_requested: BOOLEAN
			-- Is backgroud visiting requested?

feature {ES_INFORMATION_TOOL_COMMANDER_I, ES_EIS_TOOL_WIDGET} -- Basic operations

	refresh_list
			-- Refresh the entry list.
		local
			l_agent: like refresh_list_agent
		do
			if not is_initialized then
				initialize
			end
			l_agent := refresh_list_agent
			if l_agent = Void then
				l_agent := agent user_widget.refresh_list
				refresh_list_agent := l_agent
			end
			execute_until_shown (l_agent)
		end

	request_eis_visit
			-- Request EIS background visiting to collect information into EIS storage.
		do
			is_visit_requested := True
			if is_shown then
				perform_auto_background_visiting
			end
		end

	add_information_to (a_stone: ANY)
			-- Add information to `a_stone'.
		do
			if attached {STONE} a_stone as l_stone then
				user_widget.target_stone (l_stone)
				if user_widget.last_stone_targeted then
					show
					user_widget.add_new_entry_for_stone (l_stone)
				else
					prompts.show_warning_prompt (Warning_messages.w_Could_not_locate (l_stone.stone_signature), develop_window.window, Void)
				end
			end
		end

	reset_stone
			-- Reset current targeted stone
		do
			set_stone (Void)
		end

	class_entries (a_classi: CLASS_I): SEARCH_TABLE [EIS_ENTRY]
			-- EIS entries corresponding to `a_classi'
		local
			l_extractor: ES_EIS_CLASS_EXTRACTOR
		do
			create l_extractor.make (a_classi, True)
			Result := l_extractor.eis_entries
		end

feature {NONE} -- Basic operations

	perform_auto_background_visiting
			-- Auto background visiting (DONT REPEAT THE NAME AS A COMMENT, let me know what it does!)
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
        local
        	l_session: like session_data
		do
			if attached session_manager.service and then workbench.universe_defined then
				l_session := session_data
				if attached {BOOLEAN_REF} l_session.value_or_default (auto_sweep_session_id, False) as lt_auto then
					if lt_auto.item then
						if eis_manager.full_visited then
							eis_manager.start_background_visitor
						end
					end
				end
			end
			is_visit_requested := False
		ensure
			not_is_visit_requested: not is_visit_requested
		end

feature {NONE} -- Event handlers

	on_session_value_changed (a_session: SESSION; a_id: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			if a_id.same_string (auto_sweep_session_id) then
				l_button := user_widget.auto_sweep_button
				if l_button /= Void then
					if attached {BOOLEAN_REF} a_session.value_or_default (a_id, False) as l_toggle then
						l_button.select_actions.block
						if l_toggle.item then
							l_button.enable_select
						else
							l_button.disable_select
						end
						l_button.select_actions.resume
					end
				end
			end
		end

feature {NONE} -- Action handlers

	on_show
			-- <Precusor>
		do
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
			if is_visit_requested then
				perform_auto_background_visiting
			end
		end

	on_focus_in
		do
			Precursor
			user_widget.tree.set_focus
		end

feature {ES_EIS_TOOL_WIDGET} -- Actions handlers

	on_sweep_now
			-- On sweep now button selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if workbench.universe_defined then
				eis_manager.start_background_visitor
				is_visit_requested := False
			end
		ensure
			not_is_visit_requested: workbench.universe_defined implies not is_visit_requested
		end

	on_auto_sweep_button_selected (a_button: SD_TOOL_BAR_TOGGLE_BUTTON)
			-- On auto sweep button selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_button_not_void: a_button /= Void
        local
        	l_session: like session_data
		do
			if attached session_manager.service then
				l_session := session_data
				if a_button.is_selected then
					l_session.set_value (True, auto_sweep_session_id)
				else
					l_session.set_value (False, auto_sweep_session_id)
				end
			end
		end

feature {NONE} -- Stone handler

	on_stone_changed (a_old_stone: detachable like stone)
			-- Assign `a_stone' as new stone.
		do
			user_widget.target_stone (stone)
		end

feature {NONE} -- Factory

    create_widget: ES_EIS_TOOL_WIDGET
            -- <Precursor>
		do
			create Result.make (Current)
		end

    create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- <Precursor>
		do
			--| No tool bar
		end

    create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- <Precursor>
		local
			l_item: SD_TOOL_BAR_BUTTON
        do
  			create Result.make (1)
  			create l_item.make
  			l_item.set_pixel_buffer (pixmaps.mini_pixmaps.general_search_icon_buffer)
  			l_item.set_tooltip (interface_names.e_show_class_cluster)
  			l_item.select_actions.extend (agent user_widget.on_show_editing_item)
  			register_action (l_item.drop_actions, agent user_widget.target_stone)
  			Result.extend (l_item)
        end

feature {NONE} -- Constants

	auto_sweep_session_id: STRING = "com.eiffel.eis_tool.auto_sweep";
			-- Session IDs

feature {NONE} -- Access

	refresh_list_agent: detachable PROCEDURE;
			-- Agent of `user_widget.refresh_list'

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
