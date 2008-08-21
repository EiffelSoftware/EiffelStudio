indexing
	description: "Metric archive calculator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE_CALCULATOR

inherit
	EB_METRIC_SHARED

	EB_SHARED_ID_SOLUTION

	EXCEPTIONS

feature -- Access

	archive_calculated_actions: ACTION_SEQUENCE [TUPLE [a_archive: EB_METRIC_ARCHIVE_NODE]] is
			-- Action to be performed when one archive is calculated.
			-- Information of the finished archive is stored in `a_archive'.
		do
			if archive_calculated_actions_internal = Void then
				create archive_calculated_actions_internal
			end
			Result := archive_calculated_actions_internal
		ensure
			result_attached: Result /= Void
		end

	step_actions: ACTION_SEQUENCE [TUPLE [QL_ITEM]] is
			-- Step actions, i.e., everytime when certain number of query language items are processed,
			-- step actions are invoked with the current processed item passed as the only argument.
		do
			if step_actions_internal = Void then
				create step_actions_internal
			end
			Result := step_actions_internal
		ensure
			result_attached: Result /= Void
		end

	last_error_message: STRING_32
			-- Last error message

	calculated_archives: LIST [EB_METRIC_ARCHIVE_NODE] is
			-- Calculated archive nodes
		do
			if calculated_archives_internal = Void then
				create {LINKED_LIST [EB_METRIC_ARCHIVE_NODE]} calculated_archives_internal.make
			end
			Result := calculated_archives_internal
		ensure
			result_attached: Result /= Void
		end

	calculated_archive: EB_METRIC_ARCHIVE is
			-- Archive generated from `calculated_archives'
		do
			create Result.make
			calculated_archives.do_all (agent Result.insert_archive_node)
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	has_error: BOOLEAN is
			-- Did error occur?
		do
			Result := last_error_message /= Void
		end

feature -- Setting

	set_last_error_message (a_message: like last_error_message) is
			-- Set `last_error_message' with `a_message'.
		do
			if a_message = Void then
				last_error_message := Void
			else
				create last_error_message.make_from_string (a_message)
			end
		end

feature -- Calculation

	calculate_archive (a_task: LINEAR [TUPLE [a_metric: EB_METRIC; a_input_domain: EB_METRIC_DOMAIN; a_keep_result: BOOLEAN; a_filter_result: BOOLEAN; a_tester: EB_METRIC_VALUE_TESTER]]) is
			-- Calculate metric archive in `a_task' and store `calculated_archives'.
			-- `a_task' is a list of metrics with there input domain.
			-- `a_keep_result' indicates if detailed result should be kept.
			-- `a_filter_result' indicates if result should be filtered out if they are invisible.
			-- `a_tester' attached means that we should check warnings.
		require
			a_task_attached: a_task /= Void
		local
			l_retried: BOOLEAN
			l_domain_generator: QL_TARGET_DOMAIN_GENERATOR
			l_metric: EB_METRIC
			l_input_domain: EB_METRIC_DOMAIN
			l_time: DATE_TIME
			l_value: DOUBLE
			l_archive_node: EB_METRIC_ARCHIVE_NODE
			l_archive_calculated_actions: like archive_calculated_actions
			l_archives: like calculated_archives
			l_archive_validity_checker: like archive_validity_checker
		do
			create l_domain_generator
			l_archives := calculated_archives
			l_archives.wipe_out
			l_archive_validity_checker := archive_validity_checker
			if not l_retried then
				set_last_error_message (Void)
				setup_calculation_context (l_domain_generator)
				l_archive_calculated_actions := archive_calculated_actions
				from
					a_task.start
				until
					a_task.after
				loop
					check a_task.item /= Void end
					l_metric := a_task.item.a_metric
					l_input_domain := a_task.item.a_input_domain
					check
						l_metric /= Void and then metric_manager.has_metric (l_metric.name)
						l_input_domain /= Void and then l_input_domain.is_valid
					end
					create l_time.make_now
					if l_metric.is_result_domain_available and then a_task.item.a_keep_result then
						l_metric.enable_fill_domain
					else
						l_metric.disable_fill_domain
					end
					if a_task.item.a_filter_result then
						l_metric.enable_filter_result
					else
						l_metric.disable_filter_result
					end
					l_value := l_metric.value_item (l_input_domain)
					create l_archive_node.make (l_metric.name, metric_type_id (l_metric), l_time, l_value, l_input_domain, uuid_gen.generate_uuid.out, a_task.item.a_filter_result)
					l_archives.extend (l_archive_node)
					l_archive_calculated_actions.call ([l_archive_node])
					if l_metric.last_result_domain /= Void then
						l_archive_node.set_detailed_result (l_metric.last_result_domain)
					end
					if a_task.item.a_tester /= Void and then not a_task.item.a_tester.criteria.is_empty then
						l_archive_validity_checker.check_validity (a_task.item.a_tester)
						if not l_archive_validity_checker.has_error then
							l_archive_node.set_is_last_warning_check_successful (a_task.item.a_tester.is_satisfied_by_domain (l_value, l_input_domain))
						end
					else
						l_archive_node.set_is_last_warning_check_successful (True)
					end
					a_task.forth
				end
				destroy_calculation_context (l_domain_generator)
			end
		rescue
			l_retried := True
			destroy_calculation_context (l_domain_generator)
			if l_domain_generator.error_handler.has_error then
				set_last_error_message (l_domain_generator.error_handler.error_list.last.text.as_string_32)
			else
				if {lt_ex: UNICODE_MESSAGE_EXCEPTION}exception_manager.last_exception.original then
					set_last_error_message (lt_ex.unicode_message)
				else
					set_last_error_message (tag_name)
				end
			end
			retry
		end

feature{NONE} -- Implementation

	last_step: NATURAL_64
			-- Last step interval

	temp_step: NATURAL_64 is 20
			-- Temporate step interval used during archive calculation

	archive_calculated_actions_internal: like archive_calculated_actions
			-- Implementation of `archive_calculated_actions'

	step_actions_internal: like step_actions;
			-- Implementation of `step_actions'.

	calculated_archives_internal: like calculated_archives
			-- Implementation of `calculated_archives'

	set_last_step (a_step: like last_step) is
			-- Set `last_step' with `a_step'.
		do
			last_step := a_step
		ensure
			last_step_set: last_step = a_step
		end

	setup_calculation_context (a_domain_generator: QL_DOMAIN_GENERATOR) is
			-- Setup archive evaluation context, because when metric is running, we want to keep GUI alive.
		require
			a_domain_generator_attached: a_domain_generator /= Void
		local
			l_tick_actions: ACTION_SEQUENCE [TUPLE [QL_ITEM]]
		do
			set_last_step (a_domain_generator.interval)
			a_domain_generator.set_interval (temp_step)
			l_tick_actions := a_domain_generator.tick_actions
			step_actions.do_all (agent l_tick_actions.prune_all)
			step_actions.do_all (agent l_tick_actions.extend)
		end

	destroy_calculation_context (a_domain_generator: QL_DOMAIN_GENERATOR) is
			-- Destroy archive calculation context.
		require
			a_domain_generator_attached: a_domain_generator /= Void
		local
			l_tick_actions: ACTION_SEQUENCE [TUPLE [QL_ITEM]]
		do
			a_domain_generator.set_interval (last_step)
			l_tick_actions := a_domain_generator.tick_actions
			step_actions.do_all (agent l_tick_actions.prune_all)
		end

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
