indexing

	description: 
		"Data representation of feature clause information.";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_CLAUSE

inherit
	S_ELEMENT_DATA

creation

	make

feature {NONE} -- Initialize

	make (feats: like features; exp: like export_i; com: like comment) is
			-- Set `features' to `feats', `export_i' to `exp and
			-- `comment' to `com'.
		require
			exp_exists: exp /= Void
			feats_exists: feats /= Void
			com_exists: com /= Void
		do
			features := feats
			export_i := exp
			comment := com
		ensure
			features_set: features = feats
			export_i_set: export_i = exp
			comment_set: comment = com
		end

feature -- Properties

	export_i: S_EXPORT_I
			-- Export status

	comment: S_FREE_TEXT_DATA
			-- Feature clause comment

	features: ARRAYED_LIST [S_FEATURE_DATA]
			-- Features for Current feature clause

feature -- Comparison

	same_export (exp: S_EXPORT_I): BOOLEAN is
			-- Is export same as `exp'?
		require
			valid_exp: exp /= Void
		do
			Result := export_i.same_as (exp)
		end

invariant
		
	valid_features: features /= Void
	valid_export: export_i /= Void
	valid_comment: comment /= Void

end -- class S_FEATURE_CLAUSE
