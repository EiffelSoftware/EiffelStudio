note
	description: "Factory of queries that can be used to validate stones to avoid code duplication."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_VETO_FACTORY

feature -- Various thing you can allow.

	can_drop_debuggable_feature_or_class (a_stone: ANY): BOOLEAN
			-- Can `a_stone' be dropped into current command?
		local
			l_fst: FEATURE_STONE
			l_cst: CLASSC_STONE
			l_stone: STONE
		do
			l_stone ?= a_stone
			if l_stone /= Void and then l_stone.is_valid then
				l_fst ?= l_stone
				if l_fst /= Void then
					Result := l_fst.e_feature /= Void and then l_fst.e_feature.is_debuggable
				else
					l_cst ?= l_stone
					if l_cst /= Void then
						Result := l_cst.e_class.is_debuggable
					end
				end
			end
		end

end
