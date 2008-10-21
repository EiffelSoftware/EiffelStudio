indexing
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
			{NONE}
				clear_all, wipe_out, extend
		end

create
	make

feature {NONE} -- Creation

	make (n: INTEGER) is
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

	associated_class: CLASS_C is
			-- Associated class
		require
			feat_tbl_id /= 0
		do
			Result := System.class_of_id (feat_tbl_id)
		end

	item_alias_id (alias_name_id: INTEGER): FEATURE_I is
			-- Feature with alias name id `alias_name_id', if present; Void otherwise
		require
			valid_alias_name_id: alias_name_id > 0
		local
			l_id: INTEGER
		do
			l_id := alias_table.item (alias_name_id)
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

	features: COMPUTED_FEATURE_TABLE is
			-- Linear representation of all features of `feature_table'.
		require
			computed: is_computed
		local
			i, l_count, l_id: INTEGER
			l_server: FEATURE_SERVER
		do
			Result := feature_table
			if Result = Void then
				Result := feature_table_cache.item_id (feat_tbl_id)
				if Result = Void then
					from
						l_count := count
							-- Create Result filled with at least `l_count' items.
						create Result.make_filled (l_count)
						Result.set_id (feat_tbl_id)
						l_server := system.feature_server
							--
						iteration_position := -1
					until
						i = l_count
					loop
						i := i + 1
						internal_table_forth
						l_id := content [iteration_position]
						if l_id > 0 then
							Result.put_i_th (l_server.item (l_id), i)
						end
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

	internal_features: COMPUTED_FEATURE_TABLE is
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

	item_id (an_id: INTEGER): FEATURE_I is
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

	found_item: FEATURE_I is
			--
		local
			l_id: INTEGER
		do
			l_id := internal_table_found_item
			if l_id > 0 then
				Result := system.feature_server.item (l_id)
			end
		end

	put (new: FEATURE_I; key: INTEGER) is
		local
			alias_name_id: INTEGER
		do
				-- Even if there is an id, we recreate one.
			new.set_id (system.feature_counter.next_id)
			tmp_feature_server.put (new)
			internal_table_put (new.id, key)
			if not found and then new.is_attribute then
					-- We are adding a new attribute so we update the attribute count.
				attribute_count := attribute_count + 1
			end
				-- Update alias table
			alias_name_id := new.alias_name_id
			if alias_name_id > 0 then
				alias_table.put (new.id, alias_name_id)
			end
		end

	replace (new: FEATURE_I; key: INTEGER) is
		do
			remove (key)
			put (new, key)
		end

	item_for_iteration: FEATURE_I is
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

feature {NONE} -- HASH_TABLE like features

	remove (key: INTEGER) is
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
				end
				l_id := old_feature.id
				if l_id > 0 then
					tmp_feature_server.remove (l_id)
				end
					-- Remove old alias name
				alias_name_id := old_feature.alias_name_id
				if alias_name_id > 0 then
					alias_table.remove (alias_name_id)
				end
			end
			internal_table_remove (key)
		end

feature -- Access: compatibility

	item (s: STRING): FEATURE_I is
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

	overloaded_items (an_id: INTEGER): LIST [FEATURE_I] is
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

	has (s: STRING): BOOLEAN is
			-- Has item of name `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			Result := has_id (Names_heap.id_of (s))
		end

	search (s: STRING) is
			-- Search for `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			search_id (Names_heap.id_of (s))
		end

	alias_item (alias_name: STRING): FEATURE_I is
			-- Feature with given `alias_name' if any
		require
			alias_name_not_void: alias_name /= Void
			is_mangled_alias_name: is_mangled_alias_name (alias_name)
		do
			Result := item_alias_id (names_heap.id_of (alias_name))
		end

feature -- Traversal

	start is
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

	after: BOOLEAN is
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

	forth is
			-- Are we off?
		do
			if feature_table /= Void then
				feature_table.forth
			else
				internal_table_forth
			end
		end

feature -- Status report

	has_overloaded (a_feature_name_id: INTEGER): BOOLEAN is
			-- Does Current have `a_feature_name' as being an overloaded routine?
		do
			if a_feature_name_id > 0 and then overloaded_names /= Void and then associated_class.is_true_external then
				Result := overloaded_names.has (a_feature_name_id)
			end
		end

	is_alias_conflict: BOOLEAN is
			-- Did last operation cause a conflict on alias name?
		do
			Result := alias_table.conflict
		end

	is_computed: BOOLEAN
			-- Is Current properly computed? I.e. went through degree 4?

	is_flushed: BOOLEAN
			-- Find out if we can discard `feature_table' during a traversal
			-- that is to say we are sure it was stored to disk.

	attribute_count: INTEGER
			-- Number of attributes held within `Current'.
			--| Used for optimizing skeleton creation and generic seed update.

feature -- Settings

	set_overloaded_names (o: like overloaded_names) is
			-- Assign `o' to `overloaded_names'.
		do
			overloaded_names := o
		ensure
			overloaded_names_set: overloaded_names = o
		end

	set_computed is
			-- Mark `is_computed' to True. This is useful in the
			-- case of an empty feature table.
		do
			is_computed := True
			create feature_id_table.make (0, -1)
			create body_index_table.make (0)
			create feature_table.make (0)
			feature_table.set_id (feat_tbl_id)
			create select_table.make (0, Current)
		end

feature -- Comparison

	equiv (other: like Current; pass2_ctrl: PASS2_CONTROL): BOOLEAN is
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
			feature_name_id: INTEGER
			f1, f2: FEATURE_I
			depend_unit: DEPEND_UNIT
			ext_i: EXTERNAL_I
			c: CLASS_C
			is_freeze_requested: BOOLEAN
		do
			c := system.class_of_id (feat_tbl_id)
			if other.count = 0 then
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
					feature_name_id := f1.feature_name_id
					f2 := other.item_id (feature_name_id)
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
							if f1.is_external then
									-- `f1' and `f2' can be "not equiv" because of the
									-- export status. We need to freeze only if the
									-- information specific to EXTERNAL_I is not equiv
								ext_i ?= f1
								if not is_freeze_requested and then not ext_i.freezing_equiv (f2) then
										-- The external definition has changed
									System.request_freeze
									is_freeze_requested := True
								end
							end
							Result := False
								-- One day, I changed `f2' by `f1' and the eweasel test#incr139 was broken,
								-- so I guess this is why we have to use `f2'.
							create depend_unit.make (feat_tbl_id, f2)
							pass2_ctrl.propagators.extend (depend_unit)
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

	fill_pass2_control (pass_control: PASS2_CONTROL; other: like Current) is
			-- Process the interface changes between the new feature table
			-- `other' and the current one.
		local
			old_feature_i, new_feature_i: FEATURE_I
			feature_name_id: INTEGER
			propagators, melted_propagators: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			removed_features: SEARCH_TABLE [INTEGER]
			depend_unit: DEPEND_UNIT
			external_i: EXTERNAL_I
			propagate_feature: BOOLEAN
			same_interface, has_same_type: BOOLEAN
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
				feature_name_id := old_feature_i.feature_name_id
					-- New feature
				new_feature_i := other.item_id (feature_name_id)
				if new_feature_i /= Void then
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
				end

				if old_feature_i.written_in = feat_tbl_id or else old_feature_i.is_replicated_directly then
						-- Previous feature generated for current class.
					if old_feature_i.is_c_external then
						debug ("ACTIVITY")
							io.error.put_string ("Remove external: ")
							io.error.put_string (old_feature_i.feature_name)
							io.error.put_new_line
						end
							-- Delete one occurrence of an external feature. Freeze is taken
							-- care by EXTERNALS.is_equivalent queried by SYSTEM_I.
						external_i ?= old_feature_i
						pass_control.remove_external (external_i)
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

				depend_unit := Void

				forth
			end

			if feat_tbl_id /= 0 then
					-- Bug fix: moving a class around can create problems:
					-- class test1 t: TEST2 end; class test2 inherit t1 end
					-- class test2 moved from one cluster to another
					-- Iteration on the features removed by `update_table'
				from
					removed_feature_ids.start
				until
					removed_feature_ids.after
				loop
	debug ("ACTIVITY")
		io.error.put_string ("%Tfeature of id ")
		io.error.put_integer (removed_feature_ids.item.routine_id)
		io.error.put_string (" (removed by `update_table' is propagated to clients%N")
	end
					create depend_unit.make_no_dead_code (feat_tbl_id, removed_feature_ids.item.routine_id)
					propagators.put (depend_unit)
					removed_features.put (removed_feature_ids.item.body_id)
					removed_feature_ids.forth
				end
				removed_feature_ids := Void
			end
		end

	propagate_assertions (assert_list: LINKED_LIST [INTEGER]) is
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

feature -- Check

	update_table (a_class_id: INTEGER) is
			-- Check if the references to the supplier classes
			-- are still valid and remove the entry otherwise
		require
			a_class_id_positive: a_class_id > 0
		local
			f: FEATURE_I
			l_features: like features
		do
			from
				create removed_feature_ids.make
				l_features := internal_features
				l_features.start
			until
				l_features.after
			loop
				f := l_features.item_for_iteration
				if not f.is_valid then
						-- The result type or one of the arguments type is not valid
debug ("ACTIVITY")
	io.error.put_string ("Update table: ")
	io.error.put_string (f.feature_name)
	io.error.put_string (" removed%N")
end
					if f.written_in = a_class_id or else f.is_replicated_directly then
							-- There is no need for a corresponding "reactivate" here
							-- since it will be done in by pass2 in `feature_unit' if need be
						Tmp_ast_server.desactive (f.body_index)
						removed_feature_ids.extend ([f.rout_id_set.first, f.body_index])
						remove (f.feature_name_id)
					end
					l_features.remove
				else
					l_features.forth
				end
			end
		end

	removed_feature_ids: LINKED_LIST [TUPLE[routine_id, body_id: INTEGER]]
			-- Set of routine_id and body_id removed by `update_table'
			--| It will be used for incrementality (propagation of pass3)

	check_table is
			-- Check all the features in the table
		local
			non_deferred, deferred_found: BOOLEAN
			feature_i: FEATURE_I
			vcch1: VCCH1
		do
			from
				non_deferred := not associated_class.is_deferred
				start
			until
				after
			loop
				feature_i := item_for_iteration
				if feature_i.is_deferred then
					deferred_found := True
					if non_deferred then
						create vcch1
						vcch1.set_class (associated_class)
						vcch1.set_a_feature (feature_i)
						Error_handler.insert_error (vcch1)
					end
				end
				check_feature (feature_i)
				forth
			end
		end

	check_feature (f: FEATURE_I) is
			-- Check arguments and type of feature `f'.
			-- The objective is to deal with anchored types and genericity.
			-- All the anchored types are interpreted here and the generic
			-- parameter instantiated if possible.
		do
debug
io.error.put_string ("Check feature: ")
io.error.put_string (f.feature_name)
io.error.put_new_line
end
			if f.written_in = feat_tbl_id then
					-- Take a feature written in the class associated
					-- to the feature table
				if f.arguments /= Void then
						-- Check if there is not twice the same argument name,
						-- or if one argument has a feature name.
					f.check_argument_names (Current)
				end
			end
			f.check_types (Current)
		end

	compute_lookup_tables is
			-- Build `select_table', `feature_id_table' and `body_index_table'.
		local
			l_feat: FEATURE_I
			nb: INTEGER
			l_feature_server: FEATURE_SERVER
			i: INTEGER
		do
			from
				nb := count
				l_feature_server := system.feature_server
				create feature_table.make_filled (nb)
				feature_table.set_id (feat_tbl_id)
				create select_table.make (nb, Current)
				create feature_id_table.make (1, nb)
				create body_index_table.make (nb)
				iteration_position := -1
			until
				i = nb
			loop
					-- We loop 'nb' times so that when all features are computed we exit loop immediately.
				internal_table_forth
				i := i + 1
					-- Retrieve feature from current routine id of `Current'.
				check l_id_positive: content [iteration_position] > 0 end
				l_feat := l_feature_server.item (content [iteration_position])

				feature_id_table.force (l_feat.feature_name_id, l_feat.feature_id)
				body_index_table.put (l_feat.feature_name_id, l_feat.body_index)
				select_table.add_feature (l_feat)
					-- We can use `i' to insert the feature in to the correct
					-- part of the feature table.
				feature_table.put_i_th (l_feat, i)
			end
			is_computed := True
		ensure
			is_computed: is_computed
		end

	check_expanded is
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

	feature_of_feature_id (i: INTEGER): FEATURE_I is
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

	feature_of_body_index (i: INTEGER): FEATURE_I is
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

	feature_of_rout_id (rout_id: INTEGER): FEATURE_I is
			-- Feature with routine ID `rout_id'.
		require
			valid_rout_id: rout_id > 0
			is_computed: is_computed
		do
			Result := select_table.item (rout_id)
		end

	feature_of_rout_id_set (rout_id_set: ROUT_ID_SET): FEATURE_I is
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

	update_instantiator2 is
			-- Look for generic types in the result and arguments of
			-- the features assuming that the associated class is
			-- syntactically changed
		require
			associated_class.changed
		local
			a_class: CLASS_C
			feature_i: FEATURE_I
		do
			from
				start
				a_class := associated_class
			until
				after
			loop
				feature_i := item_for_iteration
				feature_i.update_instantiator2 (a_class)
				forth
			end
		end

	skeleton: GENERIC_SKELETON is
			-- Skeleton of the associated class
		local
			feature_i: FEATURE_I
			desc: ATTR_DESC
			l_ext: IL_EXTENSION_I
			l_attribute_counter, l_attribute_count: INTEGER
		do
			l_attribute_count := attribute_count
			if l_attribute_count > 0 then
				create Result.make (l_attribute_count)
				from
					start
				until
					l_attribute_counter = l_attribute_count
				loop
					feature_i := item_for_iteration
					if feature_i.is_attribute then
						l_attribute_counter := l_attribute_counter + 1
						l_ext ?= feature_i.extension
						if
							(l_ext = Void or else l_ext.type /= {SHARED_IL_CONSTANTS}.static_field_type)
						then
								-- We do not take IL static fields, only attributes of a class.
							desc := feature_i.type.description
							desc.set_feature_id (feature_i.feature_id)
							desc.set_attribute_name_id (feature_i.feature_name_id)
							desc.set_rout_id (feature_i.rout_id_set.first)
							Result.extend (desc)
						end
					end
						-- Increase iteration counter

					if l_attribute_counter < l_attribute_count then
							-- If we have reached the attribute count then we don't need to do
							-- an unnecessary forth
						forth
					end
				end
			else
				Result := empty_skeleton
			end
		end

	empty_skeleton: GENERIC_SKELETON
			-- Empty skeleton
		once
			create Result.make (0)
		end

	melt is
			-- Melt routine id array associated to the current
			-- feature table
		local
			melted_array: MELTED_ROUTID_ARRAY
			ba: BYTE_ARRAY
		do
			ba := Byte_array
			ba.clear
			make_byte_code (ba)
			melted_array := ba.melted_routid_array
			melted_array.set_class_id (feat_tbl_id)
			Tmp_m_rout_id_server.put (melted_array)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make routine id array byte code
		local
			tab: ARRAY [FEATURE_I]
			feat: FEATURE_I
			i, nb: INTEGER
			rout_id: INTEGER
			a_class: CLASS_C
		do
			a_class := associated_class
			if a_class.is_precompiled then
				ba.append_integer (0)
			else
				from
					i := 0
					tab := routine_id_array
					nb := tab.upper
					ba.append_integer (tab.count)
				until
					i > nb
				loop
					feat := tab.item (i)
					if feat = Void then
						ba.append_integer_32 (0)
					else
						rout_id := feat.rout_id_set.first
						ba.append_integer_32 (rout_id)
					end
					i := i + 1
				end
			end
				-- Reset `visible_table_size' since size is computed
				-- during generation.
			a_class.set_visible_table_size (0)
			debug ("refactor_fixme")
				(create {REFACTORING_HELPER}).fixme ("[
					Remove information about visible features from byte code
					format as they are supported only in frozen code.
				]")
			end
			ba.append ('%U')
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generate routine id array in `buffer'.
		require
			good_argument: buffer /= Void
		local
			tab: ARRAY [FEATURE_I]
			feat: FEATURE_I
			i, nb: INTEGER
			rout_id: INTEGER
			l_int32_str, l_comma_newline_str: STRING
		do
			tab := routine_id_array
			buffer.put_string ("int32 ra")
			buffer.put_integer (feat_tbl_id)
			buffer.put_string ("[] = {")
			buffer.put_new_line
			from
				i := 0
				nb := tab.upper
				l_int32_str := "(int32) "
				l_comma_newline_str := ",%N"
			until
				i > nb
			loop
				feat := tab.item (i)
				buffer.put_string (l_int32_str)
				if feat = Void then
					buffer.put_integer (0)
				else
					rout_id := feat.rout_id_set.first
					buffer.put_integer (rout_id)
debug
buffer.put_string (" /* `")
buffer.put_string (feat.feature_name)
buffer.put_string ("' */")
end
				end
				buffer.put_string (l_comma_newline_str)
				i := i + 1
			end
			buffer.put_string ("};%N%N")
		end

	routine_id_array: ARRAY [FEATURE_I] is
			-- Routine id array
		local
			feature_i: FEATURE_I
			eiffel_class: EIFFEL_CLASS_C
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
			eiffel_class ?= associated_class

			if eiffel_class /= Void and then eiffel_class.has_inline_agents then
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
		end

	replicated_features: HASH_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER] is
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

	has_introduced_new_externals: BOOLEAN is
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

	api_table: E_FEATURE_TABLE is
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

	written_in_features: LIST [E_FEATURE] is
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

	flush is
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

invariant
	alias_table_not_void: alias_table /= Void
	body_index_table_not_void: is_computed implies body_index_table /= Void
	feature_id_table_not_void: is_computed implies feature_id_table /= Void
	select_table_not_void: is_computed implies select_table /= Void
	related_select_table: is_computed implies select_table.feature_table = Current

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
