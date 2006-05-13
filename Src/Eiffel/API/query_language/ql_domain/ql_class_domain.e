indexing
	description: "Object that represents a class domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_DOMAIN

inherit
	QL_DOMAIN
		undefine
			copy,
			is_equal
		redefine
			content,
			item_type
		end

	LINKED_LIST [QL_CLASS]

create
	make

feature -- Access

	content: LIST [QL_CLASS] is
			-- Content of current domain
		do
			Result := Current
		ensure then
			good_result: Result = Current
		end

	scope: QL_SCOPE is
			-- Scope of current domain			
		do
			Result := class_scope
		ensure then
			good_result: Result = class_scope
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
		local
			l_cursor: CURSOR
			l_group: CONF_GROUP
			done: BOOLEAN
		do
			l_cursor := cursor
			from
				start
			until
				after or Result /= Void
			loop
				if item.conf_class = a_class then
					Result := item
				end
				forth
			end
			if l_cursor /= Void and then valid_cursor (l_cursor) then
				go_to (l_cursor)
			end
		end

	feature_item_from_current_domain (e_feature: E_FEATURE): QL_FEATURE is
			-- If `e_feature' is included in current domain, return the item,
			-- otherwise return Void.
		local
			l_class: QL_CLASS
			l_cursor: CURSOR
			l_feature_table: E_FEATURE_TABLE
		do
			l_cursor := cursor
			from
				start
			until
				after or Result /= Void
			loop
				l_feature_table := item.class_c.api_feature_table
				if l_feature_table.has (e_feature.name) then
					create {QL_REAL_FEATURE}Result.make_with_parent (l_feature_table.item (e_feature.name), item)
				end
				forth
			end
			if l_cursor /= Void then
				go_to (l_cursor)
			end
		end

	invariant_item_from_current_domain (a_class_c: CLASS_C): QL_FEATURE is
			-- If invariant part of `a_class_c' is included in current domain,
			-- then return an QL_FEATURE object representing this invariant part, otherwise,
			-- return Void.
		local
			l_class: QL_CLASS
			l_cursor: CURSOR
			l_class_c: CLASS_C

		do
			l_cursor := cursor
			from
				start
			until
				after or Result /= Void
			loop
				l_class_c := item.class_c
				if l_class_c.has_invariant and then l_class_c.class_id = a_class_c.class_id then
					create {QL_INVARIANT}Result.make_with_parent (item.class_c, item.class_c, item)
				end
				forth
			end
			if l_cursor /= Void then
				go_to (l_cursor)
			end
		end

feature{NONE} -- Type ancher

	item_type: QL_CLASS;
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
