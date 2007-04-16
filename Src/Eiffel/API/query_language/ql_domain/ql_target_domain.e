indexing
	description: "Object that represents a target domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_TARGET_DOMAIN

inherit
	QL_DOMAIN
		undefine
			copy,
			is_equal
		redefine
			content,
			item_type,
			prepare_before_new_domain_generation,
			cleanup_after_new_domain_generation,
			domain_generator,
			is_target_domain,
			clear_cache
		end

	LINKED_LIST [QL_TARGET]

create
	make

feature -- Access

	content: LIST [QL_TARGET] is
			-- Content of current domain
		do
			Result := Current
		ensure then
			good_result: Result = Current
		end

	scope: QL_SCOPE is
			-- Scope of current domain			
		do
			Result := target_scope
		ensure then
			good_result: Result = target_scope
		end

	domain_generator: QL_TARGET_DOMAIN_GENERATOR is
			-- Domain generator which can generate domains of same type as Current domain
		do
			create Result
		end

feature -- Removal

	clear_cache is
			-- Clear cache information.
			-- cache information is used for optimization.
		do
			if not class_table.is_empty then
				class_table.wipe_out
			end
		end

feature -- Status report

	is_target_domain: BOOLEAN is
			-- Is current a target domain?
		do
			Result := True
		end

feature -- Preparation and cleanup

	prepare_before_new_domain_generation is
			-- Prepare before new domain generation.
		do
			Precursor
			clear_cache
		ensure then
			class_table_is_empty: class_table.is_empty
		end

	cleanup_after_new_domain_generation is
			-- Clean up after new domain generation.
		do
			Precursor
			clear_cache
		ensure then
			class_table_is_empty: class_table.is_empty
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

	distinct: like Current is
			-- A new domain which only contain distinct items in Current		
		do
			create Result.make
			internal_distinct (Result)
		end

feature{QL_CRITERION} -- Implementation for default criterion domain

	class_item_from_current_domain (a_class: CONF_CLASS): QL_CLASS is
			-- If `a_class' is included in current domain, return the item,
			-- otherwise return Void.
		local
			l_cursor: CURSOR
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
			l_target: like item
			l_class_table: like class_table
			l_conf_group: CONF_GROUP
			l_found: BOOLEAN
			l_library: CONF_LIBRARY
			l_used_in_libraries: LIST [CONF_LIBRARY]
		do
			l_cursor := cursor
			from
				start
				check class_table /= Void end
				l_class_table := class_table
			until
				after or Result /= Void
			loop
				l_target := item
				l_groups := l_target.target.groups
				if not l_groups.is_empty then
					from
						l_groups.start
					until
						l_groups.after or Result /= Void
					loop
						l_conf_group := l_groups.item_for_iteration
						if l_conf_group.is_library then
							l_used_in_libraries := a_class.group.target.system.used_in_libraries
							if l_used_in_libraries /= Void then
								l_library ?= l_conf_group
								l_found := l_used_in_libraries.has (l_library)
							else
								l_found := False
							end
						else
							l_found := l_conf_group = a_class.group
						end
						if l_found then
							Result := class_from_group (a_class, query_group_item_from_conf_group (l_conf_group), l_class_table)
						end
						l_groups.forth
					end
				end
				forth
			end
			if l_cursor /= Void then
				go_to (l_cursor)
			end
		end

	feature_item_from_current_domain (e_feature: E_FEATURE): QL_FEATURE is
			-- If `e_feature' is included in current domain, return the item,
			-- otherwise return Void.
		local
			l_class: QL_CLASS
		do
			l_class := class_item_from_current_domain (e_feature.associated_class.lace_class.config_class)
			if l_class /= Void and then l_class.is_compiled then
				create {QL_REAL_FEATURE}Result.make_with_parent (e_feature, l_class)
			end
		end

	invariant_item_from_current_domain (a_class_c: CLASS_C): QL_FEATURE is
			-- If invariant part of `a_class_c' is included in current domain,
			-- then return an QL_FEATURE object representing this invariant part, otherwise,
			-- return Void.
		local
			l_class: QL_CLASS
			l_class_c: CLASS_C
		do
			l_class := class_item_from_current_domain (a_class_c.lace_class.config_class)
			if l_class /= Void and then l_class.is_compiled then
				l_class_c := l_class.class_c
				if l_class_c.has_invariant then
					create {QL_INVARIANT}Result.make_with_parent (l_class_c, l_class_c, l_class)
				end
			end
		end

feature{NONE} -- Type ancher

	class_table: HASH_TABLE [HASH_TABLE [QL_CLASS, CONF_CLASS], CONF_GROUP] is
			-- Table of classes in a group.
			-- Key is the group, value is a hash table containing all classes in that group.
		do
			if class_table_internal = Void then
				create class_table_internal.make (10)
			end
			Result := class_table_internal
		ensure
			result_attached: Result /= Void
		end

	class_table_internal: like class_table
			-- Implementation of `class_table'

	item_type: QL_TARGET;
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
