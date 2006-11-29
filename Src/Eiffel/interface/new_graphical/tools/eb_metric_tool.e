indexing
	description: "Area in EB_CONTEXT_TOOL to display metrics calculation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TOOL

inherit
	SHARED_WORKBENCH

	EB_RECYCLABLE

	QL_OBSERVABLE
		export
			{NONE} all
		end

	EB_METRIC_INTERFACE_PROVIDER

	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_project_loaded,
			on_project_unloaded
		end

	EB_RECYCLER

create
	make

feature -- Initialization

	make (dw: EB_DEVELOPMENT_WINDOW; ctxt_tl: EB_CONTEXT_TOOL) is
			-- Initialize `Current'.
		do
			development_window := dw
			context_tool := ctxt_tl
			create widget
			create metric_tool_interface.make (development_window, Current)
			widget.extend (metric_tool_interface)
			add_observer (metric_tool_interface.metric_evaluation_panel)
			add_observer (metric_tool_interface.new_metric_panel)
			add_observer (metric_tool_interface.metric_archive_panel)
			add_observer (metric_tool_interface.detail_result_panel)
			on_compile_start_agent := agent on_compile_start
			development_window.window_manager.compile_start_actions.extend (on_compile_start_agent)
			set_tool_sensitive (False)
			manager.add_observer (Current)
			create feedback_dialog
			feedback_dialog.set_buttons (<<>>)
		end

feature -- Actions

	on_select is
			-- Metric tool has been selected, synchronize.
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				is_shown := True
				if not is_compiling then
					if not is_validation_checked then
						check_metric_validation
						set_is_validation_checked (True)
					end
					synchronize_after_compilation
				end
			end
		end

	on_deselect is
			-- Metric tool has been deselected.
		do
			is_shown := False
		end

	on_compile_start is
			-- Action to be performed when Eiffel compilation starts
		do
			is_compiling := True
			set_changed
			notify (True)
		end

	on_project_loaded is
			-- A new project has been loaded.
		do
			set_tool_sensitive (True)
		end

	on_project_unloaded is
			-- Current project has been closed.
		do
			set_tool_sensitive (False)
		end

feature -- Basic operations

	go_to_definition (a_metric: EB_METRIC; a_new: BOOLEAN) is
			-- Go to definition panel of metric named `a_name'.
			-- `a_new' is True indicates that `a_metric' is a new metric from quick metric definition.
		require
			a_metric_attached: a_metric /= Void
			nod_a_new_implies_a_metric_exists: not a_new implies metric_manager.has_metric (a_metric.name)
		do
			if a_new then
				metric_tool_interface.new_metric_panel.metric_selector.remove_selection
				metric_tool_interface.new_metric_panel.load_metric_definition (a_metric, metric_tool_interface.new_metric_panel.basic_metric_type, a_metric.unit, True)
			else
				metric_tool_interface.new_metric_panel.metric_selector.select_metric (a_metric.name)
			end
			metric_tool_interface.metric_notebook.select_item (metric_tool_interface.new_metric_tab)
		end

	go_to_result is
			-- Go to result tab.
		local
			l_notebook: EV_NOTEBOOK
			l_result_panel_index: INTEGER
		do
			l_notebook := metric_tool_interface.metric_notebook
			l_result_panel_index := metric_tool_interface.metric_result_tab_index
			if l_notebook.selected_item_index = l_result_panel_index then
				metric_tool_interface.panel_table.item (l_result_panel_index).on_select
			else
				l_notebook.select_item (metric_tool_interface.result_tab)
			end
		end

	load_metrics (a_force: BOOLEAN; a_msg: STRING) is
			-- Load metrics is they are not already loaded.
			-- If `a_force' is True, load metrics even thought they are already loaded.
			-- When loading metrics, `a_msg' will be displayed in a dialog.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				if a_force or else not metric_manager.is_metric_loaded then
					show_feedback_dialog (a_msg, agent metric_manager.load_metrics, feedback_dialog, development_window.window)
					display_error_message
					check_metric_validation
					set_changed
					notify (Void)
				end
			end
		end

	check_metric_validation is
			-- Check metric validation.
		do
			development_window.window_manager.display_message (metric_names.t_checking_metric_vadility)
			metric_manager.check_validation (True)
			development_window.window_manager.display_message ("")
		end

	register_metric_result_for_display (a_metric: EB_METRIC; a_input: EB_METRIC_DOMAIN; a_value: DOUBLE; a_result: QL_DOMAIN) is
			-- Register metric result for display.
		require
			a_metric_attached: a_metric /= Void
			a_input_attached: a_input /= Void
		do
			metric_tool_interface.detail_result_panel.set_is_up_to_date (False)
			metric_tool_interface.detail_result_panel.enable_metric_result_display
			metric_tool_interface.detail_result_panel.set_last_metric (a_metric)
			metric_tool_interface.detail_result_panel.set_last_value (a_value)
			metric_tool_interface.detail_result_panel.set_last_source_domain (a_input)
			metric_tool_interface.detail_result_panel.set_last_result_domain (a_result)
		end

	register_archive_result_for_display (ref_archive, cur_archive: LIST [EB_METRIC_ARCHIVE_NODE]) is
			-- Register metric archive for display.
		require
			archives_valid: not (ref_archive = Void and then cur_archive = Void)
		do
			metric_tool_interface.detail_result_panel.set_is_up_to_date (False)
			metric_tool_interface.detail_result_panel.enable_archive_result_display
			metric_tool_interface.detail_result_panel.set_last_reference_archive (ref_archive)
			metric_tool_interface.detail_result_panel.set_last_current_archive (cur_archive)
		end

	store_metrics is
			-- Store metrics.
		do
			metric_manager.store_userdefined_metrics
			display_error_message
		end

	display_error_message is
			-- Display error message from `metric_manager'.
		local
			l_dlg: EV_ERROR_DIALOG
		do
			if metric_manager.has_error then
				if feedback_dialog.is_show_requested then
					feedback_dialog.hide
				end
				create l_dlg.make_with_text (metric_manager.last_error.message_with_location)
				l_dlg.set_buttons_and_actions (<<metric_names.t_ok>>, <<agent do_nothing>>)
				l_dlg.show_relative_to_window (development_window.window)
				metric_manager.clear_last_error
			end
		end

	set_recompiled (bool: BOOLEAN) is
			-- Assign `bool' to `is_recompiled'.
		do
			is_recompiled := bool
			is_up_to_date := False
			is_compiling := False
			if context_tool.notebook.selected_item = widget and is_recompiled then
				synchronize_after_compilation
			end
		end

	synchronize_after_compilation is
			-- System recompiled, synchronize all related parts in metric tool.
		do
			if not is_metrics_loaded then
				load_metrics (False, metric_names.t_loading_metrics)
				metric_tool_interface.on_tab_change
				display_error_message
				is_metrics_loaded := True
				set_is_validation_checked (True)
			else
				if is_shown then
					check_metric_validation
					set_is_validation_checked (True)
				else
					set_is_validation_checked (False)
				end
			end
			development_window.window_manager.display_message (metric_names.t_checking_metric_vadility)
			development_window.window_manager.display_message ("")
			set_changed
			notify (False)
			is_up_to_date := True
		end

	set_stone (a_stone: STONE) is
			-- Change the target of `Current'.
			--| The implementation is delayed for optimization purposes.
		do
		end

	set_focus is
			-- Give the focus to the metrics.
		do
		end

	enable_tab (a_tab_index: INTEGER) is
			-- Enable tab whose index is `a_tab_index'.
		do
			metric_tool_interface.metric_notebook.i_th (a_tab_index).enable_sensitive
		end

	disable_tab (a_tab_index: INTEGER) is
			-- Disable tab whose index is `a_tab_index'.
		do
			metric_tool_interface.metric_notebook.i_th (a_tab_index).disable_sensitive
		end

	set_is_validation_checked (b: BOOLEAN) is
			-- Set `is_validation_checked' with `b'.
		do
			is_validation_checked := b
		ensure
			is_validation_checked_set: is_validation_checked = b
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Application main window.

	context_tool: EB_CONTEXT_TOOL
			-- Container of `Current'.

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'

	on_compile_start_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_compile_start'

	feedback_dialog: EV_INFORMATION_DIALOG
			-- Dialog to display feedback

feature {NONE} -- Memory management

	internal_recycle is
			-- Remove all references to `Current', and leave `Current' in an
			-- unstable state, so that we know `Current' is not referenced any longer.
		do
			manager.remove_observer (Current)
			if on_compile_start_agent /= Void then
				development_window.window_manager.compile_start_actions.prune_all (on_compile_start_agent)
			end
			metric_tool_interface.recycle
			development_window := Void
			context_tool := Void
		end

feature -- Status report

	is_compiling: BOOLEAN
			-- Is Eiffel compilation under going?

	is_shown: BOOLEAN
			-- Is `Current' currently displayed in the context tool?

	is_metrics_loaded: BOOLEAN
			-- Have predefined and user-defined metrics been loaded from files?

	is_up_to_date: BOOLEAN
			-- Is interface of metric tool up-to-date?

	is_recompiled: BOOLEAN
			-- Has system been recompiled?

	is_validation_checked: BOOLEAN
			-- Is metric validation checked?

feature{NONE} -- Implementation

	metric_tool_interface: EB_METRIC_TOOL_PANEL
			-- Interface of metric tool

	set_tool_sensitive (a_sensitive: BOOLEAN) is
			-- If `a_sensitive' is True, enable sensitivity of metric tool,
			-- otherwise, disable its sensitivity.
		local
			l_notebook: EV_NOTEBOOK
			l_item: EV_WIDGET
		do
			l_notebook := metric_tool_interface.metric_notebook
			from
				l_notebook.start
			until
				l_notebook.after
			loop
				l_item := l_notebook.item
				if l_item /= Void then
					if a_sensitive then
						l_item.enable_sensitive
					else
						l_item.disable_sensitive
					end

				end
				l_notebook.forth
			end
		end

invariant
	feedback_dialog_attached: feedback_dialog /= Void
	not_feedback_dialog_is_destroyed: not feedback_dialog.is_destroyed

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
