class FORMAT_FEAT_CONTEXT

inherit

	FORMAT_CONTEXT
		redefine
			start_position, put_feature_comments
		end

creation

	format_feature

feature

	format_feature (s, t: CLASS_C ast: FEATURE_AS) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		require
			valid_args: t /= Void and then ast /= Void
		local
			first_format: LOCAL_FORMAT;
			end_position: INTEGER;
			file: UNIX_FILE;
		do
			!!previous.make
			!!text.make
			!!first_format.make(t.actual_type)
			previous.add (first_format)
			class_c := t
			System.set_current_class (class_c)
			Inst_context.set_cluster (class_c.cluster)
			begin
			if s /= t then
				set_source_class (s);
			end;
			start_position := ast.start_position
			end_position := ast.end_position
			!!file.make (class_c.file_name)
			!!eiffel_file.make_for_feature_comments (file,
					start_position, end_position)
			ast.format (Current)
			commit
			System.set_current_class (Void)
			Inst_context.set_cluster (Void)
		end

	put_feature_comments is
			-- Put feature comments into format
		do
			if trailing_comment_exists then
				put_trailing_comment 
			end
		end;

feature {NONE} -- Feature comments 

	start_position: INTEGER
			-- Start position of feature 

	eiffel_file: EIFFEL_FILE
			-- For format feature 

	trailing_comment_exists: BOOLEAN is
			-- Is there a comment after start_position?
		local
			file: EIFFEL_FILE
		do
			if start_position >= 0 then
				file := eiffel_file
				if file /= void then
					file.go_after (start_position)
					Result := file.trailing_comment  /= void
				end
			end
		end
 
 
	put_trailing_comment is
		local
			file: EIFFEL_FILE
			comment: EIFFEL_COMMENTS
		do
			if start_position >= 0 then
				file := eiffel_file
				if file /= void then
					file.go_after (start_position)
					comment := file.trailing_comment
				end
				if comment /= void then
					begin
					indent_one_more
					indent_one_more
					next_line
					put_comment (comment)
					commit
				end
			end
		end

end	
