indexing
	description: "Information about invariant recently added to system"
	date: "$Date$"
	revision: "$Revision$"

class INV_MELTED_INFO

inherit
	MELTED_INFO

	SHARED_TYPE_I
		undefine
			is_equal
		end

create
	make

feature

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		do
			check
				has_invariant: feat_tbl.associated_class.invariant_feature /= Void
			end
			Result := feat_tbl.associated_class.invariant_feature
		end

feature {NONE} -- Implementation

	internal_execution_unit (class_type: CLASS_TYPE): INV_EXECUTION_UNIT is
			-- Create new EXECUTION_UNIT corresponding to Current type.
		do
			create Result.make (class_type)
			Result.set_body_index (body_index)
			Result.set_type (Void_c_type)
		end

end
