indexing
	description: "Object that represents a feature argument domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ARGUMENT_DOMAIN

inherit
	QL_DOMAIN
		undefine
			copy,
			is_equal
		redefine
			content,
			item_type
		end

	LINKED_LIST [QL_ARGUMENT]

create
	make

feature -- Access

	content: LIST [QL_ARGUMENT] is
			-- Content of current domain
		do
			Result := Current
		ensure then
			good_result: Result = Current
		end

	scope: QL_SCOPE is
			-- Scope of current domain			
		do
			Result := argument_scope
		ensure then
			good_result: Result = argument_scope
		end

feature -- Set operation

	union (other: like Current): like Current is
			-- An new domain containing all the elements from both `Current' and `other'.
		do
			create Result.make
			internal_union (Result, other)
		end


	intersect (other: like Current): like Current is
			-- A new domain containing all the elements that are in both `Current' and `other'.
		do
			create Result.make
			internal_intersect (Result, other)
		end

	minus (other: like Current): like Current is
			-- A new domain containing all the elements of `Current', with the elements from `other' removed.
		do
			create Result.make
			internal_complement (Result, other)
		end

feature{QL_CRITERION} -- Implementation for default criterion domain	

	class_item_from_current_domain (a_class: CONF_CLASS): QL_CLASS is
			-- If `a_class' is included in current domain, return the item,
			-- otherwise return Void.
		do
			-- This feature will alwarys return Void because there is no class item
			-- in a argument domain.
		end

	feature_item_from_current_domain (e_feature: E_FEATURE): QL_FEATURE is
			-- If `e_feature' is included in current domain, return the item,
			-- otherwise return Void.
		do
			-- This feature will alwarys return Void because there is no feature item
			-- in a argument domain.
		end

	invariant_item_from_current_domain (a_class_c: CLASS_C): QL_FEATURE is
			-- If invariant part of `a_class_c' is included in current domain,
			-- then return an QL_FEATURE object representing this invariant part, otherwise,
			-- return Void.
		do
			-- This feature will alwarys return Void because there is no invariant item
			-- in a argument domain.
		end

feature{NONE} -- Type ancher

	item_type: QL_ARGUMENT;
			-- Anchor type for items in current domain		

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
