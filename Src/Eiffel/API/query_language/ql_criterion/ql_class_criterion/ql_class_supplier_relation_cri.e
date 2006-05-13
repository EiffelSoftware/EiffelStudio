indexing
	description: "Object that represents a criterion to decide whether or not a class is a supplier of another class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_SUPPLIER_RELATION_CRI

inherit
	QL_CLASS_HIERARCHY_CRI
		redefine
			relation_type,
			intrinsic_domain,
			finder_agent_table
		end

	QL_SHARED_CLASS_RELATION

create
	make

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_CLASS_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion			
		local
			l_list: like candidate_class_list
			l_class: QL_CLASS
			l_compiled_classes_in_source: like compiled_classes_from_domain
			l_class_c: CLASS_C
			l_class_id: INTEGER
		do
			l_compiled_classes_in_source := compiled_classes_from_domain (source_domain)
			create Result.make
			l_list := candidate_class_list
			from
				l_list.start
			until
				l_list.after
			loop
				l_class_c := l_list.item_for_iteration
				l_class_id := l_class_c.class_id
				l_class := l_compiled_classes_in_source.item (l_class_id)
				if l_class /= Void then
					Result.extend (l_class)
				end
				l_list.forth
			end
		end

feature -- Access

	relation_type: QL_CLASS_CLIENT_RELATION
			-- Type of class relation

feature -- Status report

	is_relation_type_valid (a_type: like relation_type): BOOLEAN is
			-- Is `a_type' a valid type according to current criterion?
		do
			Result :=
				a_type = class_supplier_relation or
				a_type = class_indirect_supplier_relation
		ensure then
			good_result:
				Result implies (
					a_type = class_supplier_relation or
					a_type = class_indirect_supplier_relation)
		end

feature{NONE} -- Implementation

	find_supplier_classes (a_class_c: CLASS_C) is
			-- Find all supplier of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		local
			l_list: LIST [CLASS_C]
			l_candidate_class_list: like candidate_class_list
			l_class_c: CLASS_C
			l_source_id: INTEGER
		do
			l_list := a_class_c.suppliers.classes
			if not l_list.is_empty then
				l_candidate_class_list := candidate_class_list
				l_source_id := a_class_c.class_id
				from
					l_list.start
				until
					l_list.after
				loop
					l_class_c := l_list.item
					if l_class_c.class_id /= l_source_id then
						l_candidate_class_list.put (l_class_c, l_class_c.class_id)
					end
					l_list.forth
				end
			end
		end

	find_indirect_supplier_classes (a_class_c: CLASS_C) is
			-- Find indirect supplier of `a_class_c' and put them in `candidate_class_list' and `candidate_class_table'.
		local
			l_clients: LIST [CLASS_C]
		do
			l_clients := a_class_c.suppliers.classes
			if not l_clients.is_empty then
				from
					l_clients.start
				until
					l_clients.after
				loop
					find_supplier_classes (l_clients.item)
					l_clients.forth
				end
			end
		end

feature{NONE} -- Implementation

	finder_agent_table: HASH_TABLE [PROCEDURE [ANY, TUPLE [CLASS_C]], QL_CLASS_CLIENT_RELATION] is
			-- Table for finders of certain kind of class supplier (supplier, indirect supplier) relation.
			-- Key is class ancestor relation, value is the finder agent associated to the relation.
		do
			if internal_finder_agent_table = Void then
				create internal_finder_agent_table.make (2)
				internal_finder_agent_table.put (agent find_supplier_classes, class_supplier_relation)
				internal_finder_agent_table.put (agent find_indirect_supplier_classes, class_indirect_supplier_relation)
			end
			Result := internal_finder_agent_table
		end

	internal_finder_agent_table: like finder_agent_table;
			-- Implementation of `finder_agent_table'

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
