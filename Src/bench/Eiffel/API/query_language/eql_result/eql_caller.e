indexing
	description: "Object that represents a caller of a feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_CALLER

inherit
	EQL_SOFTWARE_SINGLE_SCOPE

feature -- Status

	associated_class: CLASS_C is
			-- Compiled class associated with current
		deferred
		end

	name: STRING is
			-- Name of current caller
		deferred
		end

	is_feature: BOOLEAN is
			-- Does current represent a feature?
		do
			Result := is_feature_scope
		ensure
			good_result: Result implies is_feature_scope
		end

	is_invariant: BOOLEAN is
			-- Does current represent an invariant part?
		do
			Result := is_invariant_scope
		ensure
			good_result: Result implies is_invariant_scope
		end

end
