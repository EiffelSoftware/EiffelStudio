indexing
	description: "Class for an staticed type on a feature."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_FEATURE

inherit
	LIKE_TYPE_A

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization

	make (f: FEATURE_I) is
			-- Creation
		require
			valid_argument: f /= Void
		do
			feature_id := f.feature_id
			feature_name_id := f.feature_name_id
			class_id := System.current_class.class_id
		end
		
feature -- Properties

	feature_name_id: INTEGER
			-- Feature name ID of anchor

	feature_name: STRING is
			-- Final name of anchor.
		require
			feature_name_id_set: feature_name_id >= 1
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature {COMPILER_EXPORTER}

	feature_id: INTEGER
			-- Feature ID of the anchor

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_feat: LIKE_FEATURE
		do
			other_like_feat ?= other
			Result := 	other_like_feat /= Void
					and then other_like_feat.rout_id = rout_id
					and then other_like_feat.feature_id = feature_id
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			s: STRING
		do
			s := actual_type.dump
			!!Result.make (18 + s.count)
			Result.append ("[like " + feature_name +"] ")
			Result.append (s)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			ec: CLASS_C
		do
			ec := Eiffel_system.class_of_id (class_id)
			st.add (ti_L_bracket)
			st.add (ti_Like_keyword)
			st.add_space
			if ec.has_feature_table then
				st.add_feature (ec.feature_with_name (feature_name), feature_name)
			else
				st.add_feature_name (feature_name, ec)
			end
			st.add (ti_R_bracket)
			st.add_space
			actual_type.ext_append_to (st, f)
		end

feature -- Primitives

	raise_veen (f: FEATURE_I) is
		local
			veen: VEEN
		do
			!!veen
			veen.set_class (System.current_class)
			veen.set_feature (f)
			veen.set_identifier (feature_name)
			Error_handler.insert_error (veen)
			Error_handler.raise_error
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_FEATURE is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table
		local
			origin_table: HASH_TABLE [FEATURE_I, INTEGER]
			anchor_feature, orig_feat: FEATURE_I
			anchor_type: TYPE
		do
			if not (System.current_class.class_id = class_id) then
debug
	io.error.putstring ("LIKE_FEATURE solved_type origin_table%N")
end
				origin_table := feat_table.origin_table
				orig_feat := System.class_of_id (class_id).feature_table.item_id (feature_name_id)
				if orig_feat = Void then
					raise_veen (f)
				end
				rout_id := orig_feat.rout_id_set.first
				anchor_feature := origin_table.item (rout_id)
debug
	if anchor_feature = Void then
		io.error.putstring ("Void feature%N")
		feat_table.trace
		orig_feat.trace
		f.trace
	end
end
			else
debug
	io.error.putstring ("LIKE_FEATURE solved_type origin_table%N")
end
				anchor_feature := feat_table.item_id (feature_name_id)
				if anchor_feature = Void then
					raise_veen (f)
				end
				rout_id := anchor_feature.rout_id_set.first
debug
	if anchor_feature = Void then
		io.error.putstring ("Void feature%N")
	end
end
			end
			anchor_type := anchor_feature.type
			Like_control.on
			if Like_control.has (rout_id) then
				Like_control.raise_error
			else
					-- Update anchored type controler
				Like_control.put (rout_id)
					-- Re-processing of the anchored type
				Result := clone (Current)
				Result.set_actual_type
				(anchor_type.solved_type (feat_table, anchor_feature).actual_type)
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_FEATURE is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := clone (Current)
			Result.set_actual_type
							(actual_type.instantiation_in (type, written_id))
		end

	create_info: CREATE_FEAT is
			-- Byte code information for entity type creation
		require else
			current_class_set: System.current_class /= Void
		local
			updated_feature_id: INTEGER
			feat_tbl: FEATURE_TABLE
			feat_i: FEATURE_I
		do
				--| FIXME: `feature_id' refers to the feature_id in class that declares
				--| `feature_name'. However most of times, we need to perform call on
				--| `feature_name' (or its renamed version) in different contexts (eg a
				--| descendant class). To do that, we need to search in current class
				--| being processed by compiler the feature_id of feature of routine id
				--| `rout_id'.
				--| If feature_table does not exist, it means that we are in current
				--| class and it is enough to take stored `feature_id'.
			if System.in_pass3 then
				feat_tbl := context.actual_class_type.associated_class.feature_table
			else
				if System.feat_tbl_server.has (System.current_class.class_id) then
					feat_tbl := System.current_class.feature_table
				end
			end
			if feat_tbl /= Void then
				feat_i := feat_tbl.feature_of_rout_id (rout_id)
				if feat_i /= Void then
					updated_feature_id := feat_i.feature_id
				else
					updated_feature_id := feature_id
				end
			else
				updated_feature_id := feature_id
			end

			create Result.make (updated_feature_id, feature_name_id)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := rout_id = other.rout_id and then
				class_id = other.class_id and then
				feature_id = other.feature_id and then
				equivalent (actual_type, other.actual_type) and then
				feature_name_id = other.feature_name_id
		end

end -- class LIKE_FEATURE
