indexing

	description: 
		"Single difference between two class asts. %
		%Difference on a feature clause level only";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_CLAUSE_DIFF

inherit
	CLASS_DIFF
		redefine
			new_ast, old_ast
		end

creation

feature -- Properties

	new_ast, old_ast: EXT_FEATURE_CLAUSE_AS
			-- Ast corresponding to the new (respectively old) version
			-- of the considered feature ast.
			--| May be Void

feature {NONE} -- Inapplicable

	is_current: BOOLEAN
			-- No notion of currently processed diff for feature 
			-- clause diffs

	set_is_current is
			-- No notion of currently processed diff for feature 
			-- clause diffs
		do
			is_current := True
				--| Only to fulfill the inherited postcondition			
		end

	unset_is_current is
			-- No notion of currently processed diff for feature 
			-- clause diffs
		do
			is_current := False
				--| Only to fulfill the inherited postcondition			
		end

end -- class FEATURE_CLAUSE_DIFF





