note
	description: "Metric delayed domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DELAYED_DOMAIN_ITEM

inherit
	EB_DELAYED_DOMAIN_ITEM
		undefine
			string_representation
		redefine
			domain
		end

	EB_METRIC_DOMAIN_ITEM
		undefine
			is_valid,
			is_equal,
			is_delayed_item,
			is_real_delayed_item,
			is_input_domain_item
		redefine
			string_representation
		end

	EB_METRIC_SHARED
		undefine
			is_equal
		end

create
	make

feature -- Access

	string_representation: STRING
			-- Text of current item
		do
			if not is_valid or else not id.is_empty then
				Result := Precursor
			else
				Result := metric_names.te_input_domain
			end
		end

	domain (a_scope: QL_SCOPE): QL_DOMAIN
			-- New query lanaguage domain representing current item
		do
			if is_external_ql_domain_enabled then
				Result := external_ql_domain
			else
				Result := a_scope.delayed_domain
			end
		end

feature{EB_METRIC_VALUE_CRITERION, EB_METRIC_METRIC_VALUE_RETRIEVER, EB_METRIC_COMPONENT_HELPER} -- Access

	external_ql_domain: QL_DOMAIN
			-- QL domain used instead a delayed domain

feature{EB_METRIC_VALUE_CRITERION, EB_METRIC_METRIC_VALUE_RETRIEVER, EB_METRIC_COMPONENT_HELPER} -- Status report

	is_external_ql_domain_enabled: BOOLEAN
			-- Should `domain' return `external_ql_domain'?
			-- Note: This is used to calculate value criterion.
		do
			Result := external_ql_domain /= Void
		end

feature{EB_METRIC_VALUE_CRITERION, EB_METRIC_METRIC_VALUE_RETRIEVER, EB_METRIC_COMPONENT_HELPER} -- Setting

	set_external_ql_domain (a_domain: like external_ql_domain)
			-- Set `external_ql_domain' with `a_domain'.
		do
			external_ql_domain := a_domain
		ensure
			external_ql_domain_set: external_ql_domain = a_domain
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_delayed_domain_item (Current)
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
