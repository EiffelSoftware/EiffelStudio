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
			create feature_list_table.make_map_default
			create priority_table.make_default
			create tester.make
			priority_table.set_key_equality_tester (tester)
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
			pair: DS_PAIR [INTEGER, INTEGER]
			list: DS_LINKED_LIST [AUT_FEATURE_OF_TYPE]
		do
			priority_table.search (a_feature)
			if priority_table.found then
				priority_table.found_item.put_first (a_priority)
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
			feature_: AUT_FEATURE_OF_TYPE
			class_: CLASS_C
			feature_i: FEATURE_I
			l_feat_table: FEATURE_TABLE
			l_any_class: CLASS_C
		do
			l_any_class := system.any_class.compiled_class
			class_ := a_type.associated_class
			l_feat_table := class_.feature_table
			from
				l_feat_table.start
			until
				l_feat_table.after
			loop
				feature_i := l_feat_table.item_for_iteration
				if not feature_i.is_prefix and then not feature_i.is_infix then
						-- Normal exported features.
					if feature_i.export_status.is_exported_to (l_any_class) then
						register_feature (feature_i, a_type, False, a_priority)
					end

						-- For creators: If current feature is an exported creator, we add it.
						-- It is possible that a feature can be used as both normal feature and creator.
						-- In such cases, there will be two entries in `priority_table' and `feature_list_table',
						-- one as normal feature and one as creator.
						-- This way, classes with a single feature, which is a creator can be tested.
					if is_exported_creator (feature_i, a_type) then
						register_feature (feature_i, a_type, True, a_priority)
					end
				end
				l_feat_table.forth
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
				priority_table.found_item.put_second (new_priority)
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
					list.force_last (a_feature)
					feature_list_table.force (list, new_priority)
				end
			end
			if highest_dynamic_priority = 0 then
				reset_dynamic_priorities
			end
		end

feature {NONE} -- Implementation

	feature_list_table: DS_HASH_TABLE [DS_LINKED_LIST [AUT_FEATURE_OF_TYPE], INTEGER]
			-- Table that maps dynamic priorities to lists of features

	priority_table: DS_HASH_TABLE [DS_PAIR [INTEGER, INTEGER], AUT_FEATURE_OF_TYPE]
			-- Table that maps features to their priorities (static, dynamic)

	reset_dynamic_priorities
			-- Reset the dynamic priorities of all
			-- features to their static value.
		local
			cs: DS_HASH_TABLE_CURSOR [DS_PAIR [INTEGER, INTEGER], AUT_FEATURE_OF_TYPE]
			old_priority: INTEGER
			new_priority: INTEGER
			feature_: AUT_FEATURE_OF_TYPE
			list: DS_LINKED_LIST [AUT_FEATURE_OF_TYPE]
		do
			from
				cs := priority_table.new_cursor
				cs.start
			until
				cs.off
			loop
				new_priority := cs.item.first
				old_priority := cs.item.second
				feature_ := cs.key
				cs.item.put_second (new_priority)
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
					list.force_last (feature_)
					feature_list_table.force (list, new_priority)
				end
				cs.forth
			end
			set_highest_priority
		end

	set_highest_priority
			-- Set `highest_dynamic_priority' to the highest priority value
			-- found in `feature_list_table'.
		local
			cs: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [AUT_FEATURE_OF_TYPE], INTEGER]
		do
			from
				highest_dynamic_priority := 0
				cs := feature_list_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.key > highest_dynamic_priority then
					highest_dynamic_priority := cs.key
				end
				cs.forth
			end
		end

	register_feature (a_feature: FEATURE_I; a_type: TYPE_A; a_creator: BOOLEAN; a_priority: INTEGER) is
			-- Register `a_feature' declared in `a_type' to be a test candidate.
			-- `a_creator' indicates if `a_feature' should be registered as a creator.
			-- `a_priority' is the priority under which `a_feature' should be tested.
		require
			a_feature_attached: a_feature /= Void
			a_type_attached: a_type /= Void
			a_priority_valid: a_priority >= 0
		local
			feature_: AUT_FEATURE_OF_TYPE
			feature_i: FEATURE_I
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

	is_exported_creator (a_feature: FEATURE_I; a_type: TYPE_A): BOOLEAN is
			-- Is `a_feature' declared in `a_type' a creator which is exported to all classes?
		require
			a_feature_attached: a_feature /= Void
			a_type_attached: a_type /= Void
		local
			l_class: CLASS_C
		do
			if
				a_type.has_associated_class and then
				a_type.associated_class.creators /= Void and then
				a_type.associated_class.creators.has (a_feature.feature_name)
			then
				Result := a_type.associated_class.creators.item (a_feature.feature_name).is_all
			end

			if a_type.has_associated_class then
				l_class := a_type.associated_class

				if l_class.creators /= Void and then l_class.creators.has (a_feature.feature_name) then
						-- For normal creators.
					Result := l_class.creators.item (a_feature.feature_name).is_all

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
		local
			cs: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [AUT_FEATURE_OF_TYPE], INTEGER]
		do
			from
				Result := True
				cs := feature_list_table.new_cursor
				cs.start
			until
				cs.off or not Result
			loop
				if cs.key > highest_dynamic_priority then
					Result := False
				end
				cs.forth
			end
			cs.go_after
		end

	are_tables_valid: BOOLEAN
			-- Are the tables `feature_list_table' and `priority_table'
			-- synchronized?
		local
			table_cs: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [AUT_FEATURE_OF_TYPE], INTEGER]
			list_cs: DS_LINKED_LIST_CURSOR [AUT_FEATURE_OF_TYPE]
		do
			from
				Result := True
				table_cs := feature_list_table.new_cursor
				table_cs.start
			until
				table_cs.off or not Result
			loop
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
				table_cs.forth
			end
			table_cs.go_after
		end

invariant

	system_attached: system /= Void
	feature_list_table_not_void: feature_list_table /= Void
	priority_table_not_void: priority_table /= Void
	highest_priority_valid: is_highest_priority_valid
	tables_valid: are_tables_valid

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
