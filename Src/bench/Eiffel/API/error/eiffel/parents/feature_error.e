-- Abstract description of error in third pass

deferred class FEATURE_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end

feature 

	feature_name: STRING;
			-- Feature name involved in the error
			-- [if Void it is in the invariant]

	set_feature_name (i: STRING) is
			-- Assign `i' to `feature_name'.
		do
			feature_name := i;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
        do
			if feature_name = Void then
				a_clickable.put_string ("%Tin invariant%N");
			else
				a_clickable.put_string ("%Tin feature `");
-- FIXME
-- 				Should be a feature stone
--				a_clickable.put_clickable_string (
--					System.class_of_id (class_id).feature_named (feature_name),
--					feature_name);
				a_clickable.put_string (feature_name);
				a_clickable.put_string ("'%N")
			end
		end

end
