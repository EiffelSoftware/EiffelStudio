indexing

	description: 
		"Registration of comments for AST structures.";
	date: "$Date$";
	revision: "$Revision $"

class COMMENT_REGISTRATION

inherit

	AST_REGISTRATION;
	SHARED_TMP_SERVER;
	COMPILER_EXPORTER

creation
	
	make

feature {NONE} -- Initialization

	make (ast: CLASS_AS; class_c: CLASS_C) is
			-- Initialize comment registration for complied
			-- class `class_c' with ast structure `class_ast'.
		require
			valid_class_ast: ast /= Void;
			valid_class_c: class_c /= Void;
		do
			!! eiffel_file.make (class_c.file_name, ast.end_position);
			!! class_comments.make (class_c.class_id, 20);
			class_ast := ast
		ensure
			set: class_ast = ast	
		end;

feature -- Access

	already_extracted_comments: BOOLEAN is False
			-- Has the comments been extracted for the
			-- current class ast being registered

feature -- Update

	register is
			-- Register comments extracted from `class_ast' into
			-- the temporary class comment server.
		do
			class_ast.register (Current);
			if not class_comments.is_empty then
				Tmp_class_comments_server.put (class_comments)
			end
		ensure
			in_tmp_class_comments_server: not class_comments.is_empty implies
						Tmp_class_comments_server.has (class_comments.class_id)
		end;

feature {AST_EIFFEL} -- Element change

	register_feature (feature_as: FEATURE_AS) is
			-- Register feature `feature_as'.
		local
			comments: EIFFEL_COMMENTS
		do
			comments := eiffel_file.current_feature_comments;
			if comments /= Void then
				class_comments.put (comments, feature_as.start_position);
			end
		end;

	register_feature_clause (feature_clause: FEATURE_CLAUSE_AS) is
			-- Register feature_clause `feature_clause' after registering
            -- features.
		local
			comments: EIFFEL_COMMENTS
		do
			comments := eiffel_file.current_feature_clause_comments;
			if comments /= Void then
				class_comments.put (comments, feature_clause.position);
			end
		end;

	register_invariant (invariant_part: INVARIANT_AS) is
			-- Register invariant `invariant_part'.
		do
			-- Do nothing
		end;

feature {NONE} -- Implementation properities

	class_comments: CLASS_COMMENTS
			-- Comments hashed on start position of AST

invariant

	non_void_eiffel_file: eiffel_file /= Void;
	non_void_class_comments: class_comments /= Void;
	non_void_ast: class_ast /= Void

end -- class COMMENT_REGISTRATION
