note
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
		undefine
			process,
			item_type
		redefine
			is_atomic,
			set_source_domain,
			set_used_in_domain_generator
		end

feature{NONE} -- Initialization

	make (a_left: like left; a_right: like right)
			-- Initialize `left' with `a_left' and `right' with `a_right'.
		require
			a_left_attached: a_left /= Void
			a_right_attached: a_right /= Void
		do
			set_left (a_left)
			set_right (a_right)
		end

feature -- Criterion

	left: QL_CRITERION
	right: QL_CRITERION
			-- Criteria to which binary operation is applied

feature -- Setting

	set_left (a_cri: like left)
			-- Set `left' with `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		do
			left := a_cri
		ensure
			first_set: left = a_cri
		end

	set_right (a_cri: like right)
			-- Set `right' with `a_cri'.
		require
			a_cri_attached: a_cri /= Void
		do
			right := a_cri
		ensure
			second_set: right = a_cri
		end

	set_source_domain (a_domain: like source_domain)
			-- Set `source_domain' with `a_domain'.
		do
			Precursor (a_domain)
			left.set_source_domain (a_domain)
			right.set_source_domain (a_domain)
		ensure then
			current_domain_set_recursively: left.source_domain = right.source_domain and left.source_domain = source_domain
		end

feature{QL_DOMAIN_GENERATOR, QL_CRITERION} -- Setting

	set_used_in_domain_generator (a_domain_generator: QL_DOMAIN_GENERATOR)
			-- Set `used_in_domain_generator' with
			-- If `a_domain_generator' is Void, current `used_in_domain_generator' will be removed.
		do
			used_in_domain_generator := a_domain_generator
			left.set_used_in_domain_generator (a_domain_generator)
			right.set_used_in_domain_generator (a_domain_generator)
		ensure then
			left_used_in_domain_generator_set: left.used_in_domain_generator = a_domain_generator
			right_used_in_domain_generator_set: right.used_in_domain_generator = a_domain_generator
		end

feature -- Status report

	is_atomic: BOOLEAN = False
			-- Is current criterion atomic?

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR)
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_binary_criterion (Current)
		end

invariant
	first_attached: left /= Void
	second_attached: right /= Void

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
