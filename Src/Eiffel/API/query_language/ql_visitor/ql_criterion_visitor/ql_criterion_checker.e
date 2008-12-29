note
	description: "Query lanaguage criterion checker to check if a givn criterion has certain characteristics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CRITERION_CHECKER

inherit
	ANY

	QL_CRITERION_ITERATOR
		export
			{NONE} all
		redefine
			process_intrinsic_domain_criterion,
			process_domain_criterion
		end

feature -- Checking

	check_criterion (a_criterion: QL_CRITERION)
			-- Check `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			init
			process_criterion_item (a_criterion)
		end

feature -- Status report

	has_delayed_domain: BOOLEAN
			-- Does given criterion use delayed domain?

feature{NONE} -- Implementation

	init
			-- Initialize before checking.
		do
			has_delayed_domain := False
		end

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION)
			-- Process `a_cri'.
		do
			process_domain_criterion (a_cri)
		end

	process_domain_criterion (a_cri: QL_DOMAIN_CRITERION)
			-- Process `a_cri'.
		local
			l_criterion_domain: QL_DOMAIN
		do
			l_criterion_domain := a_cri.criterion_domain
			if l_criterion_domain /= Void and then l_criterion_domain.is_delayed then
				has_delayed_domain := True
			end
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
