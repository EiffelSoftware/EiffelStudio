indexing
	description: "Information about external feature recently added to system"
	date: "$Date$"
	revision: "$Revision$"

class FEAT_MELTED_INFO

inherit
	MELTED_INFO
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; associated_class: CLASS_C) is
			-- Initialization
		do
			Precursor {MELTED_INFO} (f, associated_class)
			is_encapsulated_call := f.can_be_encapsulated
			feature_name_id := f.feature_name_id
		end

feature {NONE} -- Implementation

	feature_name_id: INTEGER
			-- Name ID of current_feature

	is_encapsulated_call: BOOLEAN
			-- Is Current a feature encapsulation of something that we usually do
			-- not generate (eg attribute)?

	internal_execution_unit (class_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Create new EXECUTION_UNIT corresponding to Current type.
		local
			res: TYPE_I
			gen_type: GEN_TYPE_I
		do
			if is_encapsulated_call then
				create {ENCAPSULATED_EXECUTION_UNIT} Result.make (class_type)
			else
				create Result.make (class_type)
			end
			Result.set_body_index (body_index)
			Result.set_pattern_id (pattern_id)
			Result.set_written_in (written_in)

			res := result_type
			if res.has_formal then
				gen_type ?= class_type.type
				res := res.instantiation_in (gen_type) 
			end

			Result.set_type (res.c_type)
		end

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		do
			check
				consistency: feat_tbl.has_id (feature_name_id)
			end
			Result := feat_tbl.item_id (feature_name_id)
		end

end
