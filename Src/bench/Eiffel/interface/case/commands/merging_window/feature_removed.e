indexing

	description: 
		"Class difference corresponding to a feature that has been %
		%removed (from the Bench/code version) in a feature clause.";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_REMOVED

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
			-- Create Current with the old (Bench/code) version `oast' 
			-- of the considered feature. `nast' is Void, since
			-- there is no new (Case) version.
		require else
			oast_exists: oast /= Void
			no_nast: nast = Void
		do
			make_feat_diff (nast, oast)
				-- each diff has its own instance of the `old_prefix',
				-- All text lines of the current diff share the same 
				-- instance of `old_prefix' (much faster)
			old_prefix := clone (ti_Removed)
		end

feature -- Properties

	is_current: BOOLEAN is
			-- Is Current class diff the currently processed diff?
		do
			Result := old_prefix.is_current
		end

	is_merged: BOOLEAN is
			-- Has Current diff been merged?
		do
			Result := old_prefix.is_merged
		end

feature -- Settings

	merge_with_new_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current diff between `old_class_ast' and 
			-- `new_class_ast', keeping the new version of the feature
			-- (ie removing it).
		local
			fc_num: INTEGER
		do
			fc_num := old_class_ast.feature_clause_of_feature (old_ast)
			check
				found: fc_num /= 0
			end
			old_class_ast.remove_feature_from_feature_clause (fc_num, old_ast)
		end

	merge_with_old_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current diff between `old_class_ast' and 
			-- `new_class_ast', keeping the old version of the feature.
		local
			fc_num: INTEGER
		do
			fc_num := old_class_ast.feature_clause_of_feature (old_ast)
			check
				found: fc_num /= 0
			end
			new_class_ast.add_feature_to_feature_clause (fc_num, old_ast)
		end

	set_is_current is
			-- Set Current difference as the one currently processed
			-- ("highlighed").
		do
			old_prefix.set_is_current
		end

	set_is_merged is
			-- Set Current difference as merged.
		do
			old_prefix.set_is_merged
		end

	unset_is_current is
			-- Set Current difference as a normal one (not "highlighed").
			--| Current diff is not the diff currently processed any more.
		do
			old_prefix.unset_is_current
		end

invariant
	no_new_prefix: new_prefix = Void
	old_prefix_exists: old_prefix /= Void
	old_ast_exists: old_ast /= Void
	no_new_ast: new_ast = Void

end -- class FEATURE_REMOVED
