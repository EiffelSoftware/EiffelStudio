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

	make (feats: like features; exp: like export_i) is
			-- Set features to `feats' and export_i to `exp'.
		require
			valid_exp: exp /= Void;
			valid_feats: feats /= Void;
		do
			features := feats;
			export_i := exp
		ensure
			features_set: features = feats;
			export_i_set: export_i = exp
		end;

feature -- Properties

	export_i: S_EXPORT_I;
			-- Export status

	comment: S_FREE_TEXT_DATA
			-- Future purposes when we want comments for
			-- the feature clause
			-- (For the first release of ecase only public
			-- and private clauses are recorded)

	features: ARRAYED_LIST [S_FEATURE_DATA];
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
		
	valid_features: features /= Void;
	valid_export: export_i /= Void
			
end -- class S_FEATURE_CLAUSE
