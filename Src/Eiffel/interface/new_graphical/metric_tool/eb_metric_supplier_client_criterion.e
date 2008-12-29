note
	description: "Object that represents a supplier/client criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SUPPLIER_CLIENT_CRITERION

inherit
	EB_METRIC_DOMAIN_CRITERION
		redefine
			make,
			new_criterion,
			process,
			is_supplier_client_criterion
		end

create
	make

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING)
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		do
			Precursor (a_scope, a_name)
			if a_name.is_case_insensitive_equal (query_language_names.ql_cri_client_is) then
				enable_for_client
			else
				enable_for_supplier
			end
			set_normal_referenced_class_retrieved (True)
		ensure then
			domain_attached: domain /= Void
		end

feature -- Access

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION
			-- QL_CRITERION representing current criterion
		local
			l_criterion_factory: QL_CRITERION_FACTORY
			l_domain: like domain
		do
			l_criterion_factory := criterion_factory_table.item (a_scope)
			l_domain := domain.actual_domain
			if l_domain.is_empty then
				Result := l_criterion_factory.criterion_with_name (name, [dummy_domain, indirect_referenced_class_retrieved, normal_referenced_class_retrieved, only_syntactically_referencedd_class_retrieved])
			else
				from
					l_domain.start
					Result := l_criterion_factory.criterion_with_name (name, [l_domain.item.domain (a_scope), indirect_referenced_class_retrieved, normal_referenced_class_retrieved, only_syntactically_referencedd_class_retrieved])
					l_domain.forth
				until
					l_domain.after
				loop
					Result := Result or l_criterion_factory.criterion_with_name (name, [l_domain.item.domain (a_scope), indirect_referenced_class_retrieved, normal_referenced_class_retrieved, only_syntactically_referencedd_class_retrieved])
					l_domain.forth
				end
			end
			if is_negation_used then
				Result := not Result
			end
		end

feature -- Status report

	is_supplier_client_criterion: BOOLEAN = True
			-- Is current a criterion for supplier/client classe?

	indirect_referenced_class_retrieved: BOOLEAN
			-- Should indirect referenced classes be retrieved?

	normal_referenced_class_retrieved: BOOLEAN
			-- Should normal referenced classes be retrieved?

	only_syntactically_referencedd_class_retrieved: BOOLEAN
			-- Should only syntactically referenced classes be retrieved?

	is_for_supplier: BOOLEAN
			-- Is Current criterion for suppiers?

	is_for_client: BOOLEAN
			-- Is Current criterion for clients?
		do
			Result := not is_for_supplier
		ensure
			good_result: Result = not is_for_supplier
		end

feature -- Setting

	set_indirect_referenced_class_retrieved (b: BOOLEAN)
			-- Set `indirect_referenced_class_retrieved' with `b'.
		do
			indirect_referenced_class_retrieved := b
		ensure
			indirect_referenced_class_retrieved_set: indirect_referenced_class_retrieved = b
		end

	set_normal_referenced_class_retrieved (b: BOOLEAN)
			-- Set `normal_referenced_class_retrieved' with `b'.
		do
			normal_referenced_class_retrieved := b
		ensure
			normal_referenced_class_retrieved_set: normal_referenced_class_retrieved = b
		end

	set_only_syntactically_referencedd_class_retrieved (b: BOOLEAN)
			-- Set `only_syntactically_referencedd_class_retrieved' with `b'.
		do
			only_syntactically_referencedd_class_retrieved := b
		ensure
			only_syntactically_referencedd_class_retrieved_set: only_syntactically_referencedd_class_retrieved = b
		end

	enable_for_supplier
			-- Enable that Current criterion is for suppliers
		do
			is_for_supplier := True
		ensure
			is_for_supplier: is_for_supplier
		end

	enable_for_client
			-- Enable that Current criterion is for clients
		do
			is_for_supplier := False
		ensure
			is_for_client: is_for_client
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_supplier_client_criterion (Current)
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
