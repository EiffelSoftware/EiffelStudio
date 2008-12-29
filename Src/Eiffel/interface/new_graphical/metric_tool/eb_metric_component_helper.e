note
	description: "Metric tool helper"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMPONENT_HELPER

feature -- Status report

	component_has_real_delayed_domain_item (a_item: EB_METRIC_VISITABLE): BOOLEAN
			-- Does `a_item' contain real delayed domain item?
		require
			a_item_attached: a_item /= Void
		do
			check_component_status (a_item)
			Result := has_real_delayed_input_domain_internal
		end

	component_has_delayed_input_domain_item (a_item: EB_METRIC_VISITABLE): BOOLEAN
			-- Does `a_item' contain delayed input domain item?
		require
			a_item_attached: a_item /= Void
		do
			check_component_status (a_item)
			Result := has_delayed_input_domain_internal
		end

	component_has_delayed_domain_item (a_item: EB_METRIC_VISITABLE): BOOLEAN
			-- Does `a_item' contain delayed domain item (delayed input domain item or real delayed domain item)?
		require
			a_item_attached: a_item /= Void
		do
			check_component_status (a_item)
			Result := has_delayed_domain_item
		end

feature -- Element Change

	replace_delayed_input_domain (a_item: EB_METRIC_VISITABLE; a_domain: EB_METRIC_DOMAIN)
			-- Replace delayed input domain in `a_item' with `a_domain'.
		require
			a_item_attached: a_item /= Void
		local
			l_visitor: EB_METRIC_ITERATOR
		do
			create l_visitor
			delayed_input_domain_internal := a_domain
			l_visitor.extend_action (agent replace_delayed_input_domain_internal)
			a_item.process (l_visitor)
			delayed_input_domain_internal := Void
		end

	replace_real_delayed_domain_item (a_item: EB_METRIC_VISITABLE; a_ql_domain: QL_DOMAIN)
			-- Replace every real delayed domain item cantained in `a_item' with `a_ql_domain'.
		require
			a_item_attached: a_item /= Void
		local
			l_visitor: EB_METRIC_ITERATOR
		do
			create l_visitor
			ql_domain_internal := a_ql_domain
			l_visitor.extend_action (agent replace_real_delayed_domain_item_internal)
			a_item.process (l_visitor)
			ql_domain_internal := Void
		end

	prepare_for_calculation (a_metric: EB_METRIC)
			-- Parpare for calculation of `a_metric'.
			-- Note: Clean some flags which may indicate undesirable results from former calculation.
		require
			a_metric_attached: a_metric /= Void
		local
			l_visitor: EB_METRIC_ITERATOR
		do
			create l_visitor
			l_visitor.append_actions (<<agent on_clean_metric_value_retriever, agent on_clean_value_criterion>>)
			a_metric.process (l_visitor)
		end

	on_clean_value_criterion (a_item: EB_METRIC_VALUE_CRITERION)
			-- Action to be performed to clean legacy data in `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.set_has_metric_status_checked (False)
		end

	on_clean_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Action to be performed to clean legacy data in `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.set_has_metric_status_checked (False)
		end

feature{NONE} -- Implementation

	has_delayed_input_domain_internal: BOOLEAN
	has_real_delayed_input_domain_internal: BOOLEAN
	has_delayed_domain_item: BOOLEAN
	delayed_input_domain_internal: EB_METRIC_DOMAIN
	ql_domain_internal: QL_DOMAIN

	on_delayed_domain_item_process (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Action to be performed when `a_item' is processed
		require
			a_item_attached: a_item /= Void
		do
			has_delayed_domain_item := True
			if a_item.is_real_delayed_item then
				has_real_delayed_input_domain_internal := True
			elseif a_item.is_input_domain_item then
				has_delayed_input_domain_internal := True
			end
		end

	check_component_status (a_item: EB_METRIC_VISITABLE)
			-- Check status of `a_item'.
		require
			a_item_attached: a_item /= Void
		local
			l_visitor: EB_METRIC_ITERATOR
		do
			create l_visitor
			has_delayed_domain_item := False
			has_delayed_input_domain_internal := False
			has_real_delayed_input_domain_internal := False
			l_visitor.extend_action (agent on_delayed_domain_item_process)
			a_item.process (l_visitor)
		end

	replace_delayed_input_domain_internal (a_domain: EB_METRIC_DOMAIN)
			-- If `a_domain' contains delayed input domain item, replace `a_doamin' with `delayed_input_domain_internal'.
		do
			if a_domain.has_delayed_input_domain_item then
				a_domain.set_external_domain (delayed_input_domain_internal)
			end
		end

	replace_real_delayed_domain_item_internal (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Replace `a_item' with `ql_domain_internal'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.set_external_ql_domain (ql_domain_internal)
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
