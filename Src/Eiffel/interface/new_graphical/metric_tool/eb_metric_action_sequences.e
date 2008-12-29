note
	description: "Action sequences used in metric tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ACTION_SEQUENCES

feature -- Access

	compile_start_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Eiffel compilation starts
		do
			if compile_start_actions_internal = Void then
				create compile_start_actions_internal
			end
			Result := compile_start_actions_internal
		ensure
			result_attached: Result /= Void
		end

	compile_stop_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Eiffel compilation stops
		do
			if compile_stop_actions_internal = Void then
				create compile_stop_actions_internal
			end
			Result := compile_stop_actions_internal
		ensure
			result_attached: Result /= Void
		end

	metric_evaluation_start_actions: ACTION_SEQUENCE [TUPLE [ANY]]
			-- Actions to be performed when metric evaluation starts.
			-- The only argument maybe the metric tool panel from which
			-- metric evaluation starts (if used in graphical mode)
		do
			if metric_evaluation_start_actions_internal = Void then
				create metric_evaluation_start_actions_internal
			end
			Result := metric_evaluation_start_actions_internal
		ensure
			result_attached: Result /= Void
		end

	metric_evaluation_stop_actions: ACTION_SEQUENCE [TUPLE [ANY]]
			-- Actions to be performed when metric evaluation stops.
			-- The only argument maybe the metric tool panel from which
			-- metric evaluation stops (if used in graphical mode)
		do
			if metric_evaluation_stop_actions_internal = Void then
				create metric_evaluation_stop_actions_internal
			end
			Result := metric_evaluation_stop_actions_internal
		ensure
			result_attached: Result /= Void
		end

	archive_calculation_start_actions: ACTION_SEQUENCE [TUPLE [ANY]]
			-- Actions to be performed when metric archive calculation starts.
			-- The only argument maybe the metric tool panel from which
			-- metric archive calculation starts (if used in graphical mode)
		do
			if archive_calculation_start_actions_internal = Void then
				create archive_calculation_start_actions_internal
			end
			Result := archive_calculation_start_actions_internal
		ensure
			result_attached: Result /= Void
		end

	archive_calculation_stop_actions: ACTION_SEQUENCE [TUPLE [ANY]]
			-- Actions to be performed when metric archive calculation stops.
			-- The only argument maybe the metric tool panel from which
			-- metric archive calculation stops (if used in graphical mode)
		do
			if archive_calculation_stop_actions_internal = Void then
				create archive_calculation_stop_actions_internal
			end
			Result := archive_calculation_stop_actions_internal
		ensure
			result_attached: Result /= Void
		end

	metric_loaded_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when metrics are loaded from files.
		do
			if metric_loaded_actions_internal = Void then
				create metric_loaded_actions_internal
			end
			Result := metric_loaded_actions_internal
		ensure
			result_attached: Result /= Void
		end

	project_load_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when project loaded
		do
			if project_load_actions_internal = Void then
				create project_load_actions_internal
			end
			Result := project_load_actions_internal
		ensure
			result_attached: Result /= Void
		end

	project_unload_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when project unloaded
		do
			if project_unload_actions_internal = Void then
				create project_unload_actions_internal
			end
			Result := project_unload_actions_internal
		ensure
			result_attached: Result /= Void
		end

	history_recalculation_start_actions: ACTION_SEQUENCE [TUPLE [ANY]]
			-- Action to be performed when metric history recalculation starts.
			-- The only argument maybe the metric tool panel from which
			-- metric history recalculation starts (if used in graphical mode)
		do
			if history_recalculation_start_actions_internal = Void then
				create history_recalculation_start_actions_internal
			end
			Result := history_recalculation_start_actions_internal
		end

	history_recalculation_stop_actions: ACTION_SEQUENCE [TUPLE [ANY]]
			-- Action to be performed when metric history recalculation stops.
			-- The only argument maybe the metric tool panel from which
			-- metric history recalculation stops (if used in graphical mode)
		do
			if history_recalculation_stop_actions_internal = Void then
				create history_recalculation_stop_actions_internal
			end
			Result := history_recalculation_stop_actions_internal
		end

	metric_renamed_actions: ACTION_SEQUENCE [TUPLE [a_old_name: STRING; a_new_name: STRING]]
			-- Actions to be performed when a metric name changed from `a_old_name' to `a_new_name'.
		do
			if metric_renamed_actions_internal = Void then
				create metric_renamed_actions_internal
			end
			Result := metric_renamed_actions_internal
		end

feature {NONE} -- Implementation

	metric_evaluation_stop_actions_internal: like metric_evaluation_stop_actions
			-- Implementation of `metric_evaluation_stop_actions'			

	compile_start_actions_internal: like compile_start_actions
			-- Implementation of `compile_start_actions'

	compile_stop_actions_internal: like compile_stop_actions
			-- Implementation of `compile_stop_actions'

	metric_evaluation_start_actions_internal: like metric_evaluation_start_actions
			-- Implementation of `metric_evaluation_start_actions'			

	archive_calculation_start_actions_internal: like archive_calculation_start_actions
			-- Implementation of `archive_calculation_start_actions'

	archive_calculation_stop_actions_internal: like archive_calculation_stop_actions
			-- Implementation of `archive_calculation_stop_actions'		

	metric_loaded_actions_internal: like metric_loaded_actions
			-- Implementation of `metric_loaded_actions'

	project_load_actions_internal: like project_load_actions
			-- Implementation of `project_load_actions'

	project_unload_actions_internal: like project_unload_actions
			-- Implementation of `project_unload_actions'	

	history_recalculation_start_actions_internal: like history_recalculation_start_actions
			-- Implementation of `history_recalculation_start_actions'

	history_recalculation_stop_actions_internal: like history_recalculation_stop_actions
			-- Implementation of `history_recalculation_stop_actions'

	metric_renamed_actions_internal: like metric_renamed_actions
			-- Implementation of `metric_renamed_actions'			

invariant
	compile_start_actions_attached: compile_start_actions /= Void
	compile_stop_actions_attached: compile_stop_actions /= Void
	metric_evaluation_start_actions_attached: metric_evaluation_start_actions /= Void
	metric_evaluation_stop_actions_attached: metric_evaluation_stop_actions /= Void
	metric_loaded_actions_attached: metric_loaded_actions /= Void
	archive_calculation_start_actions_attached: archive_calculation_start_actions /= Void
	archive_calculation_stop_actions_attached: archive_calculation_stop_actions /= Void
	project_load_actions_attatched: project_load_actions /= Void
	project_unload_actions_attached: project_unload_actions /= Void
	history_recalculation_start_actions_attached: history_recalculation_start_actions /= Void
	history_recalculation_stop_actions_attached: history_recalculation_stop_actions /= Void
	metric_renamed_actions_attached: metric_renamed_actions /= Void

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
