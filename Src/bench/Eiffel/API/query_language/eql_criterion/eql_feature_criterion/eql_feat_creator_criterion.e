indexing
	description: "Criterion to test if a feature is a creator"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEAT_CREATOR_CRITERION

inherit
	EQL_CRITERION

	SHARED_EIFFEL_PROJECT

feature -- Evaluation

	evaluate (a_context: EQL_CONTEXT): BOOLEAN is
		local
			l_creators: HASH_TABLE [EXPORT_I, STRING]
		do
			if  a_context.is_e_feature_set then
				l_creators := a_context.e_feature.associated_class.creators
				if l_creators = Void then
						-- Simply search for the version of `{ANY}.default_create'.
					Result := a_context.e_feature.rout_id_set.has (eiffel_system.system.default_create_id)
				elseif not l_creators.is_empty then
					Result := l_creators.has (a_context.e_feature.name)
				end
			end
		end

end
