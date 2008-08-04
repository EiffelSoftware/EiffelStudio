indexing
	description: "Area in EB_CONTEXT_TOOL to display metrics calculation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_METRICS_TOOL_PANEL

inherit
	EB_TOOL
		redefine
			make,
			show,
			internal_recycle,
			close,
			attach_to_docking_manager
		end

	SHARED_WORKBENCH

	EB_METRIC_INTERFACE_PROVIDER

	EB_RECYCLER

	EB_METRIC_ACTIONS

	EB_METRIC_ACTION_SEQUENCES

	SHARED_EIFFEL_PROJECT

	EB_METRIC_TOOL_HELPER

create
	make

feature -- Initialization

	make (dw: EB_DEVELOPMENT_WINDOW; a_tool: like tool_descriptor) is
			-- Initialize `Current'.
		do
			develop_window := dw
			tool_descriptor := a_tool

			create widget
			create metric_notebook

			notify_project_unloaded_agent := agent notify_project_unloaded

			create metric_evaluation_panel.make (Current)
			create new_metric_panel.make (Current)
			create metric_archive_panel.make (Current)
			create detail_result_panel.make (Current)
			create metric_history_panel.make (Current)

			if not eiffel_project.manager.is_project_loaded then
				notify_project_loaded_agent := agent notify_project_loaded
				eiffel_project.manager.load_agents.extend (notify_project_loaded_agent)
			else
				notify_project_loaded
			end

			eiffel_project.manager.close_agents.extend (notify_project_unloaded_agent)

			metric_notebook.extend (metric_evaluation_panel)
			metric_notebook.extend (detail_result_panel)
			metric_notebook.extend (new_metric_panel)
			metric_notebook.extend (metric_history_panel)
			metric_notebook.extend (metric_archive_panel)

				-- Setup tab names			
			metric_notebook.set_item_text (metric_notebook.i_th (1), metric_names.t_evaluation_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (2), metric_names.t_detail_result_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (3), metric_names.t_definition_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (4), metric_names.t_history_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (5), metric_names.t_archive_tab)

			metric_notebook.selection_actions.extend (agent on_tab_change)
			metric_notebook.select_item (metric_evaluation_panel)
			metric_notebook.drop_actions.extend (agent on_tab_dropped)
			metric_notebook.drop_actions.set_veto_pebble_function (agent on_tab_droppable)
			widget.extend (metric_notebook)
			install_agents (metric_manager)
			if not window_manager.compile_start_actions.has (metric_manager.on_compile_start_agent) then
				window_manager.compile_start_actions.extend (metric_manager.on_compile_start_agent)
			end
		end

	attach_to_docking_manager (a_manager: SD_DOCKING_MANAGER) is
			-- <Precursor>
		do
			Precursor {EB_TOOL} (a_manager)
			content.show_actions.extend (agent on_select)
		end

	build_interface is
			-- <Precursor>
		do
		end

feature -- Actions

	on_select is
			-- Metric tool has been selected, synchronize.
		do
			if content.is_visible then
				if workbench.system_defined and then workbench.is_already_compiled then
					load_metrics_and_display_error (False, metric_names.t_loading_metrics)
				end
				set_is_shown (True)
				on_tab_change
				set_title (Void)
			end
		end

	on_deselect is
			-- Metric tool has been deselected.
		do
			set_is_shown (False)
			on_tab_change
		end

	on_send_metric_value_in_history (a_archive: EB_METRIC_ARCHIVE_NODE; a_panel: ANY) is
			-- Action to be performed to send last evaluated metric value (stored in `a_archive') in history
			-- `a_panel' is the metric tool panel from which the sending request occurs.
		require
			a_archive_attached: a_archive /= Void
		do
			set_last_metric_value_historied (True)
			send_metric_value_in_history_actions.call ([a_archive, a_panel])
		end

	show is
			-- <Precursor>
		do
			Precursor {EB_TOOL}
			on_select
		end

	close is
			-- <Precursor>
		do
			Precursor {EB_TOOL}
			on_deselect
		end

feature -- Basic operations

	go_to_definition (a_metric: EB_METRIC; a_new: BOOLEAN) is
			-- Go to definition panel of metric named `a_name'.
			-- `a_new' is True indicates that `a_metric' is a new metric from quick metric definition.
		require
			a_metric_attached: a_metric /= Void
			nod_a_new_implies_a_metric_exists: not a_new implies metric_manager.has_metric (a_metric.name)
		do
			metric_notebook.select_item (new_metric_panel)
			if a_new then
				new_metric_panel.metric_selector.remove_selection
				new_metric_panel.load_metric_definition (a_metric, new_metric_panel.basic_metric_type, a_metric.unit, True)
			else
				new_metric_panel.metric_selector.select_metric (a_metric.name)
			end
		end

	go_to_result is
			-- Go to result tab.
		local
			l_notebook: EV_NOTEBOOK
		do
			l_notebook := metric_notebook
			if l_notebook.selected_item /= detail_result_panel then
				l_notebook.select_item (detail_result_panel)
			end
		end

	load_metrics_and_display_error (a_force: BOOLEAN; a_msg: STRING_GENERAL) is
			-- Load metrics if they are not already loaded.
			-- If `a_force' is True, load metrics even though they are already loaded.
			-- When loading metrics, `a_msg' will be displayed in a dialog.
			-- Error will be displayed if any.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			load_metrics (a_force, a_msg, develop_window)
			display_error_message
		end

	register_metric_result_for_display (a_metric: EB_METRIC; a_input: EB_METRIC_DOMAIN; a_value: DOUBLE; a_result: QL_DOMAIN; a_time: DATE_TIME; a_from_history: BOOLEAN; a_filtered: BOOLEAN) is
			-- Register metric result for display.
		require
			a_metric_attached: a_metric /= Void
			a_input_attached: a_input /= Void
			a_time_attached: a_time /= Void
		do
			detail_result_panel.on_display_metric_value (a_metric, a_value, a_input, a_result, a_time, a_from_history, a_filtered)
		end

	register_archive_result_for_display (ref_archive, cur_archive: LIST [EB_METRIC_ARCHIVE_NODE]) is
			-- Register metric archive for display.
		require
			archives_valid: not (ref_archive = Void and then cur_archive = Void)
		do
			detail_result_panel.on_display_archive_value (cur_archive, ref_archive)
		end

	store_metrics is
			-- Store metrics.
		do
			metric_manager.store_userdefined_metrics
			display_error_message
			check_metric_validation (develop_window)
			metric_loaded_actions.call (Void)
			metric_manager.metric_loaded_actions.call (Void)
		end

	display_error_message is
			-- Display error message from `metric_manager'.
		do
			if not metric_manager.is_exit_requested then
				if metric_manager.has_error then
					show_error_message (agent metric_manager.last_error, agent metric_manager.clear_last_error, develop_window.window)
				end
			end
		end

	set_focus is
			-- Give the focus to the metrics.
		do
		end

	set_is_shown (b: BOOLEAN) is
			-- Set `is_shown' with `b'.
		do
			is_shown := b
		ensure
			is_shown_set: is_shown = b
		end

	set_last_metric_value_historied (b: BOOLEAN) is
			-- Set `last_metric_value_historied' with `b'.
		do
			last_metric_value_historied := b
		ensure
			last_metric_value_historied_set: last_metric_value_historied = b
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'

	metric_evaluation_panel: EB_METRIC_EVALUATION_PANEL
			-- Metric evaluation panel

	new_metric_panel: EB_NEW_METRIC_PANEL
			-- New metric panel

	detail_result_panel: EB_METRIC_RESULT_AREA
			-- Detailed result panel

	metric_archive_panel: EB_METRIC_ARCHIVE_PANEL
			-- Metric archive panel

	metric_history_panel: EB_METRIC_HISTORY_PANEL
			-- Metric history panel

	metric_notebook: EV_NOTEBOOK
			-- Notebook for metric tool panels

	send_metric_value_in_history_actions: ACTION_SEQUENCE [TUPLE [a_archive: EB_METRIC_ARCHIVE_NODE; a_panel: ANY]] is
			-- Actions to be performed when last evalauted metric (stored in `a_archive') has been sent into history
			-- `a_panel' is the metric tool panel from which the sending request occurs.			
		do
			if send_metric_value_in_history_actions_internal = Void then
				create send_metric_value_in_history_actions_internal
			end
			Result := send_metric_value_in_history_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Remove all references to `Current', and leave `Current' in an
			-- unstable state, so that we know `Current' is not referenced any longer.
		do
			metric_evaluation_panel.recycle
			new_metric_panel.recycle
			metric_archive_panel.recycle
			detail_result_panel.recycle
			metric_history_panel.recycle

			metric_evaluation_panel := Void
			new_metric_panel := Void
			metric_archive_panel := Void
			detail_result_panel := Void
			metric_history_panel := Void
			uninstall_agents (metric_manager)
			if notify_project_loaded_agent /= Void then
				eiffel_project.manager.load_agents.prune_all (notify_project_loaded_agent)
			end
			eiffel_project.manager.close_agents.prune_all (notify_project_unloaded_agent)
			Precursor {EB_TOOL}
		end

feature -- Status report

	is_shown: BOOLEAN
			-- Is `Current' currently displayed in the context tool?

	is_metrics_loaded: BOOLEAN
			-- Have predefined and user-defined metrics been loaded from files?

	is_up_to_date: BOOLEAN
			-- Is interface of metric tool up-to-date?

	is_recompiled: BOOLEAN
			-- Has system been recompiled?

	is_eiffel_compiling: BOOLEAN is
			-- Is eiffel compiling?
		do
			Result := metric_manager.is_eiffel_compiling
		end

	is_metric_evaluating: BOOLEAN is
			-- Is metric being evaluated?
		do
			Result := metric_manager.is_metric_evaluating
		end

	is_archive_calculating: BOOLEAN is
			-- Is metric archive being calculated?
		do
			Result := metric_manager.is_archive_calculating
		end

	is_project_loaded: BOOLEAN is
			-- Is a project loaded?		
		do
			Result := metric_manager.is_project_loaded
		end

	is_history_recalculation_running: BOOLEAN is
			-- Is metric history recalculation running?
		do
			Result := metric_manager.is_history_recalculation_running
		end

	last_metric_value_historied: BOOLEAN
			-- Has last evaluated metric value been sent to history?

	is_ready: BOOLEAN is
			-- Is Metrics tool ready?
			-- Ready means that a project is loaded and no compilation or metric calculation is undergoing, so a new metric calculation
			-- can start.
		do
			Result := is_project_loaded and then not (is_eiffel_compiling or is_metric_evaluating or is_archive_calculating or is_history_recalculation_running)
		end

feature{NONE} -- Actions

	on_tab_change is
			-- Action to be performed when selected tab changes
		local
			l_selected_index: INTEGER
			l_notebook: EV_NOTEBOOK
			l_panel: EB_METRIC_PANEL
			i: INTEGER
			l_notebook_count: INTEGER
		do
			from
				l_notebook := metric_notebook
				l_selected_index := l_notebook.selected_item_index
				i := 1
				l_notebook_count := l_notebook.count
			until
				i > l_notebook_count
			loop
				l_panel ?= l_notebook @ i
				check l_panel /= Void end
				if is_shown and then i = l_selected_index then
					l_panel.set_is_selected (True)
					l_panel.on_select
				else
					l_panel.set_is_selected (False)
				end
				i := i + 1
			end
		end

	on_project_loaded is
			-- Action to be performed when project loaded
		do
			if content.user_widget.is_displayed then
				set_is_shown (True)
			end
			on_tab_change
			project_load_actions.call (Void)
		end

	on_project_unloaded is
			-- Action to be performed when project unloaded
		do
			project_unload_actions.call (Void)
		end

	on_compile_start is
			-- Action to be performed when Eiffel compilation starts
		do
			compile_start_actions.call (Void)
		end

	on_compile_stop is
			-- Action to be performed when Eiffel compilation stops
		do
			is_metric_validation_checked.put (False)
			compile_stop_actions.call (Void)
		end

	on_metric_evaluation_start (a_data: ANY) is
			-- Action to be performed when metric evaluation starts
			-- `a_data' can be the metric tool panel from which metric evaluation starts.
		do
			metric_evaluation_start_actions.call ([a_data])
		end

	on_metric_evaluation_stop (a_data: ANY) is
			-- Action to be performed when metric evaluation stops
			-- `a_data' can be the metric tool panel from which metric evaluation stops.
		do
			set_last_metric_value_historied (False)
			metric_evaluation_stop_actions.call ([a_data])
		end

	on_archive_calculation_start (a_data: ANY) is
			-- Action to be performed when metric archive calculation starts
			-- `a_data' can be the metric tool panel from which metric archive calculation starts.
		do
			archive_calculation_start_actions.call ([a_data])
		end

	on_archive_calculation_stop (a_data: ANY) is
			-- Action to be performed when metric archive calculation stops
			-- `a_data' can be the metric tool panel from which metric archive calculation stops.
		do
			archive_calculation_stop_actions.call ([a_data])
		end

	on_metric_loaded is
			-- Action to be performed when metrics loaded in `metric_manager'
		do
			metric_loaded_actions.call (Void)
		end

	on_tab_droppable (a_pebble: ANY): BOOLEAN is
			-- Function to decide if `a_pebble' can be dropped on a `metric_notebook' tab
		local
			l_stone: STONE
			l_tab_index: INTEGER
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_tab_index := metric_notebook.pointed_tab_index
				if l_tab_index > 0 then
					if metric_notebook.i_th (l_tab_index) = metric_evaluation_panel then
						Result := is_project_loaded and then not is_archive_calculating and then not is_metric_evaluating
					elseif metric_notebook.i_th (l_tab_index) = metric_archive_panel then
						Result := is_project_loaded and then not is_archive_calculating and then not is_metric_evaluating
					end
				end
			end
		end

	on_tab_dropped (a_pebble: ANY) is
			-- Action called when `a_pebble' is dropped on `metric_notebook'.
			-- It will target current to `a_pebble'.
		local
			l_stone: STONE
			l_tab_index: INTEGER
			l_panel: EB_METRIC_PANEL
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_tab_index := metric_notebook.pointed_tab_index
				if l_tab_index > 0 then
					l_panel ?= metric_notebook.i_th (l_tab_index)
					check l_panel /= Void end
					l_panel.force_drop_stone (l_stone)
				end
			end
		end

	on_history_recalculation_start (a_data: ANY) is
			-- Action to be performed when history recalculation starts
			-- `a_data' can be the metric tool panel from which history recalculation starts.
		do
			history_recalculation_start_actions.call ([a_data])
		end

	on_history_recalculation_stop (a_data: ANY) is
			-- Action to be performed when history recalculation stops
			-- `a_data' can be the metric tool panel from which history recalculation stops.
		do
			history_recalculation_stop_actions.call ([a_data])
		end

	on_metric_renamed (a_old_name, a_new_name: STRING) is
			-- Action to be performed when a metric with `a_old_name' has been renamed to `a_new_name'.
		do
			metric_renamed_actions.call ([a_old_name, a_new_name])
		end

feature{NONE} -- Implementation

	send_metric_value_in_history_actions_internal: like send_metric_value_in_history_actions;
		-- Implementation of `send_metric_value_in_history_actions'

	notify_project_loaded is
			-- Notify `metric_manager' that project has been loaded.
		do
			if not metric_manager.is_project_loaded then
				metric_manager.on_project_loaded
			end
		end

	notify_project_unloaded is
			-- Notify `metric_manager' that project has been unloaded.
		do
			if metric_manager.is_project_loaded then
				metric_manager.on_project_unloaded
			end
		end

	notify_project_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `notify_project_loaded'

	notify_project_unloaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `notify_project_unloaded'

feature{EB_METRIC_EVALUATION_PANEL} -- Title change

	is_tool_opened: BOOLEAN is
			-- Is Current tool opened?
		do
			Result := content.is_visible
		end

	is_tool_visible: BOOLEAN is
			-- Is Current tool visible?
		do
			Result := widget.is_displayed
		end

	set_title (a_result: STRING_GENERAL) is
			-- Set title of Current tool.
			-- If `a_result' is not Void, display it on title.
		local
			l_name: STRING_32
		do
			l_name := interface_names.t_metric_tool.as_string_32
			if is_tool_opened and then not is_tool_visible then
				if a_result /= Void then
					l_name.append (ti_l_parenthesis.as_string_32)
					l_name.append (a_result.as_string_32)
					l_name.append (ti_r_parenthesis.as_string_32)
				end
			end
			content.set_short_title (l_name)
		end

invariant
	notify_project_unloaded_agent_attached: notify_project_unloaded_agent /= Void

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

end -- class EB_METRIC_TOOL
