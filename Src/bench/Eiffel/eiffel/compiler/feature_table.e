-- Class for a feature table: it is basically a hash table of entries
-- the real feature name available in the corresponding classes, and of items
-- the feature id corresponding to the names (id of instance of FEATURE_I).

class
	FEATURE_TABLE

inherit
	IDABLE
		rename
			id as feat_tbl_id,
			set_id as set_feat_tbl_id
		undefine
			copy, is_equal
		end

	EXTEND_TABLE [FEATURE_I, INTEGER]
		rename
			item as item_id,
			has as has_id,
			put as put_id,
			key_for_iteration as key_for_iteration_id,
			replace as replace_id,
			search as search_id
		export
			{CLASS_C, COMPILED_CLASS_INFO} iteration_position
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_TABLE
		undefine
			copy, is_equal
		end

	SHARED_ERROR_HANDLER
		undefine
			copy, is_equal
		end

	SHARED_BODY_ID
		undefine
			copy, is_equal
		end

	SH_DEBUG
		undefine
			copy, is_equal
		end

	SHARED_ARRAY_BYTE
		undefine
			copy, is_equal
		end

	SHARED_SERVER
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end	

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

creation
	make
	
feature -- Access

	origin_table: SELECT_TABLE;
			-- Table of the features sorted by origin

	associated_class: CLASS_C is
			-- Associated class
		require
			feat_tbl_id /= 0
		do
			Result := System.class_of_id (feat_tbl_id);
		end;

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

	has (s: STRING): BOOLEAN is
			-- Has item of name `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		local
			l_id: INTEGER
		do
			l_id := Names_heap.id_of (s)
			Result := l_id > 0 and then has_id (l_id)
		end

	search (key: STRING) is
			-- Search for item of key `key'
			-- If found, set `found' to True, and set
			-- `found_item' to item associated with `key'.
			-- (from HASH_TABLE)
		require
			key_not_void: key /= Void
			key_not_empty: not key.is_empty
		local
			l_id: INTEGER
		do
			l_id := Names_heap.id_of (key)
			if l_id > 0 then
				search_id (l_id)
			else
				found_item := Void
			end
		end
	
feature -- Settings

	set_origin_table (t: like origin_table) is
			-- Assign `t' to `origin_table'.
		do
			origin_table := t;
		end;

feature -- Comparison

	equiv (other: like Current; pass2_ctrl: PASS2_CONTROL): BOOLEAN is
			-- Incrementality test on feature table in second pass.
			-- We must know if a feature table has possibly changed,
			-- for recompiling descendants of a changed class. Note that
			-- those descendants are perhaps not explicitly touched
			-- syntaxically.
		require
			good_argument: other /= Void;
		local
			feature_name_id: INTEGER;
			f1, f2: FEATURE_I;
			depend_unit: DEPEND_UNIT;
			ext_i: EXTERNAL_I
		do
			if other.count = 0 then
				Result := False
			else
				from
					start;
					Result := True;
				until
					after
				loop
					feature_name_id := key_for_iteration_id
					f2 := other.item_id (feature_name_id)
					f1 := item_for_iteration;
					if f2 = Void then
							-- Old feature is not in Current feature table, this
							-- is not equivalent
						Result := False
					else
						check
							f1.feature_name_id = f2.feature_name_id
						end;
						if not f1.equiv (f2) then
	debug ("ACTIVITY")
		io.error.putstring ("%Tfeature ");
		io.error.putstring (f2.feature_name);
		io.error.putstring (" is not equiv.%N");
	end;
							if f1.is_external then
									-- `f1' and `f2' can be "not equiv" because of the
									-- export status. We need to freeze only if the
									-- information specific to EXTERNAL_I is not equiv
								ext_i ?= f1;
								if
									not ext_i.freezing_equiv (f2)
								then
										-- The external definition has changed
									System.set_freeze
								end
							end
							Result := False;
							!!depend_unit.make (feat_tbl_id, f2);
							pass2_ctrl.propagators.extend (depend_unit)
						else
							f1.set_code_id (f2.code_id)			
						end;
					end;
					forth
				end;
				if Result then
					Result := origin_table.equiv (other.origin_table);
debug ("ACTIVITY")
	if not Result then
		io.error.putstring ("%TOrigin table is not equivalent%N");
	end;
end;
				end;
			end
		end;

	pass2_control (other: like Current): PASS2_CONTROL is
			-- Process the interface changes between the new feature table
			-- `other' and the current one.
		require
			good_argument: other /= Void;
		do
			!!Result.make;
			fill_pass2_control (Result, other);
		end;

	fill_pass2_control (pass_control: PASS2_CONTROL; other: like Current) is
			-- Process the interface changes between the new feature table
			-- `other' and the current one.
		local
			old_feature_i, new_feature_i: FEATURE_I;
			feature_name_id: INTEGER;
			propagators, melted_propagators: TWO_WAY_SORTED_SET [DEPEND_UNIT];
			removed_features: SEARCH_TABLE [FEATURE_I];
			depend_unit: DEPEND_UNIT;
			external_i: EXTERNAL_I;
			propagate_feature: BOOLEAN;
			same_interface, has_same_type: BOOLEAN;
		do
				-- Iteration on the features of the current feature
				-- table.
			from
				propagators := pass_control.propagators;
				melted_propagators := pass_control.melted_propagators;
				removed_features := pass_control.removed_features;
				start;
			until
				after
			loop
					-- Old feature
				old_feature_i := item_for_iteration;
				feature_name_id := old_feature_i.feature_name_id;
					-- New feature
				new_feature_i := other.item_id (feature_name_id);
				if new_feature_i /= Void then
					has_same_type := True;
					same_interface := old_feature_i.same_interface (new_feature_i)
					if not same_interface then
						-- Check whether it was in the address table
						if System.address_table.has (old_feature_i.written_in,
													 old_feature_i.feature_id
													) then
							-- Force a re-freeze in order
							-- to get a correct 'ececil.c'
							System.set_freeze
						end
						has_same_type := old_feature_i.same_class_type (new_feature_i);
					end;
				else
					-- Does not exist any more.
					-- Check whether it was in the address table
					if System.address_table.has (old_feature_i.written_in,
												 old_feature_i.feature_id
												) then
						-- Force a re-freeze in order
						-- to get a correct 'ececil.c'
						-- (no unresolved externals in this case)!
						System.set_freeze
					end
				end;
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
					propagate_feature := True;
				end;

				if 	old_feature_i.written_in = feat_tbl_id then
					if old_feature_i.is_external then
							-- Delete one occurrence of an external feature
						external_i ?= old_feature_i;
debug ("ACTIVITY")
	io.error.putstring ("Remove external: ");
	io.error.putstring (old_feature_i.feature_name);
	io.error.new_line;
end;
						if not external_i.encapsulated then
								-- If the external is encapsulated then it was not added to
								-- the list of new externals in inherit_table. Same thing
								-- if it has to be removed
							pass_control.remove_external (external_i.external_name_id);
						end;
					end;
					if 	new_feature_i = Void
						or else
						not (new_feature_i.written_in = feat_tbl_id)
					then
							-- A feature written in the associated class
							-- disapear
debug ("ACTIVITY")
	io.error.putstring ("Removed feature: ");
	io.error.putstring (old_feature_i.feature_name);
	io.error.new_line;
end;
						removed_features.put (old_feature_i);
						propagate_feature := True;
					end;
				end;

				if feat_tbl_id /= 0 then
					-- Bug fix: moving a class around can create problems:
					-- class test1 t: TEST2 end; class test2 inherit t1 end
					-- class test2 moved from one cluster to another
				if propagate_feature then
debug ("ACTIVITY")
	io.error.putstring ("%Tfeature ");
	io.error.putstring (old_feature_i.feature_name);
	io.error.putstring (" is propagated to clients%N");
end;
					!!depend_unit.make_no_dead_code (feat_tbl_id, old_feature_i.feature_id);
					propagators.put (depend_unit);
					propagate_feature := False;
				end;

				if 	new_feature_i /= Void
					and then
					(old_feature_i.is_attribute /= new_feature_i.is_attribute or else
					 not has_same_type)
				then
						-- Detect an attribute changed into a function.
					if depend_unit = Void then
						!!depend_unit.make_no_dead_code (feat_tbl_id, old_feature_i.feature_id);
					end;
debug ("ACTIVITY")
	io.error.putstring ("Melted propagators: ");
	io.error.putstring (old_feature_i.feature_name);
	io.error.new_line;
end;
					melted_propagators.put (depend_unit);
				end;
				end;

				depend_unit := Void;
	
				forth;
			end;

			if feat_tbl_id /= 0 then
					-- Bug fix: moving a class around can crete problems:
					-- class test1 t: TEST2 end; class test2 inherit t1 end
					-- class test2 moved from one cluster to another
					-- Iteration on the features removed by `update_table'
				from
					removed_feature_ids.start
				until
					removed_feature_ids.after
				loop
	debug ("ACTIVITY")
		io.error.putstring ("%Tfeature of id ");
		io.error.putint (removed_feature_ids.item);
		io.error.putstring (" (removed by `update_table' is propagated to clients%N");
	end;
					!!depend_unit.make_no_dead_code (feat_tbl_id, removed_feature_ids.item);
					propagators.put (depend_unit);
					removed_feature_ids.forth
				end
				removed_feature_ids := Void
			end
		end;

	propagate_assertions (assert_list: LINKED_LIST [INTEGER]) is
			-- Propagate features to Pass 4 using the routine ids
			-- in `assert_list'.
		local
			stop: BOOLEAN;
		do
			from
				start
			until
				after
			loop
				if item_for_iteration.written_in = feat_tbl_id and then
					not item_for_iteration.is_deferred then
					from
						assert_list.start;
						stop := False;
					until
						assert_list.after or else stop
					loop
						if
							item_for_iteration.rout_id_set.has (assert_list.item)
						then
							stop := True;
debug ("ASSERTION")
	io.putstring ("inserting feature for pass 4:%N");
	io.putstring (item_for_iteration.feature_name);
	io.new_line;
end;
							associated_class.insert_changed_assertion
								(item_for_iteration)
						end;
						assert_list.forth
					end;
				end;
				forth
			end;
		end;

feature -- Check

	update_table is
			-- Check if the references to the supplier classes
			-- are still valid and remove the entry otherwise
		local
			f: FEATURE_I;
		do
			from
				create removed_feature_ids.make
				start
			until
				after
			loop
				f := item_for_iteration;
				if not f.is_valid then
						-- The result type or one of the arguments type is not valid
debug ("ACTIVITY")
	io.error.putstring ("Update table: ");
	io.error.putstring (Names_heap.item (key_for_iteration_id));
	io.error.putstring (" removed%N");
end;
					Tmp_body_server.desactive (f.body_index);
						
					-- There is no need for a corresponding "reactivate" here
					-- since it will be done in by pass2 in `feature_unit' if need be

					removed_feature_ids.extend (f.feature_id);
					remove (key_for_iteration_id);
				end;
				forth
			end
		end;

	removed_feature_ids: LINKED_LIST [INTEGER]
			-- Set of feature_ids removed by `update_table'
			--| It will be used for incrementality (propagation of pass3)

	check_table is
			-- Check all the features in the table
		local
			non_deferred, deferred_found: BOOLEAN;
			feature_i: FEATURE_I;
			vcch1: VCCH1;
			select_table: SELECT_TABLE
		do
			from
				non_deferred := not associated_class.is_deferred;
				select_table := origin_table
				select_table.start
			until
				select_table.after
			loop
				feature_i := select_table.item_for_iteration;
				if feature_i.is_deferred then
					deferred_found := True;
					if non_deferred then
						!!vcch1;
						vcch1.set_class (associated_class);
						vcch1.set_a_feature (feature_i);
						Error_handler.insert_error (vcch1);
					end;
				end;
				check_feature (feature_i);
				select_table.forth;
			end;
		end;

	check_feature (f: FEATURE_I) is
			-- Check arguments and type of feature `f'.
			-- The objective is to deal with anchored types and genericity.
			-- All the anchored types are interpreted here and the generic
			-- parameter instantiated if possible.
		local
			arguments: FEAT_ARG;
		do
debug
io.error.putstring ("Check feature: ");
io.error.putstring (f.feature_name);
io.error.new_line;
end;
			if f.written_in = feat_tbl_id then
					-- Take a feature written in the class associated
					-- to the feature table
				arguments := f.arguments;
				if arguments /= Void then
						-- Check if there is not twice the same argument name,
						-- or if one argument has a feature name.
					f.check_argument_names (Current);
				end;
			end;
			f.check_types (Current);
		end;

	check_expanded is
			-- Check the expanded validity rules
		local
			class_c: CLASS_C;
		do
			class_c := associated_class;
			from
				start
			until
				after
			loop
				item_for_iteration.check_expanded (class_c);
				forth;
			end;
			Error_handler.checksum;
		end;

	feature_of_feature_id (i: INTEGER): FEATURE_I is
			-- Feature of feature_id id equal to `i'.
		local
			feat: FEATURE_I;
			pos: INTEGER
		do
			pos := iteration_position
			from
				start
			until
				after or else Result /= Void
			loop
				feat := item_for_iteration;
				if feat.feature_id = i then
					Result := feat;
				end;
				forth;
			end;
			go (pos);
		end;

	feature_of_body_index (i: INTEGER): FEATURE_I is
			-- Feature of body id equal to `i'.
		local
			feat: FEATURE_I;
			pos: INTEGER
		do
			pos := iteration_position
			from
				start
			until
				after or else Result /= Void
			loop
				feat := item_for_iteration;
				if feat.body_index = i then
					Result := feat;
				end;
				forth;
			end;
			go (pos);
		end;

	feature_of_rout_id (rout_id: INTEGER): FEATURE_I is
			-- Feature found in routine table rout_id
		do
			Result := origin_table.item (rout_id)
		end

	update_instantiator2 is
			-- Look for generic types in the result and arguments of
			-- the features assuming that the associated class is
			-- syntactically changed
		require
			associated_class.changed;
		local
			a_class: CLASS_C;
			feature_i: FEATURE_I;
		do
			from
				start;
				a_class := associated_class;
			until
				after
			loop
				feature_i := item_for_iteration;
				if feature_i.written_in = feat_tbl_id then
						-- Feature written in the associated class
					feature_i.update_instantiator2 (a_class);
				end;
				forth
			end;
		end;

	skeleton: GENERIC_SKELETON is
			-- Skeleton of the associated class
		local
			feature_i: FEATURE_I;
			attr_type: TYPE_I;
			desc: ATTR_DESC;
			generic_desc: GENERIC_DESC;
			attribute_type: TYPE_A;
		do
			from
				!!Result.make;
				start
			until
				after
			loop
				feature_i := item_for_iteration;
				if feature_i.is_attribute then
					attribute_type := feature_i.type.actual_type;
					if not attribute_type.is_none then
							-- No attribute of NONE type in skeleton
						attr_type := attribute_type.type_i;
						if attr_type.has_formal or attr_type.is_true_expanded then
							!!generic_desc;
							generic_desc.set_type (attr_type);
							desc := generic_desc;
						else
							desc := attr_type.description;
						end;
						desc.set_feature_id (feature_i.feature_id);
						desc.set_attribute_name (feature_i.feature_name);
						desc.set_rout_id (feature_i.rout_id_set.first);
						Result.extend (desc);
					end;
				end;
				forth
			end;
		end;

	melt is
			-- Melt routine id array associated to the current
			-- feature table
		local
			melted_array: MELTED_ROUTID_ARRAY;
			ba: BYTE_ARRAY;
		do
			ba := Byte_array;
			ba.clear;
			make_byte_code (ba);
			melted_array := ba.melted_routid_array;
			melted_array.set_class_id (feat_tbl_id);
			Tmp_m_rout_id_server.put (melted_array);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make routine id array byte code
		local	
			tab: ARRAY [FEATURE_I];
			feat: FEATURE_I;
			i, nb: INTEGER;
			rout_id: INTEGER;
			a_class: CLASS_C;
		do
			a_class := associated_class;
			if a_class.is_precompiled then
				ba.append_integer (0);
			else
				from
					i := 0;
					tab := routine_id_array;
					nb := tab.upper;
					ba.append_integer (tab.count);
				until
					i > nb
				loop
					feat := tab.item (i);
					if feat = Void then
						ba.append_int32_integer (0);
					else
						rout_id := feat.rout_id_set.first;
						ba.append_int32_integer (rout_id);
					end;
					i := i + 1
				end
			end;
				-- Reset `visible_table_size' since size is computed
				-- during generation.
			a_class.set_visible_table_size (0)
			if a_class.has_visible then
				ba.append ('%/001/');
				a_class.visible_level.make_byte_code (ba, Current);
			else
				ba.append ('%U');
			end;
		end;
			
	generate (buffer: GENERATION_BUFFER) is
			-- Generate routine id array in `buffer'.
		require
			good_argument: buffer /= Void;
		local
			tab: ARRAY [FEATURE_I];
			feat: FEATURE_I;
			i, nb: INTEGER;
			rout_id: INTEGER
		do
			tab := routine_id_array;
			buffer.putstring ("int32 ra");
			buffer.putint (feat_tbl_id);
			buffer.putstring ("[] = {");
			buffer.new_line;
			from
				i := 0;
				nb := tab.upper;
			until
				i > nb
			loop
				feat := tab.item (i);
				buffer.putstring ("(int32) ");
				if feat = Void then
					buffer.putint (0);
				else
					rout_id := feat.rout_id_set.first;
					buffer.putint (rout_id);
debug
buffer.putstring (" /* `");
buffer.putstring (feat.feature_name);
buffer.putstring ("' */");
end;
				end;
				buffer.putstring (",%N");
				i := i + 1
			end;
			buffer.putstring ("};%N%N");
		end;

	routine_id_array: ARRAY [FEATURE_I] is
			-- Routine id array
		local
			feature_i: FEATURE_I;
		do
			!!Result.make (0, associated_class.feature_id_counter.value);
			from
				start
			until
				after
			loop
				feature_i := item_for_iteration;
				Result.put (feature_i, feature_i.feature_id);
				forth;
			end;
		end;

	replicated_features: EXTEND_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER] is
			-- Replicated features for Current feature table
			-- hashed on body_index
		local
			list: ARRAYED_LIST [FEATURE_I];
			feat: FEATURE_I;
		do
			!!Result.make (10);
			from
				start
			until
				after
			loop
				feat := item_for_iteration;
				if feat.is_replicated and then feat.is_unselected then
					list := Result.item (feat.body_index);
					if list = Void then
						!! list.make (1);
						Result.put (list, feat.body_index)
					end;
					list.extend (feat);
				end;
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
				feat := item_for_iteration;
				Result := feat.is_external and then feat.written_in = feat_tbl_id
				forth
			end
		end;

feature -- API

	api_table: E_FEATURE_TABLE is
			-- API table of features
		local
			c_id: INTEGER;
			feat: FEATURE_I;
		do
			from
				!! Result.make (count)
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
					Result.put (feat.api_feature (c_id), Names_heap.item (key_for_iteration_id))
				end
				forth
			end
		end

	written_in_features: LIST [E_FEATURE] is
			-- List of features defined in current class
		local
			c_id: like feat_tbl_id;
			list: LINKED_LIST [E_FEATURE]
		do  
			from
				c_id := feat_tbl_id;
				!! list.make;
				start
			until
				after
			loop
				if c_id = item_for_iteration.written_in then
					list.put_front (item_for_iteration.api_feature (c_id))
				end;
				forth
			end;
			Result := list
		end;

feature {FORMAT_REGISTRATION} -- Init

	init_origin_table is
			-- Initialize the origin table (for formatting).
		do
			!! origin_table.make (0)
		end

feature -- Debugging

	trace is
			-- Debug purpose
		do
			io.error.putstring ("%N%NFeature table for ");
			io.error.putstring (associated_class.name);
			from
				start;
			until
				after
			loop
				io.error.putchar ('%N');
				print (item_for_iteration.generator)
				io.error.putchar (' ')
				print (item_for_iteration.feature_name)
--				item_for_iteration.trace;
				forth;
			end;
		end;

	trace_replications is
			-- Debug purpose
		local
			it: FEATURE_I
		do
			io.error.putstring ("Feature table for ");
			io.error.putstring (associated_class.name);
			io.error.new_line;
			from
				start;
			until
				after
			loop
				it := item_for_iteration;
if it.written_class > System.any_class.compiled_class then
				it.trace;
				io.error.putstring ("code id: ");
				io.error.putint (it.code_id);
				io.error.putstring (" DT: ");
				io.error.putstring (it.generator);
				io.error.new_line;
end;
				forth;
			end;
		end;

end
