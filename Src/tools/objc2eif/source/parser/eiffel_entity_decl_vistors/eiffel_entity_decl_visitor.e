note
	description: "A general Eiffel entity declaration visitor."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_ENTITY_DECL_VISITOR

feature -- Operations

	visit_class_decl (c: EIFFEL_CLASS_DECL)
			-- Visit a class declaration.
		deferred
		end

	visit_feature_decl (r: EIFFEL_FEATURE_DECL)
			-- Visit a feature declaration.
		deferred
		end

end
