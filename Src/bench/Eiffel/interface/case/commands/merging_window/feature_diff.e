indexing

	description: 
		"Single difference between two class asts. %
		%Difference on a feature level only";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	FEATURE_DIFF

inherit
	CLASS_DIFF
		redefine
			new_ast, old_ast
		end

feature -- Properties

	is_merged: BOOLEAN is
			-- Has Current class diff been merged?
		deferred
		end

	new_ast, old_ast: EXT_FEATURE_AS
			-- Ast corresponding to the new (respectively old) version
			-- of the considered feature ast.
			--| May be Void

feature -- Settings

	merge_with_new_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current class difference, by keeping the new
			-- version.
		require
			old_class_ast_exists: old_class_ast /= Void
			new_class_ast_exists: new_class_ast /= Void
		deferred
		end

	merge_with_old_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current class difference, by keeping the old
			-- version.
		require
			old_class_ast_exists: old_class_ast /= Void
			new_class_ast_exists: new_class_ast /= Void
		deferred
		end

	set_is_merged is
			-- Set Current difference as merged.
		deferred
		ensure
			is_merged_set: is_merged
		end

end -- class FEATURE_DIFF





