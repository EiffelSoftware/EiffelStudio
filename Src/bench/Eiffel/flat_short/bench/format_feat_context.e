class FORMAT_FEAT_CONTEXT

inherit

	FORMAT_CONTEXT
		rename
			execute as old_execute
		redefine
			start_position
		end

creation

	make

feature

	execute (feat: FEATURE_I) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		require
			class_set: class_c /= Void 
			valid_arg: feat /= Void 
		local
			first_format: LOCAL_FORMAT;
			end_position: INTEGER;
			file: UNIX_FILE;
			assert_server: ASSERT_SERVER;
			ast: FEATURE_AS;
			target_feat: FEATURE_I;
			s_table: SELECT_TABLE;
			rout_fsas: ROUTINE_FSAS;
			comment: EIFFEL_COMMENTS;
		do
			ast := Body_server.item (feat.body_id)
			!!previous.make;
			!!text.make;
			!!first_format.make (class_c.actual_type);
			previous.add (first_format);
			System.set_current_class (class_c);
			Inst_context.set_cluster (class_c.cluster);
			begin;
			if feat.written_class /= class_c then
				set_source_class (feat.written_class);
				s_table := class_c.feature_table.origin_table;
				target_feat := s_table.item (feat.rout_id_set.first);
			else
				target_feat := feat
			end;
			ast := ast.new_ast;
			rout_fsas ?= ast.body.content;
			!! file.make (class_c.file_name);
			start_position := ast.start_position;
			end_position := ast.end_position;
			!! eiffel_file.make_for_feature_comments (file,
					start_position, end_position);
			comment := trailing_comment (start_position);
			if rout_fsas /= Void then
				rout_fsas.set_comment (comment);
			end;
			!! assert_server.make_for_feature (feat, ast);
			set_context_features (feat, target_feat);
			indent_one_more;
			ast.format (Current);
			if rout_fsas = Void and then comment /= Void then
				--! Must have been an attribute or constant
				begin;
					indent_one_more;
					indent_one_more;
					next_line;
					put_comment (comment);
				commit;
			end
			commit;
			System.set_current_class (Void);
			Inst_context.set_cluster (Void);
		end

feature {NONE} -- Feature comments 

	start_position: INTEGER
			-- Start position of feature 

	eiffel_file: EIFFEL_FILE
			-- For format feature 

	trailing_comment (start_pos: INTEGER): EIFFEL_COMMENTS is
		local
			file: EIFFEL_FILE
		do
			if start_pos >= 0 then
				file := eiffel_file;
				if file /= Void then
					file.go_after (start_pos);
					Result := file.trailing_comment
				end
			end
		end

end	
