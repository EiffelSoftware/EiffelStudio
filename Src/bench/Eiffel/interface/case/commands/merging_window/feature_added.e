indexing

	description: "Class difference corresponding to a feature that has been %
				 %added (to the Case version) in a feature clause.";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_ADDED

inherit
	FEATURE_DIFF
		rename
			make as make_feat_diff
		end

	FEATURE_DIFF
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
			-- there is no old (Bench/code)version.
		require else
			nast_exists: nast /= Void
			no_oast: oast = Void
		do
				make_feat_diff (nast, oast)
				-- each diff has its own instance of the `new_prefix',
				-- All text lines of the current diff share the same 
				-- instance of `new_prefix' (much faster)
			new_prefix := clone (ti_Added)
		end

feature -- Properties

	is_current: BOOLEAN is
			-- Is Current class diff the currently processed diff?
		do
			Result := new_prefix.is_current
		end

	is_merged: BOOLEAN is
			-- Has Current diff been merged?
		do
			Result := new_prefix.is_merged
		end

feature -- Settings

	merge_with_new_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current diff between `old_class_ast' and 
			-- `new_class_ast', keeping the new version of the feature.
		local
			fc_num: INTEGER
		do
			fc_num := new_class_ast.feature_clause_of_feature (new_ast)
			check
				found: fc_num /= 0
			end
			old_class_ast.add_feature_to_feature_clause (fc_num, new_ast)
		end

	merge_with_old_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current diff between `old_class_ast' and 
			-- `new_class_ast', keeping the old version of the feature.
		local
			fc_num: INTEGER
		do
			fc_num := new_class_ast.feature_clause_of_feature (new_ast)
			check
				found: fc_num /= 0
			end
			new_class_ast.remove_feature_from_feature_clause (fc_num, new_ast)
		end

	set_is_current is
			-- Set Current difference as the one currently processed
			-- ("highlighed").
		do
			new_prefix.set_is_current
		end

	set_is_merged is
			-- Set Current difference as merged.
		do
			new_prefix.set_is_merged
		end

	unset_is_current is
			-- Set Current difference as a normal one (not "highlighed").
			--| Current diff is not the diff currently processed any more.
		do
			new_prefix.unset_is_current
		end

invariant
	new_prefix_exists: new_prefix /= Void
	no_old_prefix: old_prefix = Void
	new_ast_exists: new_ast /= Void
	no_old_ast: old_ast = Void

end -- class FEATURE_ADDED
