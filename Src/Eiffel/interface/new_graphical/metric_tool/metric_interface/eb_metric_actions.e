note
	description: "Object that represents action sequences for metric tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_ACTIONS

feature{NONE} -- Agent mantainning

	install_agents (a_action_sequences: EB_METRIC_ACTION_SEQUENCES)
			-- Install agents into `a_action_sequences'.
		require
			a_action_sequences_attached: a_action_sequences /= Void
		do
			if not a_action_sequences.compile_start_actions.has (on_compile_start_agent) then
				a_action_sequences.compile_start_actions.extend (on_compile_start_agent)
			end
			if not a_action_sequences.compile_stop_actions.has (on_compile_stop_agent) then
				a_action_sequences.compile_stop_actions.extend (on_compile_stop_agent)
			end
			if not a_action_sequences.metric_evaluation_start_actions.has (on_metric_evaluation_start_agent) then
				a_action_sequences.metric_evaluation_start_actions.extend (on_metric_evaluation_start_agent)
			end
			if not a_action_sequences.metric_evaluation_stop_actions.has (on_metric_evaluation_stop_agent) then
				a_action_sequences.metric_evaluation_stop_actions.extend (on_metric_evaluation_stop_agent)
			end
			if not a_action_sequences.archive_calculation_start_actions.has (on_archive_calculation_start_agent) then
				a_action_sequences.archive_calculation_start_actions.extend (on_archive_calculation_start_agent)
			end
			if not a_action_sequences.archive_calculation_stop_actions.has (on_archive_calculation_stop_agent) then
				a_action_sequences.archive_calculation_stop_actions.extend (on_archive_calculation_stop_agent)
			end
			if not a_action_sequences.metric_loaded_actions.has (on_metric_loaded_agent) then
				a_action_sequences.metric_loaded_actions.extend (on_metric_loaded_agent)
			end
			if not a_action_sequences.project_load_actions.has (on_project_loaded_agent) then
				a_action_sequences.project_load_actions.extend (on_project_loaded_agent)
			end
			if not a_action_sequences.project_unload_actions.has (on_project_unloaded_agent) then
				a_action_sequences.project_unload_actions.extend (on_project_unloaded_agent)
			end
			if not a_action_sequences.history_recalculation_start_actions.has (on_history_recalculation_start_agent) then
				a_action_sequences.history_recalculation_start_actions.extend (on_history_recalculation_start_agent)
			end
			if not a_action_sequences.history_recalculation_stop_actions.has (on_history_recalculation_stop_agent) then
				a_action_sequences.history_recalculation_stop_actions.extend (on_history_recalculation_stop_agent)
			end
			if not a_action_sequences.metric_renamed_actions.has (on_metric_renamed_agent) then
				a_action_sequences.metric_renamed_actions.extend (on_metric_renamed_agent)
			end
		end

	uninstall_agents (a_action_sequences: EB_METRIC_ACTION_SEQUENCES)
			-- Uninstall agents from `a_action_sequences'.
		require
			a_action_sequences_attached: a_action_sequences /= Void
		do
			if a_action_sequences.compile_start_actions.has (on_compile_start_agent) then
				a_action_sequences.compile_start_actions.prune_all (on_compile_start_agent)
			end
			if a_action_sequences.compile_stop_actions.has (on_compile_stop_agent) then
				a_action_sequences.compile_stop_actions.prune_all (on_compile_stop_agent)
			end
			if a_action_sequences.metric_evaluation_start_actions.has (on_metric_evaluation_start_agent) then
				a_action_sequences.metric_evaluation_start_actions.prune_all (on_metric_evaluation_start_agent)
			end
			if a_action_sequences.metric_evaluation_stop_actions.has (on_metric_evaluation_stop_agent) then
				a_action_sequences.metric_evaluation_stop_actions.prune_all (on_metric_evaluation_stop_agent)
			end
			if a_action_sequences.archive_calculation_start_actions.has (on_archive_calculation_start_agent) then
				a_action_sequences.archive_calculation_start_actions.prune_all (on_archive_calculation_start_agent)
			end
			if a_action_sequences.archive_calculation_stop_actions.has (on_archive_calculation_stop_agent) then
				a_action_sequences.archive_calculation_stop_actions.prune_all (on_archive_calculation_stop_agent)
			end
			if a_action_sequences.metric_loaded_actions.has (on_metric_loaded_agent) then
				a_action_sequences.metric_loaded_actions.prune_all (on_metric_loaded_agent)
			end
			if a_action_sequences.project_load_actions.has (on_project_loaded_agent) then
				a_action_sequences.project_load_actions.prune_all (on_project_loaded_agent)
			end
			if a_action_sequences.project_unload_actions.has (on_project_unloaded_agent) then
				a_action_sequences.project_unload_actions.prune_all (on_project_unloaded_agent)
			end
			if a_action_sequences.history_recalculation_start_actions.has (on_history_recalculation_start_agent) then
				a_action_sequences.history_recalculation_start_actions.prune_all (on_history_recalculation_start_agent)
			end
			if a_action_sequences.history_recalculation_stop_actions.has (on_history_recalculation_stop_agent) then
				a_action_sequences.history_recalculation_stop_actions.prune_all (on_history_recalculation_stop_agent)
			end
			if a_action_sequences.metric_renamed_actions.has (on_metric_renamed_agent) then
				a_action_sequences.metric_renamed_actions.prune_all (on_metric_renamed_agent)
			end
		end

feature{NONE} -- Actions

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
			-- Action to be performed when history recalculation starts
			-- `a_data' can be the metric tool panel from which history recalculation starts.
		deferred
		end

	on_history_recalculation_stop (a_data: ANY)
			-- Action to be performed when history recalculation stops
			-- `a_data' can be the metric tool panel from which history recalculation stops.
		deferred
		end

	on_metric_renamed (a_old_name, a_new_name: STRING)
			-- Action to be performed when a metric with `a_old_name' has been renamed to `a_new_name'.
		deferred
		end

feature{NONE} -- Agents

	on_project_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_project_loaded'.
		do
			if on_project_loaded_agent_internal = Void then
				on_project_loaded_agent_internal := agent on_project_loaded
			end
			Result := on_project_loaded_agent_internal
		end

	on_project_unloaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_project_unloaded'.
		do
			if on_project_unloaded_agent_internal = Void then
				on_project_unloaded_agent_internal := agent on_project_unloaded
			end
			Result := on_project_unloaded_agent_internal
		end

	on_compile_start_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_compile_start'
		do
			if on_compile_start_agent_internal = Void then
				on_compile_start_agent_internal := agent on_compile_start
			end
			Result := on_compile_start_agent_internal
		end

	on_compile_stop_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_compile_stop'
		do
			if on_compile_stop_agent_internal = Void then
				on_compile_stop_agent_internal := agent on_compile_stop
			end
			Result := on_compile_stop_agent_internal
		end

	on_metric_evaluation_start_agent: PROCEDURE [ANY, TUPLE [ANY]]
			-- Agent of `on_metric_evaluation_start'
		do
			if on_metric_evaluation_start_agent_internal = Void then
				on_metric_evaluation_start_agent_internal := agent on_metric_evaluation_start
			end
			Result := on_metric_evaluation_start_agent_internal
		end

	on_metric_evaluation_stop_agent: PROCEDURE [ANY, TUPLE [ANY]]
			-- Agent of `on_metric_evaluation_stop'
		do
			if on_metric_evaluation_stop_agent_internal = Void then
				on_metric_evaluation_stop_agent_internal := agent on_metric_evaluation_stop
			end
			Result := on_metric_evaluation_stop_agent_internal
		end

	on_archive_calculation_start_agent: PROCEDURE [ANY, TUPLE [ANY]]
			-- Agent of `on_archive_calculation_start'
		do
			if on_archive_calculation_start_agent_internal = Void then
				on_archive_calculation_start_agent_internal := agent on_archive_calculation_start
			end
			Result := on_archive_calculation_start_agent_internal
		end

	on_archive_calculation_stop_agent: PROCEDURE [ANY, TUPLE [ANY]]
			-- Agent of `on_archive_calculation_stop'
		do
			if on_archive_calculation_stop_agent_internal = Void then
				on_archive_calculation_stop_agent_internal := agent on_archive_calculation_stop
			end
			Result := on_archive_calculation_stop_agent_internal
		end

	on_history_recalculation_stop_agent: PROCEDURE [ANY, TUPLE [ANY]]
			-- Agent of `on_history_recalculation_stop'
		do
			if on_history_recalculation_stop_agent_internal = Void then
				on_history_recalculation_stop_agent_internal := agent on_history_recalculation_stop
			end
			Result := on_history_recalculation_stop_agent_internal
		end

	on_history_recalculation_start_agent: PROCEDURE [ANY, TUPLE [ANY]]
			-- Agent of `on_history_recalculation_start'
		do
			if on_history_recalculation_start_agent_internal = Void then
				on_history_recalculation_start_agent_internal := agent on_history_recalculation_start
			end
			Result := on_history_recalculation_start_agent_internal
		end

	on_metric_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_metric_loaded'
		do
			if on_metric_loaded_agent_internal = Void then
				on_metric_loaded_agent_internal := agent on_metric_loaded
			end
			Result := on_metric_loaded_agent_internal
		end

	on_metric_renamed_agent: PROCEDURE [ANY, TUPLE [a_old_name: STRING; a_new_name: STRING]]
			-- Agent of `on_metric_renamed'
		do
			if on_metric_rename_agent_internal = Void then
				on_metric_rename_agent_internal := agent on_metric_renamed
			end
			Result := on_metric_rename_agent_internal
		end

feature{NONE} -- Implementation

	on_project_loaded_agent_internal: like on_project_loaded_agent
			-- Implementation of `on_project_loaded_agent'

	on_project_unloaded_agent_internal: like on_project_unloaded_agent
			-- Implementation of `on_project_unloaded_agent'

	on_metric_evaluation_start_agent_internal: like on_metric_evaluation_start_agent
			-- Implementation of `on_metric_evaluation_start_agent'

	on_metric_evaluation_stop_agent_internal: like on_metric_evaluation_stop_agent
			-- Implementation of `on_metric_evaluation_stop_agent'

	on_archive_calculation_start_agent_internal: like on_archive_calculation_start_agent
			-- Implementation of `on_archive_calculation_start_agent'

	on_archive_calculation_stop_agent_internal: like on_archive_calculation_stop_agent
			-- Implementation of `on_archive_calculation_stop_agent'

	on_compile_start_agent_internal: like on_compile_start_agent
			-- Implementation of `on_compile_start_agent'

	on_compile_stop_agent_internal: like on_compile_stop_agent
			-- Implementation of `on_compile_stop_agent'

	on_metric_loaded_agent_internal: like on_metric_loaded_agent
			-- Implementation of `on_metric_loaded_agent'

	on_history_recalculation_stop_agent_internal: like on_history_recalculation_stop_agent
			-- Implementation of `on_history_recalculation_stop_agent'

	on_history_recalculation_start_agent_internal: like on_history_recalculation_start_agent
			-- Implementation of `on_history_recalculation_start_agent'

	on_metric_rename_agent_internal: like on_metric_renamed_agent;
			-- Implementation of `on_metric_rename_agent_internal'			

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
