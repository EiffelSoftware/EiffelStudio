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

	make_from_info (a_name: like external_name) is
			-- Initialize attributes.
		indexing
			external_name: "MakeFromInfo"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			set_external_name (a_name)
			create features_modifications.make
		ensure
			external_name_set: external_name.equals_string (a_name)
			non_void_features_modifications: features_modifications /= Void
		end
		
feature -- Access
	
	external_name: STRING
			-- External name
		indexing
			external_name: "ExternalName"
		end
		
	new_class_name: STRING
			-- New class name
		indexing
			external_name: "NewClassName"
		end
		
	features_modifications: SYSTEM_COLLECTIONS_HASHTABLE
			-- Features modifications
			-- | Key: Instance of `SYSTEM_REFLECTION_METHODINFO'
			-- | Value: New feature name
		indexing
			external_name: "FeaturesModifications"
		end

feature -- Status Setting

	set_external_name (a_name: like external_name) is
			-- Set `external_name' with `a_name'.
		indexing
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.equals_string (a_name)
		end
	
	set_new_class_name (a_name: like new_class_name) is
			-- Set `new_class_name' with `a_name'.
		indexing
			external_name: "SetNewClassName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			new_class_name := a_name
		ensure
			new_class_name_set: new_class_name.equals_string (a_name)
		end

feature -- Basic Operations

	add_feature_modification (a_feature_info: SYSTEM_REFLECTION_METHODINFO; new_feature_name: STRING) is
			-- Add `new_feature_name' to `features_modifications' with key `a_feature_info'.
			-- If `a_feature_info' is already in table, the existing value will be replaced by `new_feature_name'.
		indexing
			external_name: "AddFeatureModification"
		require
			non_void_feature_modification: a_feature_info /= Void
			non_void_feature_name: new_feature_name /= Void
			not_empty_feature_name: new_feature_name.length > 0
		do
			if features_modifications.containskey (a_feature_info) then
				features_modifications.add (a_feature_info, new_feature_name)
			else
				features_modifications.remove (a_feature_info)
				features_modifications.add (a_feature_info, new_feature_name)
			end
		ensure
			feature_modification_added: features_modifications.containsvalue (new_feature_name)
		end
		
invariant
	non_void_features_modifications: features_modifications /= Void
	
end -- class TYPE_MODIFICATIONS