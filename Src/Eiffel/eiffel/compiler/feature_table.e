note
	description: "[
			Class for a feature table: it is basically a hash table of entries
			the real feature name available in the corresponding classes, and of items
			the feature id corresponding to the names (id of instance of FEATURE_I).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_TABLE

inherit
	IDABLE
		rename
			id as feat_tbl_id,
			set_id as set_feat_tbl_id
		undefine
			is_equal, copy
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
			{ANY} is_mangled_alias_name
		undefine
			is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

	SHARED_TABLE
		undefine
			is_equal, copy
		end

	SHARED_ERROR_HANDLER
		undefine
			is_equal, copy
		end

	SHARED_BODY_ID
		undefine
			is_equal, copy
		end

	SHARED_ARRAY_BYTE
		undefine
			is_equal, copy
		end

	SHARED_SERVER
		undefine
			is_equal, copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal, copy
		end

	HASH_TABLE [INTEGER, INTEGER]
		rename
			has as has_id,
			has_key as has_key_id,
			make as internal_table_make,
			search as search_id,
			item_for_iteration as internal_table_item_for_iteration,
			key_for_iteration as internal_table_key_for_iteration,
			put as internal_table_put,
			replace as internal_table_replace,
			remove as internal_table_remove,
			force as internal_table_force,
			item as internal_table_item,
			found_item as internal_table_found_item,
			start as internal_table_start,
			after as internal_table_after,
			forth as internal_table_forth
		export
			{NONE} clear_all, wipe_out, extend
		redefine
			cursor, valid_cursor, go_to
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_ENCODING_CONVERTER
		undefine
			is_equal, copy
		end

	SHARED_DEGREES
		undefine
			is_equal, copy
		end

create
	make

create {FEATURE_TABLE}
	internal_table_make

feature {NONE} -- Creation

	make (n: INTEGER)
		do
			internal_table_make (n)
			create alias_table.make (0)
		end

feature -- Access

	feature_id_table: ARRAY [INTEGER]
			-- Table of feature_name ID indexed by their feature ID.

	body_index_table: HASH_TABLE [INTEGER, INTEGER]
			-- Table of feature_name ID indexed by their body_index.

	select_table: SELECT_TABLE
			-- Table of features sorted by their routine ID.

	overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			-- Hash_table of overloaded features. It is Void by default in a non external class.
			-- The key corresponds to overloaded feature name id, and for each entry it gives a
			-- list of associated resolved feature name id. (e.g. for `put' you will possibly
			-- find `put_integer', `put_double',...)

	associated_class: CLASS_C
			-- Associated class
		require
			feat_tbl_id /= 0
		do
			Result := System.class_of_id (feat_tbl_id)
		end

	item_alias_id (i: like {OPERATOR_KIND}.alias_id): FEATURE_I
			-- Feature with alias name id `i', if present; Void otherwise
		require
			{OPERATOR_KIND}.is_alias_id (i)
			{OPERATOR_KIND}.is_fixed_alias_id (i)
		local
			l_id: INTEGER
		do
			l_id := alias_table.item (lookup_alias_id (i))
			if l_id > 0 then
				Result := system.feature_server.item (l_id)
			end
		end

	search_id_under_renaming (a_feature_name_id: INTEGER; a_renaming: RENAMING_A)
			-- Search `a_name_id' in the current feature table but apply `a_renaming' first.
		require
			a_renaing_not_void: a_renaming /= Void
		do
			search_id (a_renaming.renamed (a_feature_name_id))
		end

	features: COMPUTED_FEATURE_TABLE
			-- Linear representation of all features of `feature_table'.
		require
			computed: is_computed
		local
			l_id: INTEGER
			l_server: FEATURE_SERVER
		do
			Result := feature_table
			if Result = Void then
				Result := feature_table_cache.item_id (feat_tbl_id)
				if Result = Void then
					from
							-- Create Result filled with at least `count' items.
						create Result.make (count)
						Result.set_id (feat_tbl_id)
						l_server := system.feature_server
						internal_table_start
					until
						internal_table_after
					loop
						l_id := internal_table_item_for_iteration
						if l_id > 0 then
							Result.extend (l_server.item (l_id))
						end
						internal_table_forth
					end
					feature_table_cache.force (Result)
				end
			end
		ensure
			features_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	alias_table: HASH_TABLE [INTEGER, INTEGER]
			-- Table of features indexed by their alias names

	feature_table: COMPUTED_FEATURE_TABLE
			-- List of features used for quickly traversing Current without
			-- retrieving each FEATURE_I objects on demand.
			-- Note: `feature_table' should be Void when storing a project
			-- as otherwise we would be storing all the FEATURE_I objects.

feature {NONE} -- Implementation

	internal_features: COMPUTED_FEATURE_TABLE
			-- Linear representation of all features of `feature_table'.
		require
			computed: is_computed
		do
			Result := feature_table
			if Result = Void then
				Result := features
				feature_table := Result
			end
		ensure
			features_not_void: Result /= Void
		end

feature -- HASH_TABLE like feature

	item_id (an_id: INTEGER): FEATURE_I
			-- Item of name ID `an_id'
		require
			an_id_positive: an_id > 0
		local
			l_id: INTEGER
		do
			l_id := internal_table_item (an_id)
			if l_id > 0 then
				Result := system.feature_server.item (l_id)
			end
		end

	found_item: FEATURE_I
			--
		local
			l_id: INTEGER
		do
			l_id := internal_table_found_item
			if l_id > 0 then
				Result := system.feature_server.item (l_id)
			end
		end

	put (new: FEATURE_I; key: INTEGER; new_is_aliased: BOOLEAN)
		local
			alias_name_id: INTEGER
		do
			if not new_is_aliased then
					-- If the feature is not aliased then we generate
					-- a new id.
				new.set_id (system.feature_counter.next_id)
			end
			tmp_feature_server.put (new, new_is_aliased)
			internal_table_put (new.id, key)
			if not found then
				if new.is_attribute then
						-- We are adding a new attribute so we update the attribute count.
					attribute_count := attribute_count + 1
				elseif new.is_object_relative_once then
					once_per_object_count := once_per_object_count + 1
				end
			end
				-- Update alias table
			if attached new.alias_name_ids as lst then
				across
					lst as ic
				until
					alias_table.conflict -- FIXME: check if there is any risk to stop at first conflict? [2019-09-25]
				loop
					alias_name_id := ic.item
					check
						is_alias_id (alias_name_id)
						is_fixed_alias_id (alias_name_id)
					end
					alias_table.put (new.id, lookup_alias_id (alias_name_id))
					if alias_table.conflict then
						conflicting_alias := alias_name_id
					end
				end
			end
		end

	replace (new: FEATURE_I; key: INTEGER)
		do
			if item_id (key) /= new then
				remove (key)
				put (new, key, False)
			end
		end

	item_for_iteration: FEATURE_I
		local
			l_id: INTEGER
			l_feat_tbl: like feature_table
		do
			l_feat_tbl := feature_table
			if l_feat_tbl /= Void then
				Result := l_feat_tbl.item_for_iteration
			else
				l_id := internal_table_item_for_iteration
				if l_id > 0 then
					Result := system.feature_server.item (l_id)
				end
			end
		end

	cursor: CURSOR
			-- <Precursor>
		do
			if attached feature_table as l_feat_tbl then
				Result := l_feat_tbl.cursor
			else
				Result := Precursor
			end
		end

	valid_cursor (c: CURSOR): BOOLEAN
			-- <Precursor>
		do
			if attached feature_table as l_feat_tbl then
				Result := l_feat_tbl.valid_cursor (c)
			else
				Result := Precursor (c)
			end
		end

     go_to (c: CURSOR)
 			-- <Precursor>
          do
             if attached feature_table as l_feat_tbl then
                 l_feat_tbl.go_to (c)
             else
                 Precursor (c)
             end
         end

feature {NONE} -- HASH_TABLE like features

	remove (key: INTEGER)
		local
			old_feature: FEATURE_I
			l_id: INTEGER
			alias_name_id: INTEGER
		do
			old_feature := item_id (key)
			if old_feature /= Void then
					-- Remove feature from temporary feature server
				if old_feature.is_attribute then
					attribute_count := attribute_count - 1
				elseif old_feature.is_object_relative_once then
					once_per_object_count := once_per_object_count - 1
				end
				l_id := old_feature.id
				if l_id > 0 and then not tmp_feature_server.aliased_features.has (l_id) then
						-- We do not want aliased features to be removed from disk.
					tmp_feature_server.remove (l_id)
				end
					-- Remove old alias name
				if attached old_feature.alias_name_ids as lst then
					across
						lst as ic
					loop
						alias_name_id := ic.item
						check
							is_alias_id (alias_name_id)
							is_fixed_alias_id (alias_name_id)
						end
						alias_table.remove (lookup_alias_id (alias_name_id))
					end
				end
			end
			internal_table_remove (key)
		end

feature -- Access: compatibility

	overloaded_items (an_id: INTEGER): LIST [FEATURE_I]
			-- List of features matching overloaded name `s'.
		require
			an_id_valid: an_id >= 0
			has_overloaded_an_id: has_overloaded (an_id)
		local
			l_names: ARRAYED_LIST [INTEGER]
		do
			l_names := overloaded_names.item (an_id)
			create {ARRAYED_LIST [FEATURE_I]} Result.make (l_names.count)
			from
				l_names.start
			until
				l_names.after
			loop
				Result.extend (item_id (l_names.item))
				l_names.forth
			end
		ensure
			overloaded_items_not_void: Result /= Void
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access: compatibility

	item (s: READABLE_STRING_8): FEATURE_I
			-- Item of name `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		local
			id: INTEGER
		do
			id := Names_heap.id_of (s)
			if id > 0 then
				Result := item_id (id)
			end
		end

	has (s: STRING): BOOLEAN
			-- Has item of name `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			Result := has_id (Names_heap.id_of (s))
		end

	search (s: STRING)
			-- Search for `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			search_id (Names_heap.id_of (s))
		end

	alias_item (alias_name: READABLE_STRING_8): FEATURE_I
			-- Feature with given `alias_name' if any
		require
			alias_name_not_void: alias_name /= Void
		local
			id: INTEGER
		do
			id := names_heap.id_of (alias_name)
			if id > 0 then
				Result := item_alias_id (id)
			end
		end

feature -- Query

	has_feature_named (a_feat: E_FEATURE): BOOLEAN
			-- Has feature named `a_feat'?
		do
			Result := has (a_feat.name)
		end

	feature_named (a_feat: E_FEATURE): FEATURE_I
			-- Feature named the same with `a_feat'.
		require
			has_feature: has_feature_named (a_feat)
		do
			Result := item (a_feat.name)
		end

feature -- Traversal

	start
			-- Start iteration
		do
			if feature_table /= Void then
				feature_table.start
			else
					-- Load all the features in memory. It makes sense, since
					-- the traversal will need to go through all the items.
				internal_features.start
			end
		end

	after: BOOLEAN
			-- Are we off?
		do
			if feature_table /= Void then
				Result := feature_table.after
			else
				Result := internal_table_after
			end
			if Result and then is_flushed then
				feature_table := Void
			end
		end

	forth
			-- Are we off?
		do
			if feature_table /= Void then
				feature_table.forth
			else
				internal_table_forth
			end
		end

feature -- Status report

	has_overloaded (a_feature_name_id: INTEGER): BOOLEAN
			-- Does Current have `a_feature_name' as being an overloaded routine?
		do
			if a_feature_name_id > 0 and then overloaded_names /= Void and then associated_class.is_true_external then
				Result := overloaded_names.has (a_feature_name_id)
			end
		end

	is_alias_conflict: BOOLEAN
			-- Did last operation cause a conflict on alias name?
		do
			Result := alias_table.conflict
		end

	conflicting_alias: INTEGER
		require
			is_alias_conflict: is_alias_conflict
		attribute
		end

	is_computed: BOOLEAN
			-- Is Current properly computed? I.e. went through degree 4?

	is_flushed: BOOLEAN
			-- Find out if we can discard `feature_table' during a traversal
			-- that is to say we are sure it was stored to disk.

	attribute_count: INTEGER
			-- Number of attributes held within `Current'.
			--| Used for optimizing skeleton creation and generic seed update.

	once_per_object_count: INTEGER
			-- Number of once per object held within `Current'.
			--| Used for optimizing skeleton creation and generic seed update.

feature -- Settings

	set_overloaded_names (o: like overloaded_names)
			-- Assign `o' to `overloaded_names'.
		do
			overloaded_names := o
		ensure
			overloaded_names_set: overloaded_names = o
		end

	set_computed
			-- Mark `is_computed' to True. This is useful in the
			-- case of an empty feature table.
		do
			is_computed := True
			create feature_id_table.make_empty
			create body_index_table.make (0)
			create feature_table.make (0)
			feature_table.set_id (feat_tbl_id)
			create select_table.make (0, Current)
		end

feature -- Comparison

	equiv (other: like Current; pass2_ctrl: PASS2_CONTROL): BOOLEAN
			-- Incrementality test on feature table in second pass.
			-- We must know if a feature table has possibly changed,
			-- for recompiling descendants of a changed class. Note that
			-- those descendants are perhaps not explicitly touched
			-- syntaxically.
		require
			good_argument: other /= Void
			is_computed: is_computed
			other_is_computed: other.is_computed
		local
			f1, f2: FEATURE_I
			c: CLASS_C
			is_freeze_requested: BOOLEAN
		do
			c := system.class_of_id (feat_tbl_id)
			if other.is_empty then
				Result := False
				if not system.is_freeze_requested and then c.has_visible then
						-- Ensure the system is frozen for CECIL.
					system.request_freeze
				end
			else
				is_freeze_requested := system.is_freeze_requested
				from
					start
					Result := True
				until
					after
				loop
					f1 := item_for_iteration
					f2 := other.item_id (f1.feature_name_id)
					if f2 = Void then
							-- Old feature is not in Current feature table, this
							-- is not equivalent
						Result := False
						if not is_freeze_requested and then c.visible_level.is_visible (f1, feat_tbl_id) then
								-- Remove references to the old feature in CECIL data.
							system.request_freeze
							is_freeze_requested := True
						end
					else
						check
							f1.feature_name_id = f2.feature_name_id
						end
						if f1.equiv (f2) then
							f1.set_code_id (f2.code_id)
						else
	debug ("ACTIVITY")
		io.error.put_string ("%Tfeature ")
		io.error.put_string (f2.feature_name)
		io.error.put_string (" is not equiv.%N")
	end
							if
								f1.is_external and then
								attached {EXTERNAL_I} f1 as ext_i
							then
									-- `f1' and `f2' can be "not equiv" because of the
									-- export status. We need to freeze only if the
									-- information specific to EXTERNAL_I is not equiv
								if not is_freeze_requested and then
									(f1.is_type_evaluation_delayed or else
									f2.is_type_evaluation_delayed or else
									not ext_i.freezing_equiv (f2))
								then
										-- The external definition has changed
									System.request_freeze
									is_freeze_requested := True
								end
							end
							Result := False
								-- One day, I changed `f2' by `f1' and the eweasel test#incr139 was broken,
								-- so I guess this is why we have to use `f2'.
							pass2_ctrl.propagators.extend (create {DEPEND_UNIT}.make (feat_tbl_id, f2))
							if not is_freeze_requested and then c.visible_level.is_visible (f1, feat_tbl_id) then
									-- Regenerate C code for visible feature so that it can be accessed via CECIL.
								system.request_freeze
								is_freeze_requested := True
							end
						end
					end
					forth
				end
				if Result then
					Result := select_table.equiv (other.select_table, c)
debug ("ACTIVITY")
	if not Result then
		io.error.put_string ("%TOrigin table is not equivalent%N")
	end
end
				end
			end
		end

	fill_pass2_control (pass_control: PASS2_CONTROL; other: like Current)
			-- Process the interface changes between the new feature table
			-- `other' and the current one.
		local
			old_feature_i, new_feature_i: FEATURE_I
			propagators, melted_propagators: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			removed_features: SEARCH_TABLE [INTEGER]
			depend_unit: DEPEND_UNIT
			propagate_feature: BOOLEAN
			same_interface, has_same_type: BOOLEAN
			is_anchor_changed: BOOLEAN
		do
				-- Iteration on the features of the current feature
				-- table.
			from
				propagators := pass_control.propagators
				melted_propagators := pass_control.melted_propagators
				removed_features := pass_control.removed_features
				start
			until
				after
			loop
					-- Old feature
				old_feature_i := item_for_iteration
					-- New feature
				new_feature_i := other.item_id (old_feature_i.feature_name_id)
				if new_feature_i = Void then
					is_anchor_changed := True
				else
					has_same_type := True
					same_interface := old_feature_i.same_interface (new_feature_i)
					if not same_interface then
							-- Check whether it was in the address table if it is an attribute
						if
							old_feature_i.is_attribute and then
							System.address_table.has_dollar_operator (old_feature_i.written_in,
								old_feature_i.feature_id)
						then
							-- Force a re-freeze in order
							-- to get a correct 'ececil.c'
							System.request_freeze
						end
						has_same_type := old_feature_i.same_class_type (new_feature_i)
						is_anchor_changed := not has_same_type
					end
				end
					-- First condition, `other' must have the feature
					-- name. Second condition, `old_feature_i' and
					-- `new_feature_i' must have the same interface
					-- Finally, they must have the same `is_deferred' value
				if not (	(new_feature_i /= Void
							and then
							same_interface
							and then
							old_feature_i.export_status.equiv (new_feature_i.export_status)
							and then
							old_feature_i.is_deferred = new_feature_i.is_deferred)
--						or else
							-- We don't want to trigger a third pass
							-- on a client of the associated class
							-- changed of interface between two
							-- recompilations
-- FIXME

-- In fact, we want to propagate in this case
-- but only to the descendants
-- A TEMPORARY solution is to do the propagation anyway
--   ---------
--						old_feature_i.export_status.is_none)
						)
				then
					propagate_feature := True
					is_anchor_changed := is_anchor_changed or else not
						old_feature_i.export_status.equiv (new_feature_i.export_status)
				end

				if
					(old_feature_i.written_in = feat_tbl_id or else old_feature_i.is_replicated_directly) and then
					old_feature_i.is_c_external
				then
						-- Previous feature generated for current class.
					debug ("ACTIVITY")
						io.error.put_string ("Remove external: ")
						io.error.put_string (old_feature_i.feature_name)
						io.error.put_new_line
					end
						-- Delete one occurrence of an external feature. Freeze is taken
						-- care by EXTERNALS.is_equivalent queried by SYSTEM_I.
					if attached {EXTERNAL_I} old_feature_i as external_i then
						pass_control.remove_external (external_i)
					else
						check old_is_external_i: False end
					end
				end

				if old_feature_i.written_in = feat_tbl_id or else old_feature_i.is_replicated_directly then
						-- Previous feature had a body_index generated for current class.
					if
						new_feature_i = Void or else
						(new_feature_i.written_in /= feat_tbl_id and then not new_feature_i.is_replicated_directly) or else
						(new_feature_i.body_index /= old_feature_i.body_index)
					then
							-- A feature written in the associated class disapearred,
							-- or was moved in the inheritance hierarchy,
							-- or had a different body_index.
debug ("ACTIVITY")
	io.error.put_string ("Removed feature: ")
	io.error.put_string (old_feature_i.feature_name)
	io.error.put_new_line
end
						removed_features.put (old_feature_i.body_index)
						propagate_feature := True
						is_anchor_changed := True
					end
				end

				if feat_tbl_id /= 0 then
					-- Bug fix: moving a class around can create problems:
					-- class test1 t: TEST2 end; class test2 inherit t1 end
					-- class test2 moved from one cluster to another
				if propagate_feature then
debug ("ACTIVITY")
	io.error.put_string ("%Tfeature ")
	io.error.put_string (old_feature_i.feature_name)
	io.error.put_string (" is propagated to clients%N")
end
					create depend_unit.make_no_dead_code (feat_tbl_id, old_feature_i.rout_id_set.first)
					propagators.put (depend_unit)
					propagate_feature := False
				end

				if 	new_feature_i /= Void
					and then
					(old_feature_i.is_attribute /= new_feature_i.is_attribute or else
					 not has_same_type)
				then
						-- Detect an attribute changed into a function.
					if depend_unit = Void then
						create depend_unit.make_no_dead_code (feat_tbl_id, old_feature_i.rout_id_set.first)
					end
debug ("ACTIVITY")
	io.error.put_string ("Melted propagators: ")
	io.error.put_string (old_feature_i.feature_name)
	io.error.put_new_line
end
					melted_propagators.put (depend_unit)
				end
				end

				if is_anchor_changed then
						-- Mark anchor clients for recompilation.
					degree_4.touch_feature_type (old_feature_i, associated_class)
				end

				depend_unit := Void

				forth
			end
		end

	propagate_assertions (assert_list: LINKED_LIST [INTEGER])
			-- Propagate features to Pass 4 using the routine ids
			-- in `assert_list'.
		local
			stop: BOOLEAN
		do
			from
				start
			until
				after
			loop
				if item_for_iteration.written_in = feat_tbl_id and then
					not item_for_iteration.is_deferred then
					from
						assert_list.start
						stop := False
					until
						assert_list.after or else stop
					loop
						if
							item_for_iteration.rout_id_set.has (assert_list.item)
						then
							stop := True
debug ("ASSERTION")
	io.put_string ("inserting feature for pass 4:%N")
	io.put_string (item_for_iteration.feature_name)
	io.put_new_line
end
							associated_class.insert_changed_assertion
								(item_for_iteration)
						end
						assert_list.forth
					end
				end
				forth
			end
		end

	compute_lookup_tables
			-- Build `select_table', `feature_id_table' and `body_index_table'.
		local
			l_feat: FEATURE_I
			nb: INTEGER
			l_feature_server: FEATURE_SERVER
		do
			from
				nb := count
				l_feature_server := system.feature_server
				create feature_table.make (nb)
				feature_table.set_id (feat_tbl_id)
				create select_table.make (nb, Current)
				create feature_id_table.make_filled (0, 1, nb)
				create body_index_table.make (nb)
				internal_table_start
			until
				internal_table_after
			loop
					-- Retrieve feature from current routine id of `Current'.
				check l_id_positive: internal_table_item_for_iteration > 0 end
				l_feat := l_feature_server.item (internal_table_item_for_iteration)

				feature_id_table.force (l_feat.feature_name_id, l_feat.feature_id)
				body_index_table.put (l_feat.feature_name_id, l_feat.body_index)
				select_table.add_feature (l_feat)
				feature_table.extend (l_feat)
				internal_table_forth
			end
			is_computed := True
		ensure
			is_computed: is_computed
		end

	check_expanded
			-- Check the expanded validity rules
		local
			class_c: CLASS_C
		do
			class_c := associated_class
			from
				start
			until
				after
			loop
				item_for_iteration.check_expanded (class_c)
				forth
			end
			Error_handler.checksum
		end

	feature_of_feature_id (i: INTEGER): FEATURE_I
			-- Feature of feature_id id equal to `i'.
		require
			is_computed: is_computed
		local
			l_id: INTEGER
		do
			if feature_id_table.valid_index (i) then
				l_id := feature_id_table.item (i)
			end
			if l_id > 0 then
				Result := item_id (l_id)
			end
		end

	feature_of_body_index (i: INTEGER): FEATURE_I
			-- Feature of body id equal to `i'.
		require
			is_computed: is_computed
		local
			l_id: INTEGER
		do
			l_id := body_index_table.item (i)
			if l_id > 0 then
				Result := item_id (l_id)
			end
		end

	feature_of_rout_id (rout_id: INTEGER): FEATURE_I
			-- Feature with routine ID `rout_id'.
		require
			valid_rout_id: rout_id > 0
			is_computed: is_computed
		do
			Result := select_table.item (rout_id)
		end

	feature_of_rout_id_set (rout_id_set: ROUT_ID_SET): FEATURE_I
			-- Feature with routine ID `rout_id'.
		require
			rout_id_set_not_void: rout_id_set /= Void
			is_computed: is_computed
		local
			i, nb: INTEGER
			l_select_table: like select_table
		do
			from
				i := 1
				nb := rout_id_set.count
				l_select_table := select_table
			until
				i > nb or Result /= Void
			loop
				Result := l_select_table.item (rout_id_set.item (i))
				i := i + 1
			end
		end

	update_instantiator2
			-- Look for generic types in the result and arguments of
			-- the features assuming that the associated class is
			-- syntactically changed
		require
			associated_class.changed
		local
			a_class: CLASS_C
		do
			from
				start
				a_class := associated_class
			until
				after
			loop
				item_for_iteration.delayed_update_instantiator2 (a_class)
				forth
			end
		end

	skeleton: GENERIC_SKELETON
			-- Skeleton of the associated class
		local
			l_associated_class: like associated_class
			l_written_class: CLASS_C
			fi, feature_i: FEATURE_I
			desc: ATTR_DESC
			l_opo_counter, l_opo_count: INTEGER
			l_attribute_counter, l_attribute_count: INTEGER
			opo_info_table, old_opo_info_table: detachable OBJECT_RELATIVE_ONCE_INFO_TABLE
			l_ancestors_once_infos: detachable OBJECT_RELATIVE_ONCE_INFO_TABLE
			l_ancestor_once_info: detachable OBJECT_RELATIVE_ONCE_INFO
			l_infos_cursor: INDEXABLE_ITERATION_CURSOR [detachable OBJECT_RELATIVE_ONCE_INFO]
			n: INTEGER
			opo_info: OBJECT_RELATIVE_ONCE_INFO
			opo_reused: BOOLEAN
		do
			l_associated_class := associated_class
			check l_associated_class_attached: l_associated_class /= Void end
			l_attribute_count := attribute_count
			l_opo_count := once_per_object_count

				--| Once per object entries
			if attached l_associated_class.parents_classes as l_ancestors then
				from
					l_ancestors.start
					n := 0
				until
					l_ancestors.after
				loop
					if attached l_ancestors.item.object_relative_once_infos as a then
						n := n + a.count
					end
					l_ancestors.forth
				end
				if n > 0 then
					create l_ancestors_once_infos.make (n)
					from
						l_ancestors.start
					until
						l_ancestors.after
					loop
						if attached l_ancestors.item.object_relative_once_infos as a then
							l_ancestors_once_infos.merge (a)
						end
						l_ancestors.forth
					end
				end
			end

			if l_attribute_count + l_opo_count + n > 0 then
				create Result.make (l_attribute_count + l_opo_count.max (n) * 3)
			else
				Result := empty_skeleton
			end

			opo_info_table := l_associated_class.object_relative_once_infos
			if opo_info_table /= Void then
				old_opo_info_table := opo_info_table
				l_associated_class.reset_object_relative_once_infos
				opo_info_table := Void
			end
			if l_opo_count > 0 then
				l_associated_class.create_object_relative_once_infos (l_opo_count)
				opo_info_table := l_associated_class.object_relative_once_infos -- Fresh empty table
				from
					start
				until
					l_opo_counter = l_opo_count or after
				loop
					feature_i := item_for_iteration
					if feature_i.is_object_relative_once then
							-- Increase attribute counter so we only iterate the number of once per object available						
						l_opo_counter := l_opo_counter + 1
						if attached {ONCE_PROC_I} feature_i as l_once_i then
							check once_is_object_relative: l_once_i.is_object_relative end

							l_written_class := l_once_i.written_class
							l_ancestor_once_info := Void
							if l_ancestors_once_infos /= Void then
								l_ancestor_once_info := l_ancestors_once_infos.first_item_intersecting_with_rout_id_set (l_once_i.rout_id_set)
								if l_ancestor_once_info /= Void then
									l_ancestors_once_infos.update_items_intersecting_with_rout_id_set (l_once_i.rout_id_set, l_once_i)
								end
								--| there could be more than one, but the first one should be the closest.
							end

							if l_ancestor_once_info /= Void and then l_written_class = l_ancestor_once_info.written_class then
									--| Inherited once per object without any redefinition and so on
									--| but we need to adapt it to resolve type in ATTR_DESC ... just in case.
								check inherited_once: l_written_class /= l_associated_class end
								--| Keep ancestor's entries
								if attached l_ancestors_once_infos.items_intersecting_with_rout_id_set (l_once_i.rout_id_set) as lst then
									from
										lst.start
									until
										lst.after
									loop
										opo_info := Void
										opo_reused := False
										if old_opo_info_table /= Void then
											opo_info := old_opo_info_table.first_item_with_same_rout_id_set (l_once_i.rout_id_set)
											if opo_info /= Void then
												old_opo_info_table.remove_items_with_same_rout_id_set (lst.item.rout_id_set)
											end
										end
										if opo_info /= Void then
											-- we need to clean previous extra attributes
											opo_info.reuse (l_once_i)
											opo_reused := opo_info.is_set
										else
											create opo_info.make (l_once_i)
											check is_not_set: not opo_info.is_set end
										end
										opo_info_table.add_after_last_item_intersecting_with_rout_id_set (opo_info, opo_info.rout_id_set)
										add_object_relative_once_to_skeleton (Result, l_associated_class, l_once_i, opo_info, opo_reused, lst.item)
										lst.forth
									end
									l_ancestors_once_infos.remove_items_intersecting_with_rout_id_set (l_once_i.rout_id_set)
								end
							else
								opo_info := Void
								opo_reused := False
									--| Incremental info (from previous compilation)
									--| take care of:
									--| 	class A feature foo: FOO once ("OBJECT") ... end	=> 3       attribs
									--| 	class B inherit A redefine foo end					=> 3+(3)   attribs
									--| 	class C inherit B redefine foo end					=> 3+(3+3) attribs
									--| 	class TEST inherit C ...							=> (3+3+3) attribs instanciated in TEST
								if old_opo_info_table /= Void then
									opo_info := old_opo_info_table.first_item_intersecting_with_rout_id_set (l_once_i.rout_id_set)
									if opo_info /= Void then
										old_opo_info_table.remove_items_intersecting_with_rout_id_set (opo_info.rout_id_set)
									end
								end
								if opo_info /= Void then
									-- we need to clean previous extra attributes
									opo_info.reuse (l_once_i)
									opo_reused := opo_info.is_set
								else
									create opo_info.make (l_once_i)
									check is_not_set: not opo_info.is_set end
								end
								opo_info_table.add_or_replace_first_item_intersecting_with_rout_id_set (opo_info, l_once_i.rout_id_set)

								if l_ancestor_once_info /= Void and then l_written_class /= l_associated_class then
										--| remove the process entries
										--| and then re-add all unprocess entries if any
									l_ancestors_once_infos.remove_items_intersecting_with_rout_id_set (opo_info.rout_id_set)
								end

								if
									not opo_reused and then
									l_written_class /= associated_class and then
									l_ancestor_once_info = Void
								then
										--| Reuse ancestor's routine ids.
									l_ancestor_once_info := l_written_class.object_relative_once_info_of_rout_id_set (opo_info.rout_id_set)
									check l_ancestor_once_info_attached: l_ancestor_once_info /= Void end
								end
								add_object_relative_once_to_skeleton (Result, l_associated_class, l_once_i, opo_info, opo_reused, l_ancestor_once_info)
							end
						end
					end
					if l_opo_counter < l_opo_count then
							-- If we have reached the attribute count then we don't need to do
							-- an unnecessary forth
						forth
					end
				end
			end
			if l_ancestors_once_infos /= Void and then l_ancestors_once_infos.count > 0 then
				if opo_info_table = Void then
					l_associated_class.create_object_relative_once_infos (l_ancestors_once_infos.count)
					opo_info_table := l_associated_class.object_relative_once_infos
				end
				debug ("once_per_object")
					print ("FEATURE_TABLE.skeleton <" + l_associated_class.name_in_upper + ">: ancestors o.p.o count = " + l_ancestors_once_infos.count.out + "%N")
				end
				from
					l_infos_cursor := l_ancestors_once_infos.new_cursor
				until
					l_infos_cursor.after
				loop
					l_ancestor_once_info := l_infos_cursor.item

					feature_i := l_ancestor_once_info.routine
					if feature_i /= Void then
						fi := Void
						if feature_i.has_return_value then
							fi := l_associated_class.feature_of_rout_id_set (feature_i.rout_id_set)
							check associated_feature_exists: fi /= Void end
							if fi /= feature_i then
								l_ancestor_once_info := l_ancestor_once_info.updated_with (fi)
							end
						end

						opo_info := Void
						opo_reused := False
						if old_opo_info_table /= Void then
							opo_info := old_opo_info_table.first_item_intersecting_with_rout_id_set (feature_i.rout_id_set)
							if opo_info /= Void then
								old_opo_info_table.remove_items_intersecting_with_rout_id_set (opo_info.rout_id_set)
							end
						end
						if opo_info /= Void then
							-- we need to clean previous extra attributes
							opo_info.reuse (feature_i)
							opo_reused := opo_info.is_set
						else
							create opo_info.make (feature_i)
							check is_not_set: not opo_info.is_set end
						end
						if fi /= Void and fi /= feature_i then
							opo_info.init_return_info (fi)
						end
						opo_info_table.add_after_item_intersecting_with_rout_id_set (opo_info, opo_info.rout_id_set)
						add_object_relative_once_to_skeleton (Result, l_associated_class, feature_i, opo_info, opo_reused, l_ancestor_once_info)
					end

					l_infos_cursor.forth
				end
			end
			if old_opo_info_table /= Void and then old_opo_info_table.count > 0 then
				from
					l_infos_cursor := old_opo_info_table.new_cursor
				until
					l_infos_cursor.after
				loop
					opo_info := l_infos_cursor.item
					opo_info.clean
					l_infos_cursor.forth
				end
			end

			debug ("once_per_object")
				opo_info_table := l_associated_class.object_relative_once_infos
				if opo_info_table /= Void then
					print ("FEATURE_TABLE.skeleton <" + l_associated_class.name_in_upper + ">: total count = " + opo_info_table.count.out + "%N%N")
				end
			end

				--| Attribute entries
			if l_attribute_count > 0 then
				from
					start
				until
					l_attribute_counter = l_attribute_count
				loop
					feature_i := item_for_iteration
					if feature_i.is_attribute then
							-- Increase attribute counter so we only iterate the number of attributes available
						l_attribute_counter := l_attribute_counter + 1
						if attached {IL_EXTENSION_I} feature_i.extension as l_ext implies l_ext.type /= {SHARED_IL_CONSTANTS}.static_field_type then
								-- We do not take IL static fields, only attributes of a class.
							desc := feature_i.type.description
							desc.set_feature_id (feature_i.feature_id)
							desc.set_attribute_name_id (feature_i.feature_name_id)
							desc.set_rout_id (feature_i.rout_id_set.first)
							desc.set_is_transient (feature_i.is_transient)
							Result.extend (desc)
						end
					end
					if l_attribute_counter < l_attribute_count then
							-- If we have reached the attribute count then we don't need to do
							-- an unnecessary forth
						forth
					end
				end
			end
		ensure
			empty_skeleton_empty: empty_skeleton.is_empty
		end

	add_object_relative_once_to_skeleton (
				a_skeleton: like skeleton;
				a_associated_class: CLASS_C;
				a_fi: FEATURE_I
				opo_info: OBJECT_RELATIVE_ONCE_INFO;
				opo_reused: BOOLEAN;
				a_ancestor_once_info: detachable OBJECT_RELATIVE_ONCE_INFO
			)
		local
			desc: ATTR_DESC
			l_is_redefined: BOOLEAN
		do
			l_is_redefined := a_ancestor_once_info /= Void and a_fi.written_class = a_associated_class
				--| called?
			if not opo_reused then
				opo_info.set_called_feature_id (a_associated_class.feature_id_counter.next)
				if a_ancestor_once_info /= Void and not l_is_redefined then
					opo_info.set_called_routine_id (a_ancestor_once_info.called_routine_id)
					opo_info.set_called_body_index (a_ancestor_once_info.called_body_index)
				else
					opo_info.set_called_routine_id (a_associated_class.routine_id_counter.next_attr_id)
					opo_info.set_called_body_index (system.body_index_counter.next_id)
				end
				opo_info.create_called_name_id
				opo_info.get_called_attr_desc
			else
				desc := opo_info.called_attr_desc
				if desc = Void then
					opo_info.get_called_attr_desc
				end
			end
			desc := opo_info.called_attr_desc
			if a_ancestor_once_info = Void or l_is_redefined then
				system.rout_info_table.put (desc.rout_id, a_associated_class)
			end
			a_skeleton.extend (desc)

				--| Exception?
			if not opo_reused then
				opo_info.set_exception_feature_id (a_associated_class.feature_id_counter.next)
				if a_ancestor_once_info /= Void and not l_is_redefined then
					opo_info.set_exception_routine_id (a_ancestor_once_info.exception_routine_id)
					opo_info.set_exception_body_index (a_ancestor_once_info.exception_body_index)
				else
					opo_info.set_exception_routine_id (a_associated_class.routine_id_counter.next_attr_id)
					opo_info.set_exception_body_index (system.body_index_counter.next_id)
				end
				opo_info.create_exception_name_id
				opo_info.get_exception_attr_desc
			else
				desc := opo_info.exception_attr_desc
				if desc = Void then
					opo_info.get_exception_attr_desc
				end
			end
			desc := opo_info.exception_attr_desc
			if a_ancestor_once_info = Void or l_is_redefined then
				system.rout_info_table.put (desc.rout_id, a_associated_class)
			end
			a_skeleton.extend (desc)

				--| Result?
			if opo_info.has_result then
				if not opo_reused then
					opo_info.set_result_feature_id (a_associated_class.feature_id_counter.next)
					if a_ancestor_once_info /= Void and not l_is_redefined then
						opo_info.set_result_routine_id (a_ancestor_once_info.result_routine_id)
						opo_info.set_result_body_index (a_ancestor_once_info.result_body_index)
					else
						opo_info.set_result_routine_id (a_associated_class.routine_id_counter.next_attr_id)
						opo_info.set_result_body_index (system.body_index_counter.next_id)
					end
					opo_info.create_result_name_id
					opo_info.get_result_attr_desc
				else
					desc := opo_info.result_attr_desc
					if desc = Void then
						opo_info.get_result_attr_desc
					end
				end
				desc := opo_info.result_attr_desc
				if a_ancestor_once_info = Void or l_is_redefined then
					system.rout_info_table.put (desc.rout_id, a_associated_class)
				end
				a_skeleton.extend (desc)
			end
			opo_info.update
			debug ("ONCE_PER_OBJECT")
				opo_info.debug_output_info (a_fi, "from " + a_associated_class.name_in_upper + "<" + a_associated_class.class_id.out +">")
			end
		end

	empty_skeleton: GENERIC_SKELETON
			-- Empty skeleton
		once
			create Result.make (0)
		end

	generate (buffer: GENERATION_BUFFER)
			-- Generate routine id array in `buffer'.
		require
			good_argument: buffer /= Void
		local
			tab: ARRAY [FEATURE_I]
			feat: FEATURE_I
			i, nb: INTEGER
		do
			tab := routine_id_array
			nb := tab.upper
			buffer.put_string ("int32 ra")
			buffer.put_integer (feat_tbl_id)
			buffer.put_string ("[")
				-- Print number of static array initializers.
			buffer.put_integer (nb + 1)
			buffer.put_string ("] = {")
			from
				i := 0
			until
				i > nb
			loop
				feat := tab.item (i)
				if feat = Void then
					buffer.put_integer (0)
				else
					buffer.put_integer (feat.rout_id_set.first)
				end
				if i < nb then
					buffer.put_character (',')
				end
				i := i + 1
			end
			buffer.put_string ("};%N")
		end

	routine_id_array: ARRAY [FEATURE_I]
			-- Routine id array
		local
			feature_i: FEATURE_I
			l_feature_table: HASH_TABLE [FEATURE_I, INTEGER]
		do
			create Result.make (0, associated_class.feature_id_counter.value)
			from
				start
			until
				after
			loop
				feature_i := item_for_iteration
				Result.put (feature_i, feature_i.feature_id)
				forth
			end

			if attached {EIFFEL_CLASS_C} associated_class as eiffel_class and then eiffel_class.has_inline_agents then
				from
					l_feature_table := eiffel_class.inline_agent_table
					l_feature_table.start
				until
					l_feature_table.after
				loop
					feature_i := l_feature_table.item_for_iteration
					Result.put (feature_i, feature_i.feature_id)
					l_feature_table.forth
				end
			end

			l_feature_table := associated_class.generic_features
			if l_feature_table /= Void then
				from
					l_feature_table.start
				until
					l_feature_table.after
				loop
					feature_i := l_feature_table.item_for_iteration
					Result.put (feature_i, feature_i.feature_id)
					l_feature_table.forth
				end
			end
			if
				attached associated_class.object_relative_once_infos as l_once_infos and then
				attached l_once_infos.new_cursor as c
			then
				from
					c.start
				until
					c.after
				loop
					if attached c.item as l_once_info then
						Result.put (l_once_info.called_attribute_i, l_once_info.called_feature_id)
						Result.put (l_once_info.exception_attribute_i, l_once_info.exception_feature_id)
						if l_once_info.has_result then
							Result.put (l_once_info.result_attribute_i, l_once_info.result_feature_id)
						end
					end
					c.forth
				end
			end
		end

	replicated_features: HASH_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER]
			-- Replicated features for Current feature table
			-- hashed on body_index
		local
			list: ARRAYED_LIST [FEATURE_I]
			feat: FEATURE_I
		do
			create Result.make (10)
			from
				start
			until
				after
			loop
				feat := item_for_iteration
				if feat.is_replicated and then feat.is_unselected then
					list := Result.item (feat.body_index)
					if list = Void then
						create list.make (1)
						Result.put (list, feat.body_index)
					end
					list.extend (feat)
				end
				forth
			end
		end

feature -- Case stuff

	has_introduced_new_externals: BOOLEAN
			-- Has `associated_class' introduced new externals?
			--| Looks for externals features that are "written in"
			--| `associated_class'
		local
			feat: FEATURE_I
		do
			from
				start
			until
				Result or else after
			loop
				feat := item_for_iteration
				Result := feat.is_external and then feat.written_in = feat_tbl_id
				forth
			end
		end

feature -- API

	api_table: E_FEATURE_TABLE
			-- API table of features
		local
			c_id: INTEGER
			feat: FEATURE_I
		do
			from
				create Result.make (count)
				if object_comparison then
					Result.compare_objects
				else
					Result.compare_references
				end
				c_id := feat_tbl_id
				Result.set_class_id (c_id)
				start
			until
				after
			loop
				feat := item_for_iteration
				if feat /= Void then
					Result.put (feat.api_feature (c_id), feat.feature_name)
				end
				forth
			end
		end

	written_in_features: LIST [E_FEATURE]
			-- List of features defined in current class
		local
			c_id: like feat_tbl_id
			list: LINKED_LIST [E_FEATURE]
		do
			from
				c_id := feat_tbl_id
				create list.make
				start
			until
				after
			loop
				if c_id = item_for_iteration.written_in then
					list.put_front (item_for_iteration.api_feature (c_id))
				end
				forth
			end
			Result := list
		end

feature -- Server storing

	cleanup_for_saving
			-- Removes reference to `feature_table' so that saving is not clobbered with data
			-- which is temporary.
		do
			feature_table := Void
		end

	flush
		local
			l_old_item: like feature_table
			l_cache: like feature_table_cache
		do
			l_cache := feature_table_cache
			l_old_item := l_cache.item_id (feat_tbl_id)
			if l_old_item = Void then
					-- No previous item of id `feat_tbl_id'
				l_cache.force (feature_table)
			else
					-- There is a previous item of id `feat_tbl_id', so we
					-- update the cache with new item.
				l_cache.change_last_item (feature_table)
			end
			feature_table := Void
			is_flushed := True
			tmp_feature_server.flush
		end

feature -- Code generation

	descriptors (c: CLASS_C): DESC_LIST
			-- Descriptors of class types associated
			-- with class `c'
		require
			c_not_void: c /= Void
		local
			l_feature_i: FEATURE_I
			l_table: COMPUTED_FEATURE_TABLE
			l_id_set: ROUT_ID_SET
			i, j, nb, l_count: INTEGER
			l_inline_agent_table: HASH_TABLE [FEATURE_I, INTEGER_32]
			l_area: SPECIAL [FEATURE_I]
			l_features: HASH_TABLE [FEATURE_I, INTEGER_32]
			l_once_info: OBJECT_RELATIVE_ONCE_INFO
		do
			create Result.make (c)
			if attached c.invariant_feature as f then
				Result.put_invariant (f)
			end

			from
				l_table := features
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

			if attached {EIFFEL_CLASS_C} c as eiffel_class and then eiffel_class.has_inline_agents then
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

				-- Added entries for the object relative onces.
				-- for current and inherited onces per object.
			if
				attached c.object_relative_once_infos as l_once_infos and then
				attached l_once_infos.new_cursor as l_once_infos_cursor
			then
				from
					l_once_infos_cursor.start
				until
					l_once_infos_cursor.after
				loop
					l_once_info := l_once_infos_cursor.item
					Result.put (l_once_info.called_routine_id, l_once_info.called_attribute_i)
					Result.put (l_once_info.exception_routine_id, l_once_info.exception_attribute_i)
					if l_once_info.has_result then
						Result.put (l_once_info.result_routine_id, l_once_info.result_attribute_i)
					end
					l_once_infos_cursor.forth
				end
			end
		end

invariant
	alias_table_not_void: alias_table /= Void
	valid_alias_table_keys: ∀ a: alias_table ¦ is_lookup_alias_id (@ a.key )
	body_index_table_not_void: is_computed implies body_index_table /= Void
	feature_id_table_not_void: is_computed implies feature_id_table /= Void
	select_table_not_void: is_computed implies select_table /= Void
	related_select_table: is_computed implies select_table.feature_table = Current

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
