
-- Traversal unit for dead code removal

class TRAVERSAL_UNIT

create

	make

feature

	a_feature: FEATURE_I;
			-- Feature to traverse

	static_class: CLASS_C;
			-- Class after which possible redefinitions of
			-- `a_feature' have to be traversed also

	make (f: FEATURE_I; c: CLASS_C) is
			-- Initialization
		require
			good_feature: f /= Void;
			good_class: c /= Void;
			consistency: c.conform_to (f.written_class)
		do
			a_feature := f;
			static_class := c
		end

end
