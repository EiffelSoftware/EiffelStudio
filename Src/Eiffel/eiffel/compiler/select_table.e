indexing
	description: "[
		Selection table:

		Associates routine ids with execution units. At generation time
		the select table leads to one descriptor per associated class type.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SELECT_TABLE

inherit
	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_HISTORY_CONTROL
		undefine
			is_equal, copy
		end

	HASH_TABLE [INTEGER, INTEGER]
		rename
			make as internal_table_make,
			item as internal_table_item,
			item_for_iteration as internal_table_item_for_iteration,
			found_item as internal_table_found_item,
			put as internal_table_put
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER; a_feat_tbl: FEATURE_TABLE) is
			--
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
		do
			internal_table_make (n)
			feature_table := a_feat_tbl
		ensure
			feature_table_set: feature_table = a_feat_tbl
		end

feature -- Access

	feature_table: FEATURE_TABLE
			-- Feature table associated to Current.

feature -- HASH_TABLE like feature

	item (an_id: INTEGER): FEATURE_I is
			-- Item of name ID `an_id'
		require
			an_id_positive: an_id > 0
		local
			l_id: INTEGER
		do
			l_id := internal_table_item (an_id)
			if l_id > 0 then
				Result := feature_table.item_id (l_id)
			end
		end

	item_for_iteration: FEATURE_I is
		local
			l_id: INTEGER
		do
			l_id := internal_table_item_for_iteration
			check l_id > 0 end
			Result := feature_table.item_id (l_id)
		end

	found_item: FEATURE_I is
			--
		local
			l_id: INTEGER
		do
			l_id := internal_table_found_item
			check l_id > 0 end
			Result := feature_table.item_id (l_id)
		end

	put (new: FEATURE_I; key: INTEGER) is
		require
			new_not_void: new /= Void
		do
			internal_table_put (new.feature_name_id, key)
		end

feature -- Element change

	add_feature (a_feat: FEATURE_I) is
			-- Add `a_feat' in Current
		require
			a_feat_not_void: a_feat /= Void
		local
			i, nb, l_name_id: INTEGER
			l_id_set: ROUT_ID_SET
		do
			l_id_set := a_feat.rout_id_set
			nb := l_id_set.count
			l_name_id := a_feat.feature_name_id
			internal_table_put (l_name_id, l_id_set.first)
			if nb > 1 then
				from
					i := 2
				until
					i > nb
				loop
					internal_table_put (l_name_id, l_id_set.item (i))
					i := i + 1
				end
			end
		end

	remove_feature (a_feat: FEATURE_I) is
			-- Add `a_feat' in Current
		require
			a_feat_not_void: a_feat /= Void
		local
			i, nb: INTEGER
			l_id_set: ROUT_ID_SET
		do
			l_id_set := a_feat.rout_id_set
			nb := l_id_set.count
			remove (l_id_set.first)
			if nb > 1 then
				from
					i := 2
				until
					i > nb
				loop
					remove (l_id_set.item (i))
					i := i + 1
				end
			end
		end

feature -- Final mode

	add_units (a_class: CLASS_C) is
			-- Insert units of Current in the history
			-- controler (routine table construction)
		local
			l_table: like feature_table
			l_features: HASH_TABLE [TYPE_FEATURE_I, INTEGER_32]
		do
			from
				l_table := feature_table
				l_table.start
			until
				l_table.after
			loop
				add_feature_unit (a_class.class_id, l_table.item_for_iteration)
				l_table.forth
			end

			l_features := a_class.generic_features
			if l_features /= Void then
				from
					l_features.start
				until
					l_features.after
				loop
					add_feature_unit (a_class.class_id, l_features.item_for_iteration)
					l_features.forth
				end
			end
		end

feature -- Incrementality

	equiv (other: like Current; c: CLASS_C): BOOLEAN is
			-- Incrementality test on the select table in second pass.
		require
			good_argument: other /= Void
		local
			f2: FEATURE_I
			is_freeze_requested: BOOLEAN
		do
			is_freeze_requested := system.is_freeze_requested
				-- At least the counts should be the same.
			from
				start
				Result := other.count = count
			until
				after or else (not Result and then is_freeze_requested)
			loop
				f2 := other.item (key_for_iteration)
				if f2 = Void then
					Result := False
					if not is_freeze_requested and then c.visible_level.is_visible (item_for_iteration, c.class_id) then
							-- Remove references to the old feature in CECIL data.
						system.request_freeze
					end
				else
					check
						item_for_iteration.feature_name.is_equal (f2.feature_name)
					end
					if not item_for_iteration.select_table_equiv (f2) then
						Result := False
						if not is_freeze_requested and then c.visible_level.is_visible (f2, c.class_id) then
								-- Regenerate C code for visible feature so that it can be accessed via CECIL.
							system.request_freeze
						end
					end
				end
				forth
			end
		end

feature -- Generation

	descriptors (c: CLASS_C): DESC_LIST is
			-- Descriptors of class types associated
			-- with class `c'
		require
			c_not_void: c /= Void
		local
			eiffel_class: EIFFEL_CLASS_C
			l_feature_i: FEATURE_I
			l_table: COMPUTED_FEATURE_TABLE
			l_id_set: ROUT_ID_SET
			i, j, nb, l_count: INTEGER
			l_inline_agent_table: HASH_TABLE [FEATURE_I, INTEGER_32]
			l_area: SPECIAL [FEATURE_I]
			l_features: HASH_TABLE [FEATURE_I, INTEGER_32]
		do
			create Result.make (c)
			if c.has_invariant then
				Result.put_invariant (c.invariant_feature)
			end

			from
				l_table := feature_table.features
				l_area := l_table.area
				l_count := l_table.count
			until
				i = l_count
			loop
				l_feature_i := l_area [i]
				l_id_set := l_feature_i.rout_id_set
				Result.put (l_id_set.first, l_feature_i)
				nb := l_id_set.count
				if nb > 1 then
					from
						j := 2
					until
						j > nb
					loop
						Result.put (l_id_set.item (j), l_feature_i)
						j := j + 1
					end
				end
				i := i + 1
			end

			eiffel_class ?= c
			if eiffel_class /= Void and then eiffel_class.has_inline_agents then
				from
					l_inline_agent_table := eiffel_class.inline_agent_table
					l_inline_agent_table.start
				until
					l_inline_agent_table.after
				loop
					l_feature_i := l_inline_agent_table.item_for_iteration
					Result.put (l_feature_i.rout_id_set.first, l_feature_i)
					l_inline_agent_table.forth
				end
			end

				-- Added entries for the generic features, holding the data for
				-- current and inherited formal generic parameters.
			l_features := c.generic_features
			if l_features /= Void then
				from
					l_features.start
				until
					l_features.after
				loop
					l_feature_i := l_features.item_for_iteration
					Result.put (l_feature_i.rout_id_set.first, l_feature_i)
					l_features.forth
				end
			end
		end

	generate (c: CLASS_C) is
			-- Generate descriptor C tables of class
			-- types associated with class `c'.
		require
			c_not_void: c /= Void
		local
			l_desc_list: DESC_LIST
			l_desc_list_area: SPECIAL [DESCRIPTOR]
			i, l_count: INTEGER
			desc: DESCRIPTOR
		do
			from
				l_desc_list := descriptors (c)
				l_desc_list_area := l_desc_list.area
				l_count := l_desc_list.count
			until
				i = l_count
			loop
				desc := l_desc_list_area [i]
				if desc.class_type.is_modifiable then
					desc.generate
				end
				i := i + 1
			end
		end

feature -- Melting

	melt (c: CLASS_C) is
			-- Melt descriptors of class types
			-- associated with class `c'.
			--| (The result is put in the melted
			--| descriptor server).
		require
			c_not_void: c /= Void
		do
			descriptors (c).melt
		end

feature {NONE} -- Implementation

	is_consistent: BOOLEAN is
			-- Is Current consistent?
		local
			l_cursor: CURSOR
		do
			l_cursor := cursor
			from
				Result := True
				start
			until
				after or not Result
			loop
				Result := item_for_iteration.rout_id_set.has (key_for_iteration)
				forth
			end
			go_to (l_cursor)
		end

	add_feature_unit (id: INTEGER; a_feature: FEATURE_I) is
			-- Insert units of Current in the history
			-- controler (routine table construction)
		require
			a_feature_not_void: a_feature /= Void
		local
			l_id_set: ROUT_ID_SET
			i, nb: INTEGER
			l_control: like history_control
		do
			l_control := history_control
			l_id_set := a_feature.rout_id_set
			l_control.add_new (a_feature, id, l_id_set.first)
			nb := l_id_set.count
			if nb > 1 then
				from
					i := 2
				until
					i > nb
				loop
					l_control.add_new (a_feature, id, l_id_set.item (i))
					i := i + 1
				end
			end
		end
invariant
	feature_table_not_void: feature_table /= Void
		-- Test below is because while in the creation procedure of FEATURE_TABLE
		-- the creation of the SELECT_TABLE is not completed yet, so we have to protect
		-- ourself here.
	related_feature_table: feature_table.select_table /= Void implies
		feature_table.select_table = Current
	is_consistent: is_consistent

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

end -- class SELECT_TABLE
