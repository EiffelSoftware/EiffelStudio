indexing
	description: "Type modifications"
	external_name: "ISE.AssemblyManager.TypeModifications"

class
	TYPE_MODIFICATIONS
	
create
	make,
	make_from_info
	
feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `features_modifications'."
			external_name: "Make"
		do
			create features_modifications.make (0)
		ensure
			non_void_features_modifications: features_modifications /= Void
		end

	make_from_info (an_old_name: like old_name) is
			-- Initialize attributes.
		indexing
			description: "[
						Set `old_name' with `an_old_name'.
						Initialize `features_modifications'
					  ]"
			external_name: "MakeFromInfo"
		require
			non_void_name: an_old_name /= Void
		do
			set_old_name (an_old_name)
			create features_modifications.make (0)
		ensure
			old_name_set: old_name.is_equal (an_old_name)
			non_void_features_modifications: features_modifications /= Void
		end
		
feature -- Access
	
	old_name: STRING
		indexing
			description: "Old class name"
			external_name: "OldName"
		end
		
	new_name: STRING
		indexing
			description: "New class name"
			external_name: "NewName"
		end
		
	features_modifications: HASH_TABLE [FEATURE_MODIFICATIONS, EIFFEL_FEATURE]
			-- | Key: Instance of `EIFFEL_FEATURE'
			-- | Value: Instance of `FEATURE_MODIFICATIONS'
		indexing
			description: "Features modifications"
			external_name: "FeaturesModifications"
		end

feature -- Status Setting

	set_old_name (an_old_name: like old_name) is
		indexing
			description: "Set `old_name' with `an_old_name'."
			external_name: "SetOldName"
		require
			non_void_name: an_old_name /= Void
		do
			old_name := an_old_name
		ensure
			old_name_set: old_name.is_equal (an_old_name)
		end
	
	set_new_name (a_name: like new_name) is
		indexing
			description: "Set `new_name' with `a_name'."
			external_name: "SetNewName"
		require
			non_void_name: a_name /= Void
		do
			new_name := a_name
		ensure
			new_name_set: new_name.is_equal (a_name)
		end

feature -- Basic Operations

	add_feature_modification (a_feature: EIFFEL_FEATURE; feature_modification: FEATURE_MODIFICATIONS) is
		indexing
			description: "[
						Add `feature_modification' to `features_modifications' with key `a_feature'.
						If `a_feature' is already in table, the existing value will be replaced by `feature_modifications'.
					  ]"
			external_name: "AddFeatureModification"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_modification: feature_modification /= Void
		do
			if not features_modifications.has (a_feature) then
				features_modifications.extend (feature_modification, a_feature)
			else
				features_modifications.remove (a_feature)
				features_modifications.extend (feature_modification, a_feature)
			end
		ensure
			feature_modification_added: features_modifications.has_item (feature_modification)
		end
		
invariant
	non_void_features_modifications: features_modifications /= Void
	
end -- class TYPE_MODIFICATIONS
