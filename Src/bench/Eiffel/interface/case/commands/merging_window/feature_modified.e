indexing

	description: 
		"Class difference corresponding to a feature that has been %
		%modified in a feature clause, ie is different in the new %
		%(Case) version and the old (Bench/code) one.";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_MODIFIED

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

	make (nast, oast: like new_ast) is
			-- Create Current with the new (Case) version `nast' 
			-- and old (Bench/code) version `oast' of the considered 
			-- feature.
		require else
			nast_exists: nast /= Void
			oast_exists: oast /= Void
		do
			make_feat_diff (nast, oast)
				-- Each diff has its own instances of  `old_prefix'
				-- and `new_prefix'.
				-- All text lines of the current diff share the same 
				-- instance of `old_prefix' and `new_prefix' (much faster).
			new_prefix := clone (ti_Modified)
			old_prefix := new_prefix
		end

feature -- Properties

	is_current: BOOLEAN is
			-- Is Current class diff the currently processed diff?
		do
			Result := new_prefix.is_current
		end

	is_merged: BOOLEAN is
			-- Has Current class diff been solved?
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
			old_class_ast.replace_feature_of_feature_clause (fc_num, old_ast, new_ast)
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
			new_class_ast.replace_feature_of_feature_clause (fc_num, new_ast, old_ast)
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
	old_prefix_exists: old_prefix /= Void
	same_instance: old_prefix = new_prefix
	new_ast_exists: new_ast /= Void
	old_ast_exists: old_ast /= Void

end -- class FEATURE_MODIFIED
