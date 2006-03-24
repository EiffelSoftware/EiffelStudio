indexing
	description: "Criterion to test if a feature is an unique"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEAT_UNIQUE_CRI

inherit
	EQL_CRITERION

feature -- Evaluation

	evaluate (a_context: EQL_CONTEXT): BOOLEAN is
		do
			Result := a_context.is_e_feature_set and then a_context.e_feature.is_unique
		end

end
