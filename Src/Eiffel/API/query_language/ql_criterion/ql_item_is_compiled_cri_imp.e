note
	description: "Object that represents a criterion to decide whether or not an item is compiled"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_ITEM_IS_COMPILED_CRI_IMP

inherit
	QL_CRITERION_ADAPTER
		undefine
			process
		redefine
			has_inclusive_intrinsic_domain,
			has_exclusive_intrinsic_domain
		end

feature -- Status report

	require_compiled: BOOLEAN = True
			-- Does current criterion require a compiled item?

	has_inclusive_intrinsic_domain: BOOLEAN
			-- Does current criterion has a domain by default?
		do
			Result := wrapped_criterion.has_inclusive_intrinsic_domain
		ensure then
			good_result: Result implies wrapped_criterion.has_inclusive_intrinsic_domain
		end

	has_exclusive_intrinsic_domain: BOOLEAN
			-- Does current criterion has an exclusive intrinsic domain?
		do
			Result := wrapped_criterion.has_exclusive_intrinsic_domain
		ensure then
			good_result: Result implies wrapped_criterion.has_exclusive_intrinsic_domain
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR)
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_compiled_imp_criterion (Current)
		end

feature{NONE} -- Implementation

	fill_intrinsic_domain (a_source_domain, a_dest_domain: like intrinsic_domain)
			-- Fill compiled items in `a_source_domain' into `a_dest_domain'.
		require
			a_source_domain_attached: a_source_domain /= Void
			a_dest_domain_attached: a_dest_domain /= Void
		local
			l_source_content: LIST [like item_type]
			l_dest_content: LIST [like item_type]
			l_cursor: CURSOR
			l_item: like item_type
		do
			l_source_content := a_source_domain.content
			l_dest_content := a_dest_domain.content
			l_cursor := l_source_content.cursor
			from
				l_source_content.start
			until
				l_source_content.after
			loop
				l_item := l_source_content.item
				if l_item.is_compiled then
					l_dest_content.extend (l_item)
				end
				l_source_content.forth
			end
			l_source_content.go_to (l_cursor)
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
