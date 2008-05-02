indexing
	description: "Information (EIS) tool UI."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INFORMATION_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [ES_EIS_TOOL_WIDGET]
		redefine
			make,
			internal_recycle,
			create_mini_tool_bar_items,
			show
		end

	ES_INFORMATION_TOOL_COMMANDER_I
		export
			{ES_TOOL} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create {ES_INFORMATION_TOOL}
	make

feature {NONE} -- Initialization

	make (a_window: like develop_window; a_tool: like tool_descriptor) is
			-- <Precursor>
		do
			Precursor {ES_DOCKABLE_TOOL_PANEL} (a_window, a_tool)
				-- Request EIS background visiting post project load.
			register_action (eiffel_project.manager.load_agents, agent request_eis_visit)
			register_action (eiffel_project.manager.compile_stop_agents, agent request_eis_visit)
		end

feature {NONE} -- User interface initialization

    build_tool_interface (a_widget: like create_widget) is
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
        local
        	l_session: like session_data
		do
			if {lt_observer: PROGRESS_OBSERVER}a_widget then
				eis_manager.add_observer (lt_observer)
			end
			if session_manager.is_service_available then
					-- Hook up events
				l_session := session_data
				on_session_value_changed_agent := agent on_session_value_changed
				l_session.value_changed_event.subscribe (on_session_value_changed_agent)

					-- Retrieve session data and set button states
				if {l_toggle: BOOLEAN_REF} l_session.value_or_default (auto_sweep_session_id, False) then
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
				-- Request EIS background visiting when focusing in.
			register_action (content.focus_in_actions, agent request_eis_visit)
		end

feature -- Basic operations

    show
            -- Show the tool, if possible
        do
        	Precursor
        	if is_visit_requested then
				auto_background_visiting
        	end
        end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle tool.
		do
			if is_initialized then
				if session_manager.is_service_available then
					if on_session_value_changed_agent /= Void then
						session_data.value_changed_event.unsubscribe (on_session_value_changed_agent)
					end
				end
			end
			if {lt_observer: PROGRESS_OBSERVER}user_widget then
				eis_manager.remove_observer (lt_observer)
			end
			user_widget.recycle
			Precursor {ES_DOCKABLE_TOOL_PANEL}
		end

feature {NONE} -- Event handlers

	on_session_value_changed (a_session: SESSION; a_id: STRING_8) is
			-- Called when the session changes
			--
			-- `a_session': Session object which the change occured in.
			-- `a_id': The identifier of the changed session value.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
		local
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			if a_id.is_equal (auto_sweep_session_id) then
				l_button := user_widget.auto_sweep_button
				if l_button /= Void then
					if {l_toggle: BOOLEAN_REF} a_session.value_or_default (a_id, False) then
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

feature {ES_EIS_TOOL_WIDGET} -- Event handlers

	sweep_now is
			-- On sweep now button selected.
		do
			if workbench.universe_defined then
				eis_manager.start_background_visitor
				is_visit_requested := False
			end
		ensure
			not_is_visit_requested: workbench.universe_defined implies not is_visit_requested
		end

	on_auto_sweep_button_selected (a_button: SD_TOOL_BAR_TOGGLE_BUTTON) is
			-- On auto sweep button selected
		require
			a_button_not_void: a_button /= Void
        local
        	l_session: like session_data
		do
			if session_manager.is_service_available then
				l_session := session_data
				if a_button.is_selected then
					l_session.set_value (True, auto_sweep_session_id)
				else
					l_session.set_value (False, auto_sweep_session_id)
				end
			end
		end

feature -- Operation

	refresh_list
			-- Refresh the entry list.
		do
			user_widget.refresh_list
		end

	request_eis_visit
			-- Reqest EIS background visiting to collect information into EIS storage.
		do
			is_visit_requested := True
			if shown then
				auto_background_visiting
			end
		end

feature {NONE} -- Factory

    create_widget: ES_EIS_TOOL_WIDGET
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result.make (Current)
		end

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		do
			--| No tool bar
		end

    create_mini_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display on the window title
		local
			l_item: SD_TOOL_BAR_BUTTON
        do
  			create Result.make_default
  			create l_item.make
  			l_item.set_pixel_buffer (pixmaps.mini_pixmaps.general_search_icon_buffer)
  			l_item.set_tooltip (interface_names.e_show_class_cluster)
  			l_item.select_actions.extend (agent user_widget.on_show_editing_item)
  			Result.put_last (l_item)
        end

feature {NONE} -- Implementation

	is_visit_requested: BOOLEAN
			-- Is backgroud visiting requested?
			
	on_session_value_changed_agent: PROCEDURE [ANY, TUPLE [SESSION_I, STRING_8]]
				-- Agent created in `build_tool_interface'

	auto_background_visiting is
			-- Auto background visiting
        local
        	l_session: like session_data
		do
			if session_manager.is_service_available and then workbench.universe_defined then
				l_session := session_data
				if {lt_auto: BOOLEAN_REF} l_session.value_or_default (auto_sweep_session_id, False) then
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

feature {NONE} -- Constants

	auto_sweep_session_id: !STRING = "com.eiffel.eis_tool.auto_sweep";
			-- Session IDs

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
