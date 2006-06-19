indexing
	description: "Criterion to test if a feature is of certain return type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_RETURN_TYPE_IS_CRI

inherit
	QL_FEATURE_DOMAIN_CRITERION

	COMPILER_EXPORTER

	QL_UTILITY

create
	make

feature -- Evaluate

	is_satisfied_by (a_item: like item_type): BOOLEAN is
			-- Evaluate `a_item'.
		local
			l_type_table: like return_types
		do
			if a_item.is_real_feature then
				if a_item.e_feature.type /= Void then
					if not is_criterion_domain_evaluated then
						initialize_domain
					end
					Result := return_types.has (return_type (a_item.e_feature).class_id)
				end
			end
		end

feature{NONE} -- Implementation

	return_type (a_feature: E_FEATURE): CLASS_C is
			-- Return type of `a_feature'
		require
			a_feature_attached: a_feature /= Void
			a_feature_is_query: a_feature.type /= Void
		do
			Result := actual_type_from_type_a (a_feature.associated_class, a_feature.type)
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	initialize_domain is
			-- Prepare clients defined `criterion_domain'.
		local
			l_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_class_domain: QL_CLASS_DOMAIN
			l_types: like return_types
			l_class_c: CLASS_C
		do
			create l_domain_generator.make (class_criterion_factory.simple_criterion_with_index (
					class_criterion_factory.c_is_compiled), True)
			l_class_domain ?= criterion_domain.new_domain (l_domain_generator)
			create l_types.make (l_class_domain.count)

			from
				l_class_domain.start
			until
				l_class_domain.after
			loop
				l_class_c := l_class_domain.item.class_c
				check l_class_c /= Void end
				l_types.force (l_class_c.class_id)
				l_class_domain.forth
			end
			return_types := l_types
			is_criterion_domain_evaluated := True
		ensure then
			return_type_table_classes_attached: return_types /= Void
			criterion_domain_evaluated: is_criterion_domain_evaluated
		end

	return_types: DS_HASH_SET [INTEGER];
			-- Set of return types found in `criterion_domain'
			-- Key is class id

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
