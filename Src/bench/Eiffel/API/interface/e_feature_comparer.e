indexing
	description: "Comparison of E_FEATURE instances"
	date: "$Date$"
	revision: "$Revision$"

class
	E_FEATURE_COMPARER

feature -- Equality

	same_feature (a_feat, a_other_feat: E_FEATURE): BOOLEAN is
			-- Is `a_feat' same as `a_other_feat'?
		do
			if a_feat = Void then
				Result := a_other_feat = Void
			else
				Result := a_other_feat /= Void and then a_feat.same_as (a_other_feat)
			end
		end
		
end
