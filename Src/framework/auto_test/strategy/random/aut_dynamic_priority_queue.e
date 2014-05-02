note

	description:

		"Priority queue for features of types under test"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_DYNAMIC_PRIORITY_QUEUE

inherit

	AUT_SHARED_RANDOM
		export {NONE} all end

	REFACTORING_HELPER

	INTERNAL_COMPILER_STRING_EXPORTER

create

	make

feature {NONE} -- Initialization

	make (a_system: like system)
			-- Create new queue. By default all features from
			-- `a_system' will have a priority of 0.
		require
			a_system_not_void: a_system /= Void
		local
			tester: AUT_FEATURE_OF_TYPE_EQUALITY_TESTER
		do
			system := a_system
			create feature_list_table.make (10)
			create tester.make
			create priority_table.make_with_key_tester (10, tester)
		ensure
			system_set: system = a_system
		end

feature -- Access

	last_feature: AUT_FEATURE_OF_TYPE
			-- Last selected feature

	system: SYSTEM_I
			-- System

	static_priority (a_feature: AUT_FEATURE_OF_TYPE): INTEGER
			-- Static priority of feature `a_feature'
		require
			a_feature_not_void: a_feature /= Void
		do
			priority_table.search (a_feature)
			if priority_table.found then
				Result := priority_table.found_item.first
			end
		ensure
			priority_valid: Result >= 0
		end

	dynamic_priority (a_feature: AUT_FEATURE_OF_TYPE): INTEGER
			-- Dynamic priority of feature `a_feature'
		require
			a_feature_not_void: a_feature /= Void
		do
			priority_table.search (a_feature)
			if priority_table.found then
				Result := priority_table.found_item.second
			end
		ensure
			priority_valid: Result >= 0
		end

	highest_dynamic_priority: INTEGER
			-- Highest dynamic priority

feature -- Changing Priority

	set_static_priority_of_feature (a_feature: AUT_FEATURE_OF_TYPE; a_priority: INTEGER)
			-- Sets the static priority of `a_feature' to `a_priority'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_is_not_infix_or_prefix: not a_feature.feature_.is_prefix and not a_feature.feature_.is_infix
			a_priority_valid: a_priority >= 0
		local
			pair: PAIR [INTEGER, INTEGER]
			list: DS_LINKED_LIST [AUT_FEATURE_OF_TYPE]
		do
			priority_table.search (a_feature)
			if priority_table.found then
				priority_table.found_item.set_first (a_priority)
			else
				create pair.make (a_priority, a_priority)
				if highest_dynamic_priority < a_priority then
					highest_dynamic_priority := a_priority
				end
				priority_table.force (pair, a_feature)
				feature_list_table.search (a_priority)
				if feature_list_table.found then
					list := feature_list_table.found_item
					check
						feature_not_included: not list.has (a_feature)
					end
					list.force_last (a_feature)
				else
					create list.make_equal
					list.set_equality_tester (create {AUT_FEATURE_OF_TYPE_EQUALITY_TESTER}.make)
					list.force_last (a_feature)
					feature_list_table.force (list, a_priority)
				end
			end
		end

	set_static_priority_of_type (a_type: CL_TYPE_A; a_priority: INTEGER)
			-- Set static priority of all feaures in `a_type' to a
			-- priority `a_priority'. Features of class ANY are ignored. Note
			-- that expanded types are not yet supported.
		require
			a_type_not_void: a_type /= Void
			a_priority_valid: a_priority >= 0
		local
			class_: CLASS_C
			feature_i: FEATURE_I
			l_feat_table: FEATURE_TABLE
			l_any_class: CLASS_C
			l_added: INTEGER
			l_exported_creators: LINKED_LIST [FEATURE_I]
		do
			l_any_class := system.any_class.compiled_class
			class_ := a_type.base_class
			l_feat_table := class_.feature_table
			create l_exported_creators.make
			from
				l_feat_table.start
			until
				l_feat_table.after
			loop
				feature_i := l_feat_table.item_for_iteration
				if
					not feature_i.is_prefix and then
					not feature_i.is_infix and then
					not feature_i.is_obsolete
				then
						-- Normal exported features.
					if feature_i.export_status.is_exported_to (l_any_class) then
						register_feature (feature_i, a_type, False, a_priority)
						if feature_i.written_class /= l_any_class then
							l_added := l_added + 1
						end
					end

					if is_exported_creator (feature_i, a_type) then
						l_exported_creators.extend (feature_i)
					end
				end
				l_feat_table.forth
			end

				-- We added exported features as candidate feature under test when there is
				-- no non-creator feature (except those from ANY) to test in `a_type'.
			if l_added = 0 and then not l_exported_creators.is_empty then
				l_exported_creators.do_all (agent register_feature (?, a_type, True, a_priority))
			end
		end

feature -- Basic routines

	select_next
			-- Select a feature to test and make it available via
			-- `last_feature'.
		require
			selectable: highest_dynamic_priority > 0
		local
			i: INTEGER
			list: DS_LINKED_LIST [AUT_FEATURE_OF_TYPE]
		do
			feature_list_table.search (highest_dynamic_priority)
			check
				found: feature_list_table.found
			end
			list := feature_list_table.found_item
			random.forth
			i := (random.item  \\ list.count) + 1
			last_feature := list.item (i)
		ensure
			last_feature_has_highest_priority: dynamic_priority (last_feature) = highest_dynamic_priority
		end

	mark (a_feature: AUT_FEATURE_OF_TYPE)
			-- Mark `a_feature' as called.
		require
			a_feature_not_void: a_feature /= Void
		local
			old_priority: INTEGER
			new_priority: INTEGER
			list: DS_LINKED_LIST [AUT_FEATURE_OF_TYPE]
		do
			priority_table.search (a_feature)
			if priority_table.found then
				old_priority := priority_table.found_item.second
				new_priority := old_priority - 1
				if new_priority < 0 then
					new_priority := 0
				end
				priority_table.found_item.set_second (new_priority)
				feature_list_table.search (old_priority)
				check
					found: feature_list_table.found
				end
				list := feature_list_table.found_item
				list.delete (a_feature)
				if list.count = 0 then
					feature_list_table.remove (old_priority)
					if highest_dynamic_priority = old_priority then
						highest_dynamic_priority := new_priority
					end
				end
				feature_list_table.search (new_priority)
				if feature_list_table.found then
					feature_list_table.found_item.force_last (a_feature)
				else
					create list.make_equal
					list.set_equality_tester (create {AUT_FEATURE_OF_TYPE_EQUALITY_TESTER}.make)
					list.force_last (a_feature)
					feature_list_table.force (list, new_priority)
				end
			end
			if highest_dynamic_priority = 0 then
				reset_dynamic_priorities
			end
		end

feature {NONE} -- Implementation

	feature_list_table: HASH_TABLE [DS_LINKED_LIST [AUT_FEATURE_OF_TYPE], INTEGER]
			-- Table that maps dynamic priorities to lists of features

	priority_table: HASH_TABLE_EX [PAIR [INTEGER, INTEGER], AUT_FEATURE_OF_TYPE]
			-- Table that maps features to their priorities (static, dynamic)

	reset_dynamic_priorities
			-- Reset the dynamic priorities of all
			-- features to their static value.
		local
			old_priority: INTEGER
			new_priority: INTEGER
			feature_: AUT_FEATURE_OF_TYPE
			list: DS_LINKED_LIST [AUT_FEATURE_OF_TYPE]
		do
			across priority_table as cs loop
				new_priority := cs.item.first
				old_priority := cs.item.second
				feature_ := cs.key
				cs.item.set_second (new_priority)
				feature_list_table.search (old_priority)
				check
					found: feature_list_table.found
				end
				list := feature_list_table.found_item
				list.delete (feature_)
				if list.count = 0 then
					feature_list_table.remove (old_priority)
				end
				feature_list_table.search (new_priority)
				if feature_list_table.found then
					feature_list_table.found_item.force_last (feature_)
				else
					create list.make_equal
					list.set_equality_tester (create {AUT_FEATURE_OF_TYPE_EQUALITY_TESTER}.make)
					list.force_last (feature_)
					feature_list_table.force (list, new_priority)
				end
			end
			set_highest_priority
		end

	set_highest_priority
			-- Set `highest_dynamic_priority' to the highest priority value
			-- found in `feature_list_table'.
		do
			highest_dynamic_priority := 0
			across feature_list_table as cs loop
				if cs.key > highest_dynamic_priority then
					highest_dynamic_priority := cs.key
				end
			end
		end

	register_feature (a_feature: FEATURE_I; a_type: TYPE_A; a_creator: BOOLEAN; a_priority: INTEGER)
			-- Register `a_feature' declared in `a_type' to be a test candidate.
			-- `a_creator' indicates if `a_feature' should be registered as a creator.
			-- `a_priority' is the priority under which `a_feature' should be tested.
		require
			a_feature_attached: a_feature /= Void
			a_type_attached: a_type /= Void
			a_priority_valid: a_priority >= 0
		local
			feature_: AUT_FEATURE_OF_TYPE
		do
			create feature_.make (a_feature, a_type)
			if a_creator then
				feature_.set_is_creator (True)
			end

			if a_feature.written_class.name.is_case_insensitive_equal ("ANY") then
				if a_creator then
						-- If `a_feature' is a creator, even if it comes from {ANY}, we assign a positive priority
						-- so it will be tested by AutoTest.
					set_static_priority_of_feature (feature_, 1)
				else
					set_static_priority_of_feature (feature_, 0)
				end
			else
				set_static_priority_of_feature (feature_, a_priority)
			end
		end

	is_exported_creator (a_feature: FEATURE_I; a_type: TYPE_A): BOOLEAN
			-- Is `a_feature' declared in `a_type' a creator which is exported to all classes?
		require
			a_feature_attached: a_feature /= Void
			a_type_attached: a_type /= Void
		local
			l_class: CLASS_C
		do
			if
				a_type.has_associated_class and then
				a_type.base_class.has_creator_of_name_id (a_feature.feature_name_id)
			then
				Result := a_type.base_class.creator_of_name_id (a_feature.feature_name_id).is_all
			end

			if a_type.has_associated_class then
				l_class := a_type.base_class

				if l_class.has_creator_of_name_id (a_feature.feature_name_id) then
						-- For normal creators.
					Result := l_class.creator_of_name_id (a_feature.feature_name_id).is_all

				elseif l_class.allows_default_creation and then l_class.default_create_feature.feature_name.is_equal (a_feature.feature_name) then
						-- For default creators.
					Result := True
				end
			end
		end

feature {NONE} -- Assertion helpers

	is_highest_priority_valid: BOOLEAN
			-- Is `highest_dynamic_priority' set to the highest priority found
			-- in `feature_list_table'.
		do
			Result := True
			across feature_list_table as cs until not Result loop
				if cs.key > highest_dynamic_priority then
					Result := False
				end
			end
		end

	are_tables_valid: BOOLEAN
			-- Are the tables `feature_list_table' and `priority_table'
			-- synchronized?
		local
			list_cs: DS_LINKED_LIST_CURSOR [AUT_FEATURE_OF_TYPE]
		do
			Result := True
			across feature_list_table as table_cs until not Result loop
				from
					list_cs := table_cs.item.new_cursor
					list_cs.start
				until
					list_cs.off or not Result
				loop
					priority_table.search (list_cs.item)
					if not priority_table.found then
						Result := False
					else
						if
							priority_table.found_item.second /= table_cs.key or
							priority_table.found_item.second > priority_table.found_item.first
						then
							Result := False
						end
					end
					list_cs.forth
				end
				list_cs.go_after
			end
		end

invariant

	system_attached: system /= Void
	feature_list_table_not_void: feature_list_table /= Void
	priority_table_not_void: priority_table /= Void
	highest_priority_valid: is_highest_priority_valid
	tables_valid: are_tables_valid

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
