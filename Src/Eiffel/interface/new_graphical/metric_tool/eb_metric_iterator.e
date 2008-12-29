note
	description: "Iterator to navigate through a metric definition"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ITERATOR

inherit
	EB_METRIC_VISITOR

feature{NONE} -- Access

	visitor: DP_VISITOR [EB_METRIC_VISITABLE]
			-- Visitor to support customized element visiting
		do
			if visitor_internal = Void then
				create visitor_internal
			end
			Result := visitor_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Callback action register

	extend_action (a_action: PROCEDURE [ANY, TUPLE [EB_METRIC_VISITABLE]])
			-- Extend `a_action' which is invoked when processing certain kind of {EB_METRIC_VISITABLE}.
		require
			a_action_attached: a_action /= Void
		do
			visitor.extend (a_action)
		ensure
			a_action_extened: visitor.has_action (a_action)
		end

	append_actions (a_actions: ARRAY [PROCEDURE [ANY, TUPLE [EB_METRIC_VISITABLE]]])
			-- Append `a_actions' to `visitor'.
		require
			a_actions_attached: a_actions /= Void
			no_void_action: not a_actions.has (Void)
		do
			visitor.append (a_actions)
		end

feature -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC)
			-- Process `a_basic_metric'.
		do
			invoke_callback_agents (a_basic_metric)
			safe_process_item (a_basic_metric.criteria)
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR)
			-- Process `a_linear_metric'.
		do
			invoke_callback_agents (a_linear_metric)
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO)
			-- Process `a_ratio_metric'.
		do
			invoke_callback_agents (a_ratio_metric)
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			a_criterion.domain.process (Current)
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			a_criterion.domain.process (Current)
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			a_criterion.domain.process (Current)
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			a_criterion.domain.process (Current)
			a_criterion.value_tester.process (Current)
		end

	process_external_command_criterion (a_criterion: EB_METRIC_EXTERNAL_COMMAND_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			a_criterion.tester.process (Current)
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			process_list (a_criterion.operands)
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			process_list (a_criterion.operands)
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION)
			-- Process `a_criterion'.
		do
			invoke_callback_agents (a_criterion)
			process_list (a_criterion.operands)
		end

	process_domain (a_domain: EB_METRIC_DOMAIN)
			-- Process `a_domain'.
		do
			invoke_callback_agents (a_domain)
			process_list (a_domain)
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_value_tester (a_item: EB_METRIC_VALUE_TESTER)
			-- Process `a_item'.
		local
			l_cri: LIST [TUPLE [retriever:EB_METRIC_VALUE_RETRIEVER; operator:INTEGER]]
			l_cursor: CURSOR
		do
			invoke_callback_agents (a_item)
			l_cri := a_item.criteria
			l_cursor := l_cri.cursor
			from
				l_cri.start
			until
				l_cri.after
			loop
				safe_process_item (l_cri.item.retriever)
				l_cri.forth
			end
			l_cri.go_to (l_cursor)
		end

	process_value_retriever (a_item: EB_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
			a_item.input_domain.process (Current)
		end

	process_external_command_tester (a_item: EB_METRIC_EXTERNAL_COMMAND_TESTER)
			-- Process `a_item'.
		do
			invoke_callback_agents (a_item)
		end

feature{NONE} -- Implementation

	visitor_internal: like visitor
			-- Implementation of `visitor'

	invoke_callback_agents (a_item: EB_METRIC_VISITABLE)
			-- Invoke agent (if any) registered in `visitor' for `a_item'.		
		require
			a_item_attached: a_item /= Void
		do
			visitor.visit (a_item)
		end

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
