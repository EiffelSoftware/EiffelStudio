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
			-- Initialize attributes.
		indexing
			external_name: "Make"
		do
			create features_modifications.make
		ensure
			non_void_features_modifications: features_modifications /= Void
		end

	make_from_info (an_old_name: like old_name) is
			-- Initialize attributes.
		indexing
			external_name: "MakeFromInfo"
		require
			non_void_name: an_old_name /= Void
			not_empty_name: an_old_name.length > 0
		do
			set_old_name (an_old_name)
			create features_modifications.make
		ensure
			old_name_set: old_name.equals_string (an_old_name)
			non_void_features_modifications: features_modifications /= Void
		end
		
feature -- Access
	
	old_name: STRING
			-- Old class name
		indexing
			external_name: "OldName"
		end
		
	new_name: STRING
			-- New class name
		indexing
			external_name: "NewName"
		end
		
	features_modifications: SYSTEM_COLLECTIONS_HASHTABLE
			-- Features modifications
			-- | Key: Instance of `EIFFEL_FEATURE'
			-- | Value: Instance of `FEATURE_MODIFICATIONS'
		indexing
			external_name: "FeaturesModifications"
		end

feature -- Status Setting

	set_old_name (an_old_name: like old_name) is
			-- Set `old_name' with `an_old_name'.
		indexing
			external_name: "SetOldName"
		require
			non_void_name: an_old_name /= Void
			not_empty_name: an_old_name.length > 0
		do
			old_name := an_old_name
		ensure
			old_name_set: old_name.equals_string (an_old_name)
		end
	
	set_new_name (a_name: like new_name) is
			-- Set `new_name' with `a_name'.
		indexing
			external_name: "SetNewName"
		require
			non_void_name: a_name /= Void
		do
			new_name := a_name
		ensure
			new_name_set: new_name.equals_string (a_name)
		end

feature -- Basic Operations

	add_feature_modification (a_feature: ISE_REFLECTION_EIFFELFEATURE; feature_modification: FEATURE_MODIFICATIONS) is
			-- Add `feature_modification' to `features_modifications' with key `a_feature'.
			-- If `a_feature' is already in table, the existing value will be replaced by `feature_modifications'.
		indexing
			external_name: "AddFeatureModification"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_modification: feature_modification /= Void
		do
			if not features_modifications.containskey (a_feature) then
				features_modifications.add (a_feature, feature_modification)
			else
				features_modifications.remove (a_feature)
				features_modifications.add (a_feature, feature_modification)
			end
		ensure
			feature_modification_added: features_modifications.containsvalue (feature_modification)
		end
		
invariant
	non_void_features_modifications: features_modifications /= Void
	
end -- class TYPE_MODIFICATIONS