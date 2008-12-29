note
	description: "Object that represents a binary AND criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_AND_CRITERION

inherit
	QL_BINARY_CRITERION
		undefine
			process
		redefine
			has_inclusive_intrinsic_domain,
			has_exclusive_intrinsic_domain
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR)
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_and_criterion (Current)
		end

feature -- Status report

	has_inclusive_intrinsic_domain: BOOLEAN
			-- Does current criterion has a domain by default?
		do
				-- If one of `left' and `right' (and two of course) has inclusive intrinsic domain,
				-- then current "AND" criterion has inclusive intrinsic domain. And there are three cases:
				-- 1. Both `left' and `right' has inclusive intrinsic domain
				--							and
				--						   /   \
				--						  /     \
				--					i (A)		 i (B)
				-- 		i (A) stands for inclusive intrinsic domain which is A
				-- 		i (B) stands for inclusive intrinsic domain which is B
				-- 		Result inclusive intrinsic domain is A intersect B
				--
				-- 2. In `left' and `right', one has inclusive intrinsic domain and the other has
				--    exclusive intrinsic domain, for example,
				--							and
				--						   /   \
				--						  /     \
				--					i (A)		 e (B)
				-- 		i (A) stands for inclusive intrinsic domain which is A
				-- 		e (B) stands for exclusive intrinsic domain which is B
				-- 		Result inclusive intrinsic domain is A minus B
				--
				-- 3. In `left' and `right', one has inclusive intrinsic domain and the other has
				--    no intrinsic domain, for example,
				--							and
				--						   /   \
				--						  /     \
				--					i (A)		 n
				-- 		i (A) stands for inclusive intrinsic domain which is A
				-- 		n stands for no intrinsic domain
				-- 		Result inclusive intrinsic domain is A filtered by `right'
			Result := left.has_inclusive_intrinsic_domain or else right.has_inclusive_intrinsic_domain
		ensure then
			good_result: Result implies (left.has_inclusive_intrinsic_domain or else right.has_inclusive_intrinsic_domain)
		end

	has_exclusive_intrinsic_domain: BOOLEAN
			-- Does current criterion has an exclusive intrinsic domain?
		do
				-- If both `left' and `right' has exclusive intrinsic domain, then
				-- current "AND" criterion has exclusive intrinsic domain.
				--							and
				--						   /   \
				--						  /     \
				--					e (A)		 e (B)
				-- 		e (A) stands for exclusive intrinsic domain which is A
				-- 		e (B) stands for exclusive intrinsic domain which is B
				-- 		Result exclusive intrinsic domain is A union B
			Result := left.has_exclusive_intrinsic_domain and then right.has_exclusive_intrinsic_domain
		ensure then
			good_result: Result implies (left.has_exclusive_intrinsic_domain and then right.has_exclusive_intrinsic_domain)
		end

feature{NONE} -- Implementation

	intrinsic_domain_internal: like intrinsic_domain
			-- Intrinsic domain
		require
			intrinsic_domain_exists: has_intrinsic_domain
		local
			l_minuend_domain: like intrinsic_domain
			l_subtrahend_domain: like intrinsic_domain
			l_source_domain: like intrinsic_domain
			l_filter_cri: QL_CRITERION
			l_old_used_in_domain_generator: QL_DOMAIN_GENERATOR
		do
				-- For inclusive intrinsic domain
			if has_inclusive_intrinsic_domain then
				if
					left.has_inclusive_intrinsic_domain and then
					right.has_inclusive_intrinsic_domain
				then
						-- Case 1. see comments in `has_inclusive_intrinsic_domain'
					Result := left.intrinsic_domain.intersect (right.intrinsic_domain)
				elseif
					(left.has_inclusive_intrinsic_domain and then right.has_exclusive_intrinsic_domain) or
					(left.has_exclusive_intrinsic_domain and then right.has_inclusive_intrinsic_domain)
				then
						-- Case 2. see comments in `has_inclusive_intrinsic_domain'
					if left.has_inclusive_intrinsic_domain then
						l_minuend_domain := left.intrinsic_domain
						l_subtrahend_domain := right.intrinsic_domain
					else
						l_minuend_domain := right.intrinsic_domain
						l_subtrahend_domain := left.intrinsic_domain
					end
					Result := l_minuend_domain.minus (l_subtrahend_domain)
				elseif
					(left.has_inclusive_intrinsic_domain and then not right.has_intrinsic_domain) or
					(not left.has_intrinsic_domain and then right.has_inclusive_intrinsic_domain)
				then
						-- Case 3. see comments in `has_inclusive_intrinsic_domain'
					if left.has_inclusive_intrinsic_domain then
						l_source_domain := left.intrinsic_domain
						l_filter_cri := right
					else
						l_source_domain := right.intrinsic_domain
						l_filter_cri := left
					end
					l_old_used_in_domain_generator := l_filter_cri.used_in_domain_generator
					l_filter_cri.set_used_in_domain_generator (Void)
					Result ?= l_source_domain.new_domain (l_filter_cri.domain_generator (True, True))
					check Result /= Void end
					l_filter_cri.set_used_in_domain_generator (l_old_used_in_domain_generator)
				end
			elseif has_exclusive_intrinsic_domain then
					-- For exclusive intrinsic domain
					-- See comments in `has_exclusive_intrinsic_domain'
				Result := left.intrinsic_domain.union (right.intrinsic_domain)
			end
		ensure
			result_attached: Result /= Void
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
