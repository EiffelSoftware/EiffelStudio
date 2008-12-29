note
	description: "Panels used in metric tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_PANEL

inherit
	EB_METRIC_SHARED

	EV_SHARED_APPLICATION

	EB_METRIC_INTERFACE_PROVIDER

	EB_METRIC_TOOL_INTERFACE

	EB_RECYCLABLE

	EB_METRIC_ACTIONS

feature -- Actions

	on_project_loaded
			-- Action to be performed when project loaded
		deferred
		end

	on_project_unloaded
			-- Action to be performed when project unloaded
		deferred
		end

	on_compile_start
			-- Action to be performed when Eiffel compilation starts
		deferred
		end

	on_compile_stop
			-- Action to be performed when Eiffel compilation stops
		deferred
		end

	on_metric_evaluation_start (a_data: ANY)
			-- Action to be performed when metric evaluation starts
			-- `a_data' can be the metric tool panel from which metric evaluation starts.
		deferred
		end

	on_metric_evaluation_stop (a_data: ANY)
			-- Action to be performed when metric evaluation stops
			-- `a_data' can be the metric tool panel from which metric evaluation stops.
		deferred
		end

	on_archive_calculation_start (a_data: ANY)
			-- Action to be performed when metric archive calculation starts
			-- `a_data' can be the metric tool panel from which metric archive calculation starts.
		deferred
		end

	on_archive_calculation_stop (a_data: ANY)
			-- Action to be performed when metric archive calculation stops
			-- `a_data' can be the metric tool panel from which metric archive calculation stops.
		deferred
		end

	on_metric_loaded
			-- Action to be performed when metrics loaded in `metric_manager'
		deferred
		end

	on_history_recalculation_start (a_data: ANY)
			-- Action to be performed when archive history recalculation starts
			-- `a_data' can be the metric tool panel from which metric history recalculation starts.
		deferred
		end

	on_history_recalculation_stop (a_data: ANY)
			-- Action to be performed when archive history recalculation stops
			-- `a_data' can be the metric tool panel from which metric history recalculation stops.
		deferred
		end

	on_metric_sent_to_history (a_archive: EB_METRIC_ARCHIVE_NODE; a_panel: ANY)
			-- Action to be performed when metric calculation information contained in `a_archive' has been sent to history
		require
			a_archive_attached: a_archive /= Void
		deferred
		end

	on_metric_sent_to_history_agent: PROCEDURE [ANY, TUPLE [EB_METRIC_ARCHIVE_NODE, ANY]]
			-- Agent of `on_metric_sent_to_history'		
		do
			if on_metric_sent_to_history_agent_internal = Void then
				on_metric_sent_to_history_agent_internal := agent on_metric_sent_to_history
			end
			Result := on_metric_sent_to_history_agent_internal
		end

feature -- Status report

	is_eiffel_compiling: BOOLEAN
			-- Is eiffel compiling?
		do
			Result := metric_tool.is_eiffel_compiling
		end

	is_metric_evaluating: BOOLEAN
			-- Is metric being evaluated?
		do
			Result := metric_tool.is_metric_evaluating
		end

	is_metric_reloaded: BOOLEAN
			-- Is metric reloaded, and current panel hasn't updated?

	is_archive_calculating: BOOLEAN
			-- Is metric archive being calculated?
		do
			Result := metric_tool.is_archive_calculating
		end

	is_project_loaded: BOOLEAN
			-- Is a project loaded?
		do
			Result := metric_tool.is_project_loaded
		end

	is_history_recalculationg_running: BOOLEAN
			-- Is history recalculation running?
		do
			Result := metric_tool.is_history_recalculation_running
		end

	last_metric_value_historyed: BOOLEAN
			-- Has last calculated metric been sent to history?
		do
			Result := metric_tool.last_metric_value_historied
		end

feature -- Status report

	is_up_to_date: BOOLEAN
			-- Is current panel up-to-date?

	is_selected: BOOLEAN
			-- Is current panel selected?

feature -- Basic operations

	set_is_up_to_date (b: BOOLEAN)
			-- Set `is_up_to_date' with `b'.
		do
			is_up_to_date := b
		ensure
			is_up_to_date_set: is_up_to_date = b
		end

	set_is_selected (b: BOOLEAN)
			-- Set `is_selected' with `b'.
		do
			is_selected := b
		ensure
			is_selected_set: is_selected = b
		end

	set_is_metric_reloaded (b: BOOLEAN)
			-- Set `is_metric_loaded' with `b'.
		do
			is_metric_reloaded := b
		ensure
			is_metric_reloaded_set: is_metric_reloaded = b
		end

	force_drop_stone (a_stone: STONE)
			-- Force to drop `a_stone' in Current panel.
		require
			a_stone_attached: a_stone /= Void
		deferred
		end

	install_metric_history_agent
			-- Install actions related to metric history manipulation.
		local
			l_tool: like metric_tool
		do
			l_tool := metric_tool
			if not metric_tool.send_metric_value_in_history_actions.has (on_metric_sent_to_history_agent) then
				l_tool.send_metric_value_in_history_actions.extend (on_metric_sent_to_history_agent)
			end
		end

	uninstall_metric_history_agent
			-- Uninstall actions related to metric history manipulation.
		local
			l_tool: like metric_tool
		do
			l_tool := metric_tool
			if l_tool.send_metric_value_in_history_actions.has (on_metric_sent_to_history_agent) then
				l_tool.send_metric_value_in_history_actions.prune_all (on_metric_sent_to_history_agent)
			end
		end

feature -- Actions

	on_select
			-- Action to be performed when current panel is selected
		do
			update_ui
		ensure
			is_up_to_date: is_up_to_date
		end

	on_process_gui (a_item: QL_ITEM)
			-- Action to be performed to process gui events
		local
			l_message: STRING_GENERAL
		do
			ev_application.process_events
			if not metric_manager.is_exit_requested then
				if a_item /= Void then
					l_message := metric_names.e_evaluating.twin
					l_message.append (a_item.path.as_string_32)
					display_status_message (l_message)
				end
			else
				metric_manager.terminate_evaluation
			end
		end

	on_unit_order_change
			-- Action to ber performed when unit order changes
		do
			set_is_metric_reloaded (True)
			set_is_up_to_date (False)
			update_ui
		end

	on_unit_order_change_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_unit_order_change'

feature -- Pick and drop

	drop_pebble (a_pebble: ANY)
			-- Action to be performed when `a_pebble' is dropped
		local
			l_feature_stone: FEATURE_STONE
			l_class_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
		do
			l_feature_stone ?= a_pebble
			if l_feature_stone /= Void then
				drop_feature (l_feature_stone, metric_tool)
			else
				l_class_stone ?= a_pebble
				if l_class_stone /= Void then
					drop_class (l_class_stone, metric_tool)
				else
					l_cluster_stone ?= a_pebble
					if l_cluster_stone /= Void then
						drop_cluster (l_cluster_stone, metric_tool)
					end
				end
			end
		end

feature{NONE} -- Implementation

	display_status_message (a_msg: STRING_GENERAL)
			-- Display `a_msg' in message bar.
		require
			a_msg_attached: a_msg /= Void
		do
			if metric_tool /= Void and then metric_tool.develop_window /= Void and then metric_tool.develop_window.status_bar /= Void then
				metric_tool.develop_window.status_bar.display_message (a_msg)
			end
		end

	display_error_message
			-- Display last error message in `metric_manager'.
		do
			metric_tool.display_error_message
		end

	display_message (a_message: STRING_GENERAL)
			-- Display `a_message' in a prompt-out information dialog.
		require
			a_message_attached: a_message /= Void
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (a_message, metric_tool_window, Void)
		end

	update_ui
			-- Update interface
		deferred
		ensure
			ui_updated: is_selected implies is_up_to_date
		end

	on_metric_sent_to_history_agent_internal: like on_metric_sent_to_history_agent;
			-- Implementation of `on_metric_sent_to_history_agent'

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
