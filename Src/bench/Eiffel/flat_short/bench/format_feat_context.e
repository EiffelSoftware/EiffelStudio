indexing

	description: 
		"Formatting context for feature ast (flat and breakable format).";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_FEAT_CONTEXT

inherit

	FORMAT_CONTEXT_B
		rename
			execute as old_execute
		redefine
			put_origin_comment, chained_assertion
		end

creation

	make

feature -- Property

	assert_server: ASSERTION_SERVER;

feature -- Execution

	execute (target_feat: FEATURE_I) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		require
			class_set: class_c /= Void 
			valid_target_feat: target_feat /= Void 
		local
			start_pos, end_pos: INTEGER;
			file: RAW_FILE;
			f_ast: FEATURE_AS_B;
			source_feat: FEATURE_I;
			s_table: SELECT_TABLE;
			rout_fsas: ROUTINE_FSAS;
			rout_id_set: ROUT_ID_SET;
			comment: EIFFEL_COMMENTS;
			nbr, i, rout_id: INTEGER;
			written_in_class: CLASS_C
		do
			if not rescued then
				execution_error := false;
				Error_handler.wipe_out;
				f_ast := Body_server.item (target_feat.body_id)
				export_status := target_feat.export_status;
				!! format_stack.make;
				!! text.make;
				!! format;
				last_was_printed := True;
				format_stack.extend (format);
				System.set_current_class (class_c);
				Inst_context.set_cluster (class_c.cluster);
				begin;
				written_in_class := target_feat.written_class;
				if written_in_class /= class_c then
						-- The target_feat is the evaluated feature_i
						-- from class `class_c' (args, and result type
						-- are evaluated). Need the feature_i entry in
						-- feature table of written_in_class
						-- (the evaluation of args and result in the 
						-- written_in class of feature_).
					s_table := written_in_class.feature_table.origin_table;
					rout_id_set := target_feat.rout_id_set;
					nbr := rout_id_set.count;
					from
						i := 1
					until
						i > nbr or else source_feat /= Void
					loop
							-- Find until routine is found.
						rout_id := rout_id_set.item (1);
						if rout_id < 0 then
							rout_id := - rout_id
						end;
						source_feat := s_table.item (rout_id);
						i := i + 1;
					end;
					if source_feat = Void then
						source_feat := target_feat
					end
				else
					source_feat := target_feat
				end;
				f_ast := f_ast.new_ast;
				rout_fsas ?= f_ast.body.content;
				!! file.make (written_in_class.file_name);
				start_pos := f_ast.start_position;
				end_pos := f_ast.end_position;
				if file.exists then
					if rout_fsas /= Void then
						!! eiffel_file.make_for_feature_comments (file,
							start_pos, end_pos);
						comment := trailing_comment (start_pos);
						rout_fsas.set_comment (comment);
					end;
					!! assert_server.make_for_feature (target_feat, f_ast);
					init_feature_context (source_feat, target_feat, f_ast);
					indent;
					f_ast.format (Current);
					if rout_fsas = Void then
							--! Must have been an attribute or constant
						indent;
						indent;
						if written_in_class /= class_c then
							put_text_item (ti_Dashdash);
							put_space;
							put_comment_text ("(from ");
							put_class_name (written_in_class);
							put_comment_text (")");
							new_line;
							print_export_status;
						else
							print_export_status
						end;
					end
				end
				commit;
				System.set_current_class (Void);
				Inst_context.set_cluster (Void);
			else
				execution_error := True;
				rescued := False
			end
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end;
		end;

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		local
			chained_prec: CHAINED_ASSERTIONS;
			t_feat: FEATURE_I;
			assert_id_set: ASSERT_ID_SET
		do
			t_feat := global_adapt.target_enclosing_feature;
			assert_id_set := t_feat.assert_id_set
			if assert_id_set /= Void and then
				assert_id_set.count > 0
			then
				chained_prec :=
					assert_server.chained_assertion_of_fid (t_feat.feature_id)
			end
		end;

feature {NONE} -- Feature comments 

	export_status: EXPORT_I;

	put_origin_comment is
		local
			s: STRING;
			c: CLASS_C;
		do
			if
				global_adapt.source_enclosing_class
				/= global_adapt.target_enclosing_class
			then
				!!s.make (50);
				put_text_item (ti_Dashdash);
				put_space;
				put_comment_text ("(from ");
				c := global_adapt.source_enclosing_class;
				put_class_name (c);
				put_comment_text (")");
				new_line;
			end;
			print_export_status;
		end;

	print_export_status is
		do
			if not export_status.is_all then
				put_text_item (ti_Dashdash);
				put_space;
				put_comment_text ("(export status ");
				export_status.format (Current);
				put_comment_text (")");
				new_line;
			end;
		end;

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
