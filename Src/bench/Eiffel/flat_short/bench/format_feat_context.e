indexing

	description: 
		"Formatting context for feature ast (flat and breakable format).";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_FEAT_CONTEXT

inherit

	FORMAT_CONTEXT_B
		rename
			execute as old_execute,
			put_origin_comment as old_put_origin_comment
		redefine
			chained_assertion
		end
	FORMAT_CONTEXT_B
		rename
			execute as old_execute
		redefine
			chained_assertion, put_origin_comment
		select
			put_origin_comment
		end

creation

	make

feature -- Property

	assert_server: ASSERTION_SERVER;

feature -- Execution

	execute (a_target_feat: E_FEATURE) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		require
			class_set: class_c /= Void 
			valid_target_feat: a_target_feat /= Void 
		local
			start_pos, end_pos: INTEGER;
			file: RAW_FILE;
			f_ast: FEATURE_AS_B;
			source_feat: FEATURE_I;
			s_table: SELECT_TABLE;
			rout_as: ROUTINE_AS;
			rout_id_set: ROUT_ID_SET;
			comment: EIFFEL_COMMENTS;
			nbr, i, rout_id: INTEGER;
			written_in_class: CLASS_C;
			c_comments: CLASS_COMMENTS;
			target_feat: FEATURE_I;
			f_table: FEATURE_TABLE
		do
			if not rescued then
				f_table := class_c.feature_table;
				target_feat := f_table.item (a_target_feat.name);
				execution_error := false;
				Error_handler.wipe_out;
				f_ast := target_feat.body;
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
					s_table := f_table.origin_table;
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
				rout_as ?= f_ast.body.content;
				start_pos := f_ast.start_position;
				if written_in_class.is_precompiled then
					if Class_comments_server.has 
							(written_in_class.id) 
					then
						c_comments := 
							Class_comments_server.disk_item 
									(written_in_class.id);
						feature_comments := c_comments.item (start_pos)
					end
				else
					!! file.make (written_in_class.file_name);
					if file.exists and then rout_as /= Void then
						end_pos := rout_as.body_start_position;
						!! eiffel_file.make_with_positions (file.name,
							start_pos, end_pos);
						eiffel_file.set_current_feature (f_ast);
						feature_comments := 
								eiffel_file.current_feature_comments;
					end;
				end;
				!! assert_server.make_for_feature (target_feat, f_ast);
				init_feature_context (source_feat, target_feat, f_ast);
				indent;
				f_ast.format (Current);
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

feature -- Element change

	put_origin_comment is
			-- Print the origin comment if necessary and
			-- print the export status.
		do
			old_put_origin_comment;
			print_export_status
		end;

feature {NONE} -- Feature comments 

	export_status: EXPORT_I;

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

end	
