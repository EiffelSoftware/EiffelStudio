-- Class for a feature table: it is basically a hash table of entries
-- the real feature name avaible in the correponding classes, and of items
-- the feature id correponding to the names (id of instance of FEATURE_I).

class FEATURE_TABLE 

inherit

	IDABLE
		rename
			id as feat_tbl_id
		undefine
			twin
		end;
	EXTEND_TABLE [FEATURE_I, STRING];
	SHARED_WORKBENCH
		undefine
			twin
		end;
	SHARED_TABLE
		undefine
			twin
		end;
	SHARED_ERROR_HANDLER
		undefine
			twin
		end;
	SHARED_BODY_ID
		undefine
			twin
		end;
	SH_DEBUG
		undefine
			twin
		end;
	SHARED_ARRAY_BYTE
		undefine
			twin
		end;
	SHARED_SERVER
		undefine
			twin
		end;

creation

	make
	
feature 

	feat_tbl_id: INTEGER;
			-- Id for feature table: it must be equal to the id of the
			-- class to which the feature table belongs to.

	origin_table: SELECT_TABLE;
			-- Table of the features sorted by origin

	associated_class: CLASS_C is
			-- Associated class
		require
			feat_tbl_id > 0
		do
			Result := System.class_of_id (feat_tbl_id);
		end;
			
	set_feat_tbl_id (i: INTEGER) is
			-- Assign `i' to `feat_tbl_id'.
		do
			feat_tbl_id := i
		end;

	set_origin_table (t: like origin_table) is
			-- Assign `t' to `origin_table'.
		do
			origin_table := t;
		end;

	equiv (other: like Current): BOOLEAN is
			-- Incrementality test on feature table in second pass.
			-- We must know if a feature table has possibly changed,
			-- for recompiling descendants of a changed class. Note that
			-- those descendants are perhaps not explicitly touched
			-- syntaxically.
		require
			good_argument: other /= Void;
		local
			feature_name: STRING;
			f1, f2: FEATURE_I;
		do
			if other.count = count then
					-- At least the counts should be the same.
				from
					start;
					Result := True;
				until
					offright or else not Result
				loop
					feature_name := key_for_iteration;
					f2 := other.item (feature_name);
					if f2 = Void then
						Result := False;
					else
						f1 := item_for_iteration;
						check
							f1.feature_name.is_equal (f2.feature_name);
						end;
						Result := f1.equiv (f2);
					end;
debug ("ACTIVITY")
	if not Result then
		io.error.putstring ("%Tfeature ");
		io.error.putstring (feature_name);
		io.error.putstring (" is not equiv.%N");
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
			end; 
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
			feature_name: STRING;
			propagators, melted_propagators: SORTED_SET [DEPEND_UNIT];
			removed_features: SEARCH_TABLE [FEATURE_I];
			depend_unit: DEPEND_UNIT;
			external_i: EXTERNAL_I;
			propagate_feature: BOOLEAN;
		do
				-- Iteration on the features of the current feature
				-- table.
			from
				propagators := pass_control.propagators;
				melted_propagators := pass_control.melted_propagators;
				removed_features := pass_control.removed_features;
				start;
			until
				offright
			loop
					-- Old feature
				old_feature_i := item_for_iteration;
				feature_name := old_feature_i.feature_name;
					-- New feature
				new_feature_i := other.item (feature_name);
					-- First condition, `other' must have the feature
					-- name. Second condition, `old_feature_i' and
					-- `new_feature_i' must have the same interface
					-- Finally, they must have the same `is_deferred' value
				if not (	(new_feature_i /= Void
							and then
							old_feature_i.same_interface (new_feature_i)
							and then
							old_feature_i.is_deferred = new_feature_i.is_deferred)
						or else
							-- We don't want to trigger a third pass
							-- on a client of the associated class
							-- changed of interface between two
							-- recompilations
						old_feature_i.export_status.is_none)
				then
					propagate_feature := True;
				end;

				if 	old_feature_i.written_in = feat_tbl_id then
					if old_feature_i.is_external then
							-- Delete one occurence of an external feature
						external_i ?= old_feature_i;
						pass_control.remove_external (external_i.external_name);
					end;
					if 	new_feature_i = Void
						or else
						new_feature_i.written_in /= feat_tbl_id
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

				if propagate_feature then
debug ("ACTIVITY")
	io.error.putstring ("%Tfeature ");
	io.error.putstring (old_feature_i.feature_name);
	io.error.putstring (" is propagated to clients%N");
end;
					!!depend_unit.make (feat_tbl_id, old_feature_i.feature_id);
					propagators.put (depend_unit);
					propagate_feature := False;
				end;

				if 	new_feature_i /= Void
					and then
					old_feature_i.is_attribute /= new_feature_i.is_attribute
				then
						-- Detect an attribute changed into a function.
					if depend_unit = Void then
						!!depend_unit.make (feat_tbl_id, old_feature_i.feature_id);
					end;
debug ("ACTIVITY")
	io.error.putstring ("Melted propagators: ");
	io.error.putstring (old_feature_i.feature_name);
	io.error.new_line;
end;
					melted_propagators.put (depend_unit);
				end;

				depend_unit := Void;
	
				forth;
			end;
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
				offright
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

		-- Check

	update_table is
			-- Check if the references to the supplier classes
			-- are still valid and remove the entry otherwise
-- FIX ME
-- this should be modified to improve the incrementality
		local
			type_a: TYPE_A;
			used_keys: ARRAY [STRING];
			base_type: INTEGER;
		do
			from
				start
			until
				offright
			loop
				type_a ?= item_for_iteration.type;
				if type_a /= Void then
						-- it is not a procedure
					if type_a.is_void = False and then
							-- The result is not none
						type_a.is_none = False and then
							-- The result is not a formal argument
						type_a.is_formal = False and then
							-- and the class associated with the result does not
							-- exist in the system any more
						type_a.associated_class = Void then
debug
	io.error.putstring ("Update table: ");
	io.error.putstring (key_for_iteration);
	io.error.putstring (" removed%N");
end;
						remove (key_for_iteration)
					end;
				end;
				forth
			end
		end;

	check_table is
			-- Check all the features in the table
		local
			non_deferred, deferred_found: BOOLEAN;
			feature_i: FEATURE_I;
			vcch1: VCCH1;
			vcch2: VCCH2;
		do
			from
				non_deferred := not associated_class.is_deferred;
				start
			until
				offright
			loop
				feature_i := item_for_iteration;
				if feature_i.is_deferred then
					deferred_found := True;
					if non_deferred then
						!!vcch1;
						vcch1.set_class_id (associated_class.id);
						vcch1.set_a_feature (feature_i);
						Error_handler.insert_error (vcch1);
					end;
				end;
				check_feature (feature_i);
				forth;
			end;
			if not (non_deferred or else deferred_found) then
				!!vcch2;
				vcch2.set_class_id (associated_class.id);
				Error_handler.insert_error (vcch2);
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

	feature_of_feature_id (i: INTEGER): FEATURE_I is
			-- Feature of feature_id id equal to `i'.
		local
			feat: FEATURE_I;
		do
			from
				start
			until
				offright or else Result /= Void
			loop
				feat := item_for_iteration;
				if feat.feature_id = i then
					Result := feat;
				end;
				forth;
			end;
		end;

	feature_of_body_id (i: INTEGER): FEATURE_I is
			-- Feature of body id equal to `i'.
		local
			feat: FEATURE_I;
		do
			from
				start
			until
				offright or else Result /= Void
			loop
				feat := item_for_iteration;
				if feat.body_id = i then
					Result := feat;
				end;
				forth;
			end;
		end;

	feature_of_body_index (i: INTEGER): FEATURE_I is
			-- Feature of body index equal to `i'.
		local
			feat: FEATURE_I;
		do
			from
				start
			until
				offright or else Result /= Void
			loop
				feat := item_for_iteration;
				if feat.body_index = i then
					Result := feat;
				end;
				forth;
			end;
		end;

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
				offright
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
				offright
			loop
				feature_i := item_for_iteration;
				if feature_i.is_attribute then
					attribute_type := feature_i.type.actual_type;
					if not attribute_type.is_none then
							-- No attribute of NONE type in skeleton
						attr_type := attribute_type.type_i;
						if attr_type.has_formal or attr_type.is_expanded
						then
							!!generic_desc;
							generic_desc.set_type (attr_type);
							desc := generic_desc;
						else
							desc := attr_type.description;
						end;
						desc.set_feature_id (feature_i.feature_id);
						desc.set_attribute_name (feature_i.feature_name);
						desc.set_rout_id (-(feature_i.rout_id_set.first));
						Result.add (desc);
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
			i, nb, rout_id: INTEGER;
			a_class: CLASS_C;
		do
			tab := routine_id_array;
			from
				i := 0;
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
					if rout_id < 0 then
						rout_id := - rout_id;
					end;
					ba.append_int32_integer (rout_id);
				end;
				i := i + 1
			end;
			a_class := associated_class;
			if a_class.has_visible then
				ba.append ('%/001/');
				a_class.visible_level.make_byte_code (ba, Current);
			else
				ba.append ('%U');
			end;
		end;
			
	generate (file: FILE) is
			-- Generate routine id array in `file'.
		require
			good_argument: file /= Void;
		local
			tab: ARRAY [FEATURE_I];
			feat: FEATURE_I;
			i, nb, rout_id: INTEGER;
		do
			tab := routine_id_array;
			file.putstring ("int32 ra");
			file.putint (feat_tbl_id);
			file.putstring ("[] = {");
			from
				i := 0;
				nb := tab.upper;
			until
				i > nb
			loop
				feat := tab.item (i);
				file.putstring ("(int32) ");
				if feat = Void then
					file.putint (0);
				else
					rout_id := feat.rout_id_set.first;
					if rout_id < 0 then
						rout_id := - rout_id;
					end;
					file.putint (rout_id);
--debug
file.putstring (" /* `");
file.putstring (feat.feature_name);
file.putstring ("' */");
--end;
				end;
				file.putstring (",%N");
				i := i + 1
			end;
			file.putstring ("};%N%N");
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
				offright
			loop
				feature_i := item_for_iteration;
				Result.put (feature_i, feature_i.feature_id);
				forth;
			end;
		end;

	trace is
			-- Debug purpose
		do
			io.error.putstring ("Feature table for ");
			io.error.putstring (associated_class.class_name);
			io.error.new_line;
			from
				start;
			until
				offright
			loop
				io.error.putchar ('%T');
				item_for_iteration.trace_signature;
				io.error.new_line;
				forth;
			end;
		end;

	trace_replications is
			-- Debug purpose
		local
			it: FEATURE_I
		do
			io.error.putstring ("Feature table for ");
			io.error.putstring (associated_class.class_name);
			io.error.new_line;
			from
				start;
			until
				offright
			loop
				io.error.putstring ("%Tfeature name: ");
				it := item_for_iteration;
				io.error.putstring (it.feature_name);
				io.error.new_line;
				io.error.putstring (it.generator);
				io.error.new_line;
				forth;
			end;
		end;

end
