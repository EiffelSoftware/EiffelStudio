indexing
	description: "Objects that helps to manage ANY.generating_type feature ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATING_TYPE_SYSTEM_I

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

feature -- Access

	generating_type_feature_name: STRING is "generating_type"

	generating_type_feature_i (c: CLASS_C): FEATURE_I is
			-- Generating_type feature related to class `c'.
		do
			Result := c.feature_of_rout_id (generating_type_feature.rout_id_set.first)
		end
		
	generating_type_class: CLASS_C is
			-- Class that provides the `generating_type' interface
		do
			Result := Eiffel_system.system.any_class.compiled_class
		end

	generating_type_feature: FEATURE_I is
			-- feature_i that corresponds to {ANY}.generating_type.
		do
			if
				internal_generating_type_feature.item = Void
			then
				internal_generating_type_feature.put (
					generating_type_class.feature_named (generating_type_feature_name))
			end
			Result := internal_generating_type_feature.item
		end

	internal_generating_type_feature: CELL [FEATURE_I] is
			-- Last computed `generating_type_feature'.
		once
			create Result.put (Void)
		end		

end -- class GENERATING_TYPE_SYSTEM_I
