indexing
	description: "Representation of a undefine clause"
	external_name: "AssemblyManager.UndefineClause"

class
	UNDEFINE_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 
 create
 	make
 
 feature {NONE} -- Initialization
 
 	make (a_feature_name: like feature_name) is 
 			-- Set `feature_name' with `a_feature_name'.
 		indexing
 			external_name: "Make"
 		require
 			non_void_feature_name: a_feature_name /= Void
 			not_empty_feature_name: a_feature_name.length > 0		
 		do
 			feature_name := a_feature_name
 		ensure
 			feature_name_set: feature_name.equals (a_feature_name)
 		end
 
 feature -- Access
 
 	feature_name: STRING
 			-- Feature name
 		indexing
 			external_name: "FeatureName"
 		end
	
 end -- class UNDEFINE_CLAUSE
 