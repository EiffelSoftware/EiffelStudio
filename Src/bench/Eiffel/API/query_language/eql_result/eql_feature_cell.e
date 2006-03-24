indexing
	description: "Object that represents a cell for e_feature used in EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE_CELL

create
	make_with_feature

feature{NONE} -- Initialization

	make_with_feature (a_feature: like e_feature) is
			-- Initialize `e_feature' with `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			set_e_feature (a_feature)
		end

feature -- Status reporting

	is_e_feature_set: BOOLEAN is
			-- Is `e_feature' set?
		do
			Result := e_feature /= Void
		ensure
			good_result: Result implies e_feature /= Void
		end

feature -- Access

	e_feature: E_FEATURE
			-- Feature in current context

	set_e_feature (ft: E_FEATURE) is
			-- Assign `ft' to `e_feature'.
		do
			e_feature := ft
		end

end
