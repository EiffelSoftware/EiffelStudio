-- Class for an staticed type on a feature

class LIKE_FEATURE

inherit

	TYPE_A
		rename
			base_type as rout_id,
			set_base_type as set_rout_id
		redefine
			actual_type, solved_type, has_like, instantiation_in, is_like,
			is_basic, instantiated_in, same_as, meta_type, is_deep_equal
		end;
	SHARED_LIKE_CONTROLER;

creation

	make

feature -- Attributes

	actual_type: TYPE_A;
			-- Actual type of the anchored type in a given class

	class_id: INTEGER;
			-- Class ID of the class where the anchor is referenced

	feature_id: INTEGER;
			-- Feature ID of the anchor

	feature_name: STRING;
			-- Feature name of the anchor

	make (f: FEATURE_I) is
			-- Creation
		require
			valid_argument: f /= Void;
		do
			feature_id := f.feature_id;
			feature_name := f.feature_name;
			class_id := System.current_class.id
		end;

feature -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
		end;

	is_like: BOOLEAN is
			-- Is the type an chored one ?
		do
			Result := True;
		end;

	raise_veen (f: FEATURE_I) is
		local
			veen: VEEN;
		do
			!!veen;
			veen.set_class (System.current_class);
			veen.set_feature (f);
			veen.set_identifier (feature_name);
			Error_handler.insert_error (veen);
			Error_handler.raise_error;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_FEATURE is
			-- Calculated type in function of the feauure `f' which has
			-- the type Current and the feautre table `feat_table
		local
			origin_table: HASH_TABLE [FEATURE_I, INTEGER];
			anchor_feature, orig_feat: FEATURE_I;
			anchor_type: TYPE;
		do
			origin_table := feat_table.origin_table;
			if System.current_class.id /= class_id then
debug
	io.error.putstring ("LIKE_FEATURE solved_type origin_table%N");
end;
				orig_feat := System.class_of_id (class_id).feature_table
								.item (feature_name);
				if orig_feat = Void then
					raise_veen (f);
				end;
				rout_id := orig_feat.rout_id_set.first;
				if rout_id < 0 then
					rout_id := - rout_id
				end;
				anchor_feature := origin_table.item (rout_id);
debug
	if anchor_feature = Void then
		io.error.putstring ("Void feature%N");
		feat_table.trace;
		orig_feat.trace;
		f.trace;
	end;
end;
			else
debug
	io.error.putstring ("LIKE_FEATURE solved_type origin_table%N");
end;
				anchor_feature := feat_table.item (feature_name);
				if anchor_feature = Void then
					raise_veen (f);
				end;
				rout_id := anchor_feature.rout_id_set.first;
				if rout_id < 0 then
					rout_id := - rout_id
				end;
debug
	if anchor_feature = Void then
		io.error.putstring ("Void feature%N");
	end;
end;
			end;
			anchor_type := anchor_feature.type;
			Like_control.on;
			if Like_control.has (rout_id) then
				Like_control.raise_error
			else
					-- Update anchored type controler
				Like_control.put (rout_id);
					-- Re-processing of the anchored type
				Result := clone (Current);
				Result.set_actual_type
				(anchor_type.solved_type (feat_table, anchor_feature).actual_type);
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end;
			end;
		end;

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_FEATURE is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := clone (Current);
			Result.set_actual_type
							(actual_type.instantiation_in (type, written_id));
		end;

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := clone (Current);
			Result.set_actual_type (actual_type.instantiated_in (class_type));
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to `actual_type' ?
		do
			Result := actual_type.internal_conform_to (other, in_generics);
		end;

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := actual_type.associated_class;
		end;

	dump: STRING is
			-- Dumped trace
		local
			s: STRING;
		do
			s := actual_type.dump;
			!!Result.make (18 + s.count);
			Result.append ("[like feature]: ");
			Result.append (s);
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("[like feature]: ");
			actual_type.append_clickable_signature (a_clickable);
		end;

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			Result := True;
		end;

	type_i: TYPE_I is
			-- Reduced type of `actual_type'
		do
			Result := actual_type.type_i;
		end;

	meta_type: TYPE_I is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end;

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_feat: LIKE_FEATURE;
		do
			other_like_feat ?= other;
			Result := 	other_like_feat /= Void
						and then
						other_like_feat.rout_id = rout_id
						and then
						other_like_feat.feature_id = feature_id
		end;

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			like_feat: LIKE_FEATURE
		do
			like_feat ?= other;
			Result := like_feat /= Void and then
				like_feat.rout_id = rout_id and then
				like_feat.class_id = class_id and then
				like_feat.feature_id = feature_id and then
				like_feat.actual_type.is_deep_equal (actual_type) and then
				feature_name.is_equal (like_feat.feature_name)
		end;

	create_info: CREATE_FEAT is
			-- Byte code information for entity type creation
		do
			!!Result;
			Result.set_feature_id (feature_id);
			Result.set_feature_name (feature_name);
		end

end
