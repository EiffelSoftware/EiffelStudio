indexing

	description: 
		"Abstract class for registering AST structures.";
	date: "$Date$";
	revision: "$Revision $"

deferred class AST_REGISTRATION

feature -- Properties

	class_ast: CLASS_AS;
			-- Class AST being registered

	eiffel_file: EIFFEL_FILE;
			-- Eiffel file for current class analyzed

feature -- Access

	already_extracted_comments: BOOLEAN is
			-- Has the comments been extracted for the
			-- current class ast being registered
		deferred
		end;

feature {AST_EIFFEL} -- Element change

	register_feature (feature_as: FEATURE_AS) is
			-- Register feature `feature_as'.
		require
			valid_feature_as: feature_as /= Void
		deferred
		end;

	register_feature_clause (feature_clause: FEATURE_CLAUSE_AS) is
			-- Register feature_clause `feature_clause' after registering
            -- features.
		require
			valid_feature_clause: feature_clause /= Void
		deferred
		end;

	register_invariant (invariant_part: INVARIANT_AS) is
			-- Register invariant `invariant_part'.
		require
			valid_invariant: invariant_part /= Void
		deferred
		end;

end -- class AST_REGISTRATION
