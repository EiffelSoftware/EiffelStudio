-- Error for join rule when argument number is not the same

class VDJR 

inherit

	EIFFEL_ERROR
	
feature

	old_feature: FEATURE_I;
			-- Inherited feature

	new_feature: FEATURE_I;
			-- Joined feature

	code: STRING is "VDJR";
			-- Error code

	init (old_feat, new_feat: FEATURE_I) is
			-- Initialization
		require
			not (old_feat = Void or else new_feat = Void);
		do
			old_feature := old_feat;
			new_feature := new_feat;
			class_id := System.current_class.id;
		end;

end
