note
	description: "Iterator to go through every node of a criterion and do nothing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CRITERION_ITERATOR

inherit
	QL_CRITERION_VISITOR

feature -- Process

	process_criterion_item (a_item: QL_CRITERION)
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.process (Current)
		end

feature{NONE} -- Process

	process_criterion (a_cri: QL_CRITERION)
			-- Process `a_cri'.
		do
		end

	process_binary_criterion (a_cri: QL_BINARY_CRITERION)
			-- Process `a_cri'.
		do
			a_cri.left.process (Current)
			a_cri.right.process (Current)
		end

	process_unary_criterion (a_cri: QL_UNARY_CRITERION)
			-- Process `a_cri'.
		do
			a_cri.wrapped_criterion.process (Current)
		end

	process_not_criterion (a_cri: QL_NOT_CRITERION)
			-- Process `a_cri'.
		do
			process_unary_criterion (a_cri)
		end

	process_and_criterion (a_cri: QL_AND_CRITERION)
			-- Process `a_cri'.
		do
			process_binary_criterion (a_cri)
		end

	process_or_criterion (a_cri: QL_OR_CRITERION)
			-- Process `a_cri'.
		do
			process_binary_criterion (a_cri)
		end

	process_criterion_adapter (a_cri: QL_CRITERION_ADAPTER)
			-- Process `a_cri'.
		do
			a_cri.wrapped_criterion.process (Current)
		end

	process_compiled_imp_criterion (a_cri: QL_ITEM_IS_COMPILED_CRI_IMP)
			-- Process `a_cri'.
		do
			process_criterion_adapter (a_cri)
		end

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION)
			-- Process `a_cri'.
		do
		end

	process_domain_criterion (a_cri: QL_DOMAIN_CRITERION)
			-- Process `a_cri'.
		do
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
