note
	description: "Metric archive validity checker"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE_VALIDITY_CHECKER

inherit
	EB_METRIC_VALIDITY_VISITOR
		redefine
			make,
			process_metric_archive_node,
			process_metric_value_retriever,
			process_delayed_domain_item
		end

create
	make

feature{NONE} -- Initialization

	make (a_manager: EB_METRIC_MANAGER)
			-- Initialize `metric_manager' with `a_manager'.
		do
			create delayed_validity_function_stack.make
			delayed_item_validity_from_archive_input_agent := agent delayed_item_validity_from_archive_input
			delayed_item_validity_from_metric_value_retriever_agent := agent delayed_item_validity_from_metric_value_retriever
			Precursor (a_manager)
		end

feature -- Access

	delayed_validity_function_stack: LINKED_STACK [like delayed_validity_function]
			-- Stack of `delayed_validity_function'

feature -- Process

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE)
			-- Process `a_item'.
		do
			if not has_error then
				delayed_validity_function_stack.extend (delayed_item_validity_from_archive_input_agent)
				a_item.input_domain.process (Current)
				a_item.value_tester.process (Current)
				delayed_validity_function_stack.remove
			end
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			if not has_error then
				delayed_validity_function_stack.extend (delayed_item_validity_from_metric_value_retriever_agent)
				Precursor (a_item)
				delayed_validity_function_stack.remove
			end
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			if not has_error then
				set_delayed_validity_function (actual_delayed_validity_function)
				Precursor (a_item)
			end
		end

feature{NONE} -- Implementation

	actual_delayed_validity_function: like delayed_validity_function
			-- Actual `delayed_validity_function' according to current checking context
		local
			l_stack: like delayed_validity_function_stack
		do
			l_stack := delayed_validity_function_stack
			if not l_stack.is_empty then
				Result := l_stack.item
			end
		end

	delayed_item_validity_from_archive_input (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM): EB_METRIC_ERROR
			-- Validity status of delayed domain item from archive node input domain
		require
			a_item_attached:a_item /= Void
		do
			if a_item.is_real_delayed_item then
				create Result.make (metric_names.err_delayed_domain_item_appear)
				Result.set_to_do (metric_names.delayed_domain_item_appear_to_do)
			elseif a_item.is_input_domain_item then
				create Result.make (metric_names.err_input_domain_item_appear)
				Result.set_to_do (metric_names.input_domain_item_appear_to_do)
			end
		end

	delayed_item_validity_from_metric_value_retriever (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM): EB_METRIC_ERROR
			-- Validity status of delayed domain item from metric value retriever
		require
			a_item_attached:a_item /= Void
		do
			if a_item.is_real_delayed_item then
				create Result.make (metric_names.err_delayed_domain_item_appear)
				Result.set_to_do (metric_names.delayed_domain_item_appear_to_do)
			end
		end

	delayed_item_validity_from_archive_input_agent: like delayed_validity_function
	delayed_item_validity_from_metric_value_retriever_agent: like delayed_validity_function
			-- Agents

invariant
	delayed_validity_function_stack_attached: delayed_validity_function_stack /= Void
	delayed_item_validity_from_archive_input_agent_attached: delayed_item_validity_from_archive_input_agent /= Void
	delayed_item_validity_from_metric_value_retriever_agent_attached: delayed_item_validity_from_metric_value_retriever_agent /= Void

end
