indexing
	description: "Class for an staticed type on a feature."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_FEATURE

inherit
	LIKE_TYPE_A

	SHARED_LIKE_CONTROLER

creation
	make

feature -- Properties

	feature_name: STRING
			-- Feature name of the anchor

feature {COMPILER_EXPORTER}

	feature_id: INTEGER
			-- Feature ID of the anchor

	make (f: FEATURE_I) is
			-- Creation
		require
			valid_argument: f /= Void
		do
			feature_id := f.feature_id
			feature_name := f.feature_name
			class_id := System.current_class.id
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_feat: LIKE_FEATURE
		do
			other_like_feat ?= other
			Result := 	other_like_feat /= Void
						and then
						other_like_feat.rout_id.is_equal (rout_id)
						and then
						other_like_feat.feature_id = feature_id
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			s: STRING
		do
			s := actual_type.dump
			!!Result.make (18 + s.count)
			Result.append ("[like feature]: ")
			Result.append (s)
		end

	append_to (st: STRUCTURED_TEXT) is
		local
			ec: CLASS_C
		do
			ec := Eiffel_system.class_of_id (class_id)
			st.add_string ("[like ")
			st.add_feature_name (feature_name, ec)
			st.add_string ("]: ")
			actual_type.append_to (st)
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
			origin_table: HASH_TABLE [FEATURE_I, ROUTINE_ID]
			anchor_feature, orig_feat: FEATURE_I
			anchor_type: TYPE
		do
			if not equal (System.current_class.id, class_id) then
debug
	io.error.putstring ("LIKE_FEATURE solved_type origin_table%N")
end
				origin_table := feat_table.origin_table
				orig_feat := System.class_of_id (class_id).feature_table
								.item (feature_name)
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
				anchor_feature := feat_table.item (feature_name)
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

	instantiation_in (type: TYPE_A; written_id: CLASS_ID): LIKE_FEATURE is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := clone (Current)
			Result.set_actual_type
							(actual_type.instantiation_in (type, written_id))
		end

	create_info: CREATE_FEAT is
			-- Byte code information for entity type creation
		do
			!!Result
			Result.set_feature_id (feature_id)
			Result.set_feature_name (feature_name)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := rout_id.is_equal (other.rout_id) and then
				equal (class_id, other.class_id) and then
				feature_id = other.feature_id and then
				equivalent (actual_type, other.actual_type) and then
				feature_name.is_equal (other.feature_name)
		end

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info_with_name, storage_info (classc: CLASS_C): S_BASIC_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		local
			tmp: STRING
		do
			!! tmp.make (0)
			tmp.append ("like ")
			tmp.append (feature_name)
			!! Result.make (tmp)
		end

end -- class LIKE_FEATURE
