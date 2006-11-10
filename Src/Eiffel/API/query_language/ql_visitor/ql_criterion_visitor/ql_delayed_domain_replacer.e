indexing
	description: "[
					Delayed domain replacer.
					It can replace all delayed domains in a given criterion with a new domain.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_DELAYED_DOMAIN_REPLACER

inherit
	QL_CRITERION_ITERATOR
		export
			{NONE} all
		redefine
			process_intrinsic_domain_criterion,
			process_domain_criterion
		end

feature -- Access

	new_domain: QL_DOMAIN
			-- New domain which will replace all delayed domains in given criterion

feature -- Setting

	set_new_domain (a_domain: like new_domain) is
			-- Set `new_domain' with `a_domain'.
		do
			new_domain := a_domain
		ensure
			new_domain_set: new_domain = a_domain
		end

feature -- Replacement

	replace (a_criterion: QL_CRITERION) is
			-- Replace all delayed domains in `a_criterion' by `new_domain'.
		do
			process_criterion_item (a_criterion)
		end

feature{NONE} -- Implementation

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		do
			process_domain_criterion (a_cri)
		end

	process_domain_criterion (a_cri: QL_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		local
			l_old_domain: QL_DOMAIN
		do
			l_old_domain := a_cri.criterion_domain
			if l_old_domain /= Void and then l_old_domain.is_delayed then
				a_cri.set_criterion_domain (new_domain)
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
