note
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
			item_type,
			domain_generator,
			is_class_domain
		end

	LINKED_LIST [QL_CLASS]

create
	make

feature -- Access

	content: LIST [QL_CLASS]
			-- Content of current domain
		do
			Result := Current
		ensure then
			good_result: Result = Current
		end

	scope: QL_SCOPE
			-- Scope of current domain			
		do
			Result := class_scope
		ensure then
			good_result: Result = class_scope
		end

	domain_generator: QL_CLASS_DOMAIN_GENERATOR
			-- Domain generator which can generate domains of same type as Current domain
		do
			create Result
		end

feature -- Status report

	is_class_domain: BOOLEAN
			-- Is current a class domain?
		do
			Result := True
		end

feature -- Set operation

	union (other: like Current): like Current
			-- An new domain containing all the elements from both `Current' and `other'.
		do
			create Result.make
			internal_union (Result, other)
		end

	intersect (other: like Current): like Current
			-- A new domain containing all the elements that are in both `Current' and `other'.
		do
			create Result.make
			internal_intersect (Result, other)
		end

	minus (other: like Current): like Current
			-- A new domain containing all the elements of `Current', with the elements from `other' removed.
		do
			create Result.make
			internal_complement (Result, other)
		end

	distinct: like Current
			-- A new domain which only contain distinct items in Current		
		do
			create Result.make
			internal_distinct (Result)
		end

feature{QL_CRITERION} -- Implementation for default criterion domain		

	class_item_from_current_domain (a_class: CONF_CLASS): QL_CLASS
			-- If `a_class' is included in current domain, return the item,
			-- otherwise return Void.
		local
			l_cursor: CURSOR
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
--			if Result = Void then
--				Result := query_class_item_from_conf_class (a_class)
--				Result.set_visible (False)
--			end
			if l_cursor /= Void and then valid_cursor (l_cursor) then
				go_to (l_cursor)
			end
		end

	feature_item_from_current_domain (e_feature: E_FEATURE): QL_FEATURE
			-- If `e_feature' is included in current domain, return the item,
			-- otherwise return Void.
		local
			l_cursor: CURSOR
			l_feature_table: E_FEATURE_TABLE
		do
			l_cursor := cursor
			from
				start
			until
				after or Result /= Void
			loop
				if
					item.class_c /= Void and then
					item.class_c.class_id = e_feature.associated_class.class_id
				then
					l_feature_table := item.class_c.api_feature_table
					if l_feature_table.has (e_feature.name) then
						create {QL_REAL_FEATURE}Result.make_with_parent (l_feature_table.item (e_feature.name), item)
					end
				end
				forth
			end
			if l_cursor /= Void then
				go_to (l_cursor)
			end
		end

	invariant_item_from_current_domain (a_class_c: CLASS_C): QL_FEATURE
			-- If invariant part of `a_class_c' is included in current domain,
			-- then return an QL_FEATURE object representing this invariant part, otherwise,
			-- return Void.
		local
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
