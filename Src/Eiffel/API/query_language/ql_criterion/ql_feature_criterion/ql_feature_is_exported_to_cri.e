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
	QL_FEATURE_CRITERION

feature{NONE} -- Initialization

	make (a_domain: like criterion_domain) is
			-- Initialize `criterion_domain' with `a_feature'.
		require
			a_domain_attached: a_domain /= Void
		do
			set_criterion_domain (a_domain)
		ensure
			criterion_domain_set: criterion_domain = a_domain
		end

feature -- Access

	criterion_domain: QL_DOMAIN
			-- Criterion domain from which `intrinsic_domain' are evaluated

feature -- Setting

	set_criterion_domain (a_domain: QL_DOMAIN) is
			-- Set `criterion_domain' with `a_domain'
		require
			a_domain_attached: a_domain /= Void
		local
			l_delayed_domain: QL_DELAYED_DOMAIN
		do
			criterion_domain := a_domain
			if not criterion_domain.is_delayed then
				prepare_clients
			else
				l_delayed_domain ?= a_domain
				check l_delayed_domain /= Void end
				l_delayed_domain.actions.extend (agent prepare_clients)
			end
		ensure
			criterion_domain_set: criterion_domain = a_domain
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_FEATURE): BOOLEAN is
			-- Evaluate `a_item'.
		local
			l_client: like client_classes
		do
			if a_item.is_real_feature then
				check client_classes /= Void end
				l_client := client_classes
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

	prepare_clients is
			-- Prepare clients defined `criterion_domain'.
		local
			l_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_criterion: QL_CLASS_IS_COMPILED_CRI
		do
			create l_criterion
			create l_domain_generator
			l_domain_generator.set_criterion (l_criterion)
			l_domain_generator.enable_fill_domain
			client_classes ?= criterion_domain.new_domain (l_domain_generator)
		ensure
			client_classes_attached: client_classes /= Void
		end

	client_classes: QL_CLASS_DOMAIN
			-- Client class domain

invariant
	criterion_domain_attached: criterion_domain /= Void

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
