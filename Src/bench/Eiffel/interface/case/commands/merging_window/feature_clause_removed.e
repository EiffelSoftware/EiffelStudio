indexing

	description: 
		"Class difference corresponding to a feature clause %
		%that has been removed (from the Eiffel code version).";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_CLAUSE_REMOVED

inherit
	FEATURE_CLAUSE_DIFF
		rename
			make as make_fc_diff
		end

	FEATURE_CLAUSE_DIFF
		redefine
			make
		select
			make
		end

creation
	make

feature -- Initialization

	make (nast: like new_ast; oast: like old_ast) is
			-- Create Current with the new (Case) version `nast' 
			-- of the considered feature. `oast' is Void, since
			-- there is no old (Bench/code) version.
		require else
			oast_exists: oast /= Void
			no_nast: nast = Void
		do
			make_fc_diff (nast, oast)
				-- each diff has its own instance of the `new_prefix',
				-- All text lines of the current diff share the same 
				-- instance of `new_prefix' (much faster)
			old_prefix := clone (ti_Removed)
		end

end -- class FEATURE_CLAUSE_REMOVED
