indexing
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

	on_project_loaded is
			-- Action to be performed when project loaded
		deferred
		end

	on_project_unloaded is
			-- Action to be performed when project unloaded
		deferred
		end

	on_compile_start is
			-- Action to be performed when Eiffel compilation starts
		deferred
		end

	on_compile_stop is
			-- Action to be performed when Eiffel compilation stops
		deferred
		end

	on_metric_evaluation_start (a_data: ANY) is
			-- Action to be performed when metric evaluation starts
			-- `a_data' can be the metric tool panel from which metric evaluation starts.
		deferred
		end

	on_metric_evaluation_stop (a_data: ANY) is
			-- Action to be performed when metric evaluation stops
			-- `a_data' can be the metric tool panel from which metric evaluation stops.
		deferred
		end

	on_archive_calculation_start (a_data: ANY) is
			-- Action to be performed when metric archive calculation starts
			-- `a_data' can be the metric tool panel from which metric archive calculation starts.
		deferred
		end

	on_archive_calculation_stop (a_data: ANY) is
			-- Action to be performed when metric archive calculation stops
			-- `a_data' can be the metric tool panel from which metric archive calculation stops.
		deferred
		end

	on_metric_loaded is
			-- Action to be performed when metrics loaded in `metric_manager'
		deferred
		end

	on_history_recalculation_start (a_data: ANY) is
			-- Action to be performed when archive history recalculation starts
			-- `a_data' can be the metric tool panel from which metric history recalculation starts.
		deferred
		end

	on_history_recalculation_stop (a_data: ANY) is
			-- Action to be performed when archive history recalculation stops
			-- `a_data' can be the metric tool panel from which metric history recalculation stops.
		deferred
		end

	on_metric_sent_to_history (a_archive: EB_METRIC_ARCHIVE_NODE; a_panel: ANY) is
			-- Action to be performed when metric calculation information contained in `a_archive' has been sent to history
		require
			a_archive_attached: a_archive /= Void
		deferred
		end

	on_metric_sent_to_history_agent: PROCEDURE [ANY, TUPLE [EB_METRIC_ARCHIVE_NODE, ANY]] is
			-- Agent of `on_metric_sent_to_history'		
		do
			if on_metric_sent_to_history_agent_internal = Void then
				on_metric_sent_to_history_agent_internal := agent on_metric_sent_to_history
			end
			Result := on_metric_sent_to_history_agent_internal
		end

feature -- Status report

	is_eiffel_compiling: BOOLEAN is
			-- Is eiffel compiling?
		do
			Result := metric_tool.is_eiffel_compiling
		end

	is_metric_evaluating: BOOLEAN is
			-- Is metric being evaluated?
		do
			Result := metric_tool.is_metric_evaluating
		end

	is_metric_reloaded: BOOLEAN
			-- Is metric reloaded, and current panel hasn't updated?

	is_archive_calculating: BOOLEAN is
			-- Is metric archive being calculated?
		do
			Result := metric_tool.is_archive_calculating
		end

	is_project_loaded: BOOLEAN is
			-- Is a project loaded?
		do
			Result := metric_tool.is_project_loaded
		end

	is_history_recalculationg_running: BOOLEAN is
			-- Is history recalculation running?
		do
			Result := metric_tool.is_history_recalculation_running
		end

	last_metric_value_historyed: BOOLEAN is
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

	set_is_up_to_date (b: BOOLEAN) is
			-- Set `is_up_to_date' with `b'.
		do
			is_up_to_date := b
		ensure
			is_up_to_date_set: is_up_to_date = b
		end

	set_is_selected (b: BOOLEAN) is
			-- Set `is_selected' with `b'.
		do
			is_selected := b
		ensure
			is_selected_set: is_selected = b
		end

	set_is_metric_reloaded (b: BOOLEAN) is
			-- Set `is_metric_loaded' with `b'.
		do
			is_metric_reloaded := b
		ensure
			is_metric_reloaded_set: is_metric_reloaded = b
		end

	force_drop_stone (a_stone: STONE) is
			-- Force to drop `a_stone' in Current panel.
		require
			a_stone_attached: a_stone /= Void
		deferred
		end

	install_metric_history_agent is
			-- Install actions related to metric history manipulation.
		local
			l_tool: like metric_tool
		do
			l_tool := metric_tool
			if not metric_tool.send_metric_value_in_history_actions.has (on_metric_sent_to_history_agent) then
				l_tool.send_metric_value_in_history_actions.extend (on_metric_sent_to_history_agent)
			end
		end

	uninstall_metric_history_agent is
			-- Uninstall actions related to metric history manipulation.
		local
			l_tool: like metric_tool
		do
			l_tool := metric_tool
			if not l_tool.send_metric_value_in_history_actions.has (on_metric_sent_to_history_agent) then
				l_tool.send_metric_value_in_history_actions.extend (on_metric_sent_to_history_agent)
			end
		end

feature -- Actions

	on_select is
			-- Action to be performed when current panel is selected
		do
			update_ui
		ensure
			is_up_to_date: is_up_to_date
		end

	on_process_gui (a_item: QL_ITEM) is
			-- Action to be performed to process gui events
		do
			ev_application.process_events
			if not metric_manager.is_exit_requested then
				if a_item /= Void then
					display_status_message (metric_names.e_evaluating.as_string_32 + a_item.path)
				end
			else
				metric_manager.terminate_evaluation
			end
		end

	on_unit_order_change is
			-- Action to ber performed when unit order changes
		do
			set_is_metric_reloaded (True)
			set_is_up_to_date (False)
			update_ui
		end

	on_unit_order_change_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_unit_order_change'

feature -- Pick and drop

	drop_class (st: CLASSI_STONE) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
		local
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= st
			if conv_fst = Void then
				metric_tool.context_tool.launch_stone (st)
				metric_tool.context_tool.class_view.pop_default_formatter
			else
				-- The stone is already dropped through `drop_feature'.
			end
		end

	drop_feature (st: FEATURE_STONE) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
		do
			metric_tool.context_tool.launch_stone (st)
			metric_tool.context_tool.feature_view.pop_default_formatter
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Action to be performed when `st' is dropped on current panel.
		require
			st_valid: st /= Void
		do
			metric_tool.context_tool.launch_stone (st)
		end


feature{NONE} -- Implementation

	display_status_message (a_msg: STRING) is
			-- Display `a_msg' in message bar.
		require
			a_msg_attached: a_msg /= Void
		do
			if metric_tool /= Void and then metric_tool.development_window /= Void and then metric_tool.development_window.status_bar /= Void then
				metric_tool.development_window.status_bar.display_message (a_msg)
			end
		end

	display_error_message is
			-- Display last error message in `metric_manager'.
		do
			metric_tool.display_error_message
		end

	display_message (a_message: STRING_GENERAL) is
			-- Display `a_message' in a prompt-out information dialog.
		require
			a_message_attached: a_message /= Void
		local
			l_dialog: EV_INFORMATION_DIALOG
		do
			create l_dialog.make_with_text (a_message)
			l_dialog.set_buttons_and_actions (<<metric_names.t_ok>>, <<agent l_dialog.destroy>>)
			l_dialog.show_relative_to_window (metric_tool_window)
		end

	update_ui is
			-- Update interface
		deferred
		ensure
			ui_updated: is_selected implies is_up_to_date
		end

	on_metric_sent_to_history_agent_internal: like on_metric_sent_to_history_agent;
			-- Implementation of `on_metric_sent_to_history_agent'

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
