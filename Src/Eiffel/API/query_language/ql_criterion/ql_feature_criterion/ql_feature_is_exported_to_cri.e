indexing
	description: "Criterion to decide whether or not a feature is exported to a given domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_IS_EXPORTED_TO_CRI

inherit
	QL_FEATURE_DOMAIN_CRITERION

create
	make

feature -- Evaluate

	is_satisfied_by (a_item: QL_FEATURE): BOOLEAN is
			-- Evaluate `a_item'.
		local
			l_client: like clients
		do
			if a_item.is_real_feature then
				if not is_criterion_domain_evaluated then
					initialize_domain
				end
				check clients /= Void end
				l_client := clients
				Result := True
				if not l_client.is_empty then
					from
						l_client.start
					until
						l_client.after or not Result
					loop
						Result := a_item.e_feature.is_exported_to (l_client.item.class_c)
						l_client.forth
					end
				end
			end
		end

feature{NONE} -- Implementation

	initialize_domain is
			-- Prepare clients defined `criterion_domain'.
		local
			l_domain_generator: QL_CLASS_DOMAIN_GENERATOR
		do
			create l_domain_generator.make (class_criterion_factory.simple_criterion_with_index (
					class_criterion_factory.c_is_compiled), True)
			clients ?= criterion_domain.new_domain (l_domain_generator)
			is_criterion_domain_evaluated := True
		ensure then
			client_classes_attached: clients /= Void
		end

	clients: QL_CLASS_DOMAIN;
			-- Client class domain

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
