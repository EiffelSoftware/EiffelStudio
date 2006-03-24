indexing
	description: "Object that represents a criterium of whether a feature is written in a certain class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEAT_WRITTEN_IN_CRI

inherit
	EQL_CRITERION

create
	make

feature{NONE} -- Initialization

	make (a_class: like written_class) is
			-- Initialize `written_class' with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			written_class := a_class
		ensure
			written_class_set: written_class = a_class
		end

feature -- Evaluation

	evaluate (a_context: EQL_CONTEXT): BOOLEAN is
		do
			Result :=  a_context.is_e_feature_set and then  (a_context.e_feature.written_class.class_id = written_class.class_id)
		end

feature{NONE} -- Implemenation

	written_class: CLASS_C
		-- Written class

end
