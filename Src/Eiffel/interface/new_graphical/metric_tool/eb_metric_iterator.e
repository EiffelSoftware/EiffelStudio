indexing
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

feature -- Access

	callback_agents: HASH_TABLE [PROCEDURE [ANY, TUPLE [EB_METRIC_VISITABLE]], INTEGER] is
			-- Agents table indexed by metric visitable element name index.
			-- When process_XXX is called to process a certain type of visitable,
			-- its associate callback agent (if any) from this table is called.
		do
			if callback_agents_internal = Void then
				create callback_agents_internal.make (20)
			end
			Result := callback_agents_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_type_index_valid (a_type_index: INTEGER): BOOLEAN is
			-- Is type index `a_type_index' valid?
		do
			Result :=
				a_type_index = basic_metric_index or else
				a_type_index = linear_metric_index or else
				a_type_index = ratio_metric_index or else
				a_type_index = domain_criterion_index or else
				a_type_index = caller_callee_criterion_index or else
				a_type_index = supplier_client_criterion_index or else
				a_type_index = text_criterion_index or else
				a_type_index = path_criterion_index or else
				a_type_index = normal_criterion_index or else
				a_type_index = value_criterion_index or else
				a_type_index = and_criterion_index or else
				a_type_index = or_criterion_index or else
				a_type_index = domain_index or else
				a_type_index = application_target_domain_item_index or else
				a_type_index = group_domain_item_index or else
				a_type_index = folder_domain_item_index or else
				a_type_index = class_domain_item_index or else
				a_type_index = feature_domain_item_index or else
				a_type_index = delayed_domain_item_index or else
				a_type_index = metric_archive_node_index or else
				a_type_index = value_tester_index or else
				a_type_index = constant_value_retriever_index or else
				a_type_index = metric_value_retriever_index
		end

feature -- Type index

	basic_metric_index: INTEGER is 1
	linear_metric_index: INTEGER is 2
	ratio_metric_index: INTEGER is 3
	domain_criterion_index: INTEGER is 4
	caller_callee_criterion_index: INTEGER is 5
	supplier_client_criterion_index: INTEGER is 6
	text_criterion_index: INTEGER is 7
	path_criterion_index: INTEGER is 8
	normal_criterion_index: INTEGER is 9
	value_criterion_index: INTEGER is 10
	and_criterion_index: INTEGER is 11
	or_criterion_index: INTEGER is 12
	domain_index: INTEGER is 13
	application_target_domain_item_index: INTEGER is 14
	group_domain_item_index: INTEGER is 15
	folder_domain_item_index: INTEGER is 16
	class_domain_item_index: INTEGER is 17
	feature_domain_item_index: INTEGER is 18
	delayed_domain_item_index: INTEGER is 19
	metric_archive_node_index: INTEGER is 20
	value_tester_index: INTEGER is 21
	constant_value_retriever_index: INTEGER is 22
	metric_value_retriever_index: INTEGER is 23
		-- Type index

feature -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC) is
			-- Process `a_basic_metric'.
		do
			invoke_callback_agents (basic_metric_index, a_basic_metric)
			safe_process_item (a_basic_metric.criteria)
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR) is
			-- Process `a_linear_metric'.
		do
			invoke_callback_agents (linear_metric_index, a_linear_metric)
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO) is
			-- Process `a_ratio_metric'.
		do
			invoke_callback_agents (ratio_metric_index, a_ratio_metric)
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (domain_criterion_index, a_criterion)
			a_criterion.domain.process (Current)
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (caller_callee_criterion_index, a_criterion)
			a_criterion.domain.process (Current)
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (supplier_client_criterion_index, a_criterion)
			a_criterion.domain.process (Current)
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (text_criterion_index, a_criterion)
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (path_criterion_index, a_criterion)
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (normal_criterion_index, a_criterion)
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (value_criterion_index, a_criterion)
			a_criterion.domain.process (Current)
			a_criterion.value_tester.process (Current)
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
		do
			process_list (a_criterion.operands)
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION) is
			-- Process `a_criterion'.
		do
			invoke_callback_agents (and_criterion_index, a_criterion)
			process_nary_criterion (a_criterion)
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION) is
			-- Process `a_criterion'.
		do
		invoke_callback_agents (or_criterion_index, a_criterion)
			process_nary_criterion (a_criterion)
		end

	process_domain (a_domain: EB_METRIC_DOMAIN) is
			-- Process `a_domain'.
		do
			invoke_callback_agents (domain_index, a_domain)
			process_list (a_domain)
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			invoke_callback_agents (application_target_domain_item_index, a_item)
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			invoke_callback_agents (group_domain_item_index, a_item)
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			invoke_callback_agents (folder_domain_item_index, a_item)
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			invoke_callback_agents (class_domain_item_index, a_item)
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			invoke_callback_agents (feature_domain_item_index, a_item)
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			invoke_callback_agents (delayed_domain_item_index, a_item)
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE) is
			-- Process `a_item'.
		do
			invoke_callback_agents (metric_archive_node_index, a_item)
		end

	process_value_tester (a_item: EB_METRIC_VALUE_TESTER) is
			-- Process `a_item'.
		local
			l_cri: LIST [TUPLE [retriever:EB_METRIC_VALUE_RETRIEVER; operator:INTEGER]]
			l_cursor: CURSOR
		do
			invoke_callback_agents (value_tester_index, a_item)
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

	process_value_retriever (a_item: EB_METRIC_VALUE_RETRIEVER) is
			-- Process `a_item'.
		do
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER) is
			-- Process `a_item'.
		do
			invoke_callback_agents (constant_value_retriever_index, a_item)
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER) is
			-- Process `a_item'.
		do
			invoke_callback_agents (metric_value_retriever_index, a_item)
			a_item.input_domain.process (Current)
		end

feature{NONE} -- Implementation

	callback_agents_internal: like callback_agents
		-- Implementation of `callback_agents'

	invoke_callback_agents (a_type_index: INTEGER; a_item: EB_METRIC_VISITABLE) is
			-- Invoke agent (if any) for element whose type index is `a_type_index' in `callback_agents'.
		require
			type_index_valid: is_type_index_valid (a_type_index)
		local
			l_agent: PROCEDURE [ANY, TUPLE [EB_METRIC_VISITABLE]]
		do
			l_agent := callback_agents.item (a_type_index)
			if l_agent /= Void then
				l_agent.call ([a_item])
			end
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
