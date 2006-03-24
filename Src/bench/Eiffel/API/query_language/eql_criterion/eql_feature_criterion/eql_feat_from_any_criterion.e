indexing
	description: "Criterion to test if a feature is from class ANY"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEAT_FROM_ANY_CRI

inherit
	EQL_CRITERION

	SHARED_EIFFEL_PROJECT

feature -- Evaluation

	evaluate (a_context: EQL_CONTEXT): BOOLEAN is
		do
			Result := a_context.is_e_feature_set and then (a_context.e_feature.written_class.class_id = eiffel_system.system.any_id)
		end

end
