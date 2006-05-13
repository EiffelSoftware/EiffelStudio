indexing
	description: "Object that represents a binary criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_BINARY_CRITERION

inherit
	QL_CRITERION
		redefine
			is_atomic,
			set_source_domain
		end

feature{NONE} -- Initialization

	make (a_first: like first; a_second: like second) is
			-- Initialize `first' with `a_first' and `second' with `a_second'.
		require
			a_first_attached: a_first /= Void
			a_second_attached: a_second /= Void
		do
			set_first (a_first)
			set_second (a_second)
		end

feature -- Criterion

	first: QL_CRITERION
	second: QL_CRITERION
			-- Criteria to which binary operation is applied

feature -- Setting

	set_first (a_cri: like first) is
			-- Set `first' with `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		do
			first := a_cri
		ensure
			first_set: first = a_cri
		end

	set_second (a_cri: like second) is
			-- Set `second' with `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		do
			second := a_cri
		ensure
			second_set: second = a_cri
		end

	set_source_domain (a_domain: like source_domain) is
			-- Set `source_domain' with `a_domain'.
		do
			Precursor (a_domain)
			first.set_source_domain (a_domain)
			second.set_source_domain (a_domain)
		ensure then
			current_domain_set_recursively: first.source_domain = second.source_domain and first.source_domain = source_domain
		end

feature -- Status report

	is_atomic: BOOLEAN is False
			-- Is current criterion atomic?

invariant
	first_attached: first /= Void
	second_attached: second /= Void

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
