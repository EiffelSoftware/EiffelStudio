indexing
	description: "Formatting context for feature ast (flat and breakable format).";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_FEAT_CONTEXT

inherit
	FORMAT_CONTEXT
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

	execute (a_target_feat: E_FEATURE) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		require
			class_set: class_c /= Void 
			valid_target_feat: a_target_feat /= Void 
		local
			start_pos, end_pos: INTEGER
			file: RAW_FILE
			f_ast: FEATURE_AS
			rout_as: ROUTINE_AS
			written_in_class: CLASS_C
			c_comments: CLASS_COMMENTS
			source_feat: FEATURE_I
			target_feat: FEATURE_I
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
		do
			if not rescued then
				prev_class := System.current_class
				prev_cluster := Inst_context.cluster
				target_feat := a_target_feat.associated_feature_i
				execution_error := false
				Error_handler.wipe_out
				f_ast := target_feat.body
				export_status := target_feat.export_status
				create format_stack.make
				create text.make
				create format
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
						-- The feature name of the ast structure where
						-- it was defined can be used to retrieve
						-- the source_feat.
					source_feat := written_in_class.feature_named 
							(f_ast.feature_names.first.internal_name)			
					if source_feat = Void then
						-- Shouldn't happen - but just in case
						source_feat := target_feat
					end
				else
					source_feat := target_feat
				end;
				rout_as ?= f_ast.body.content;
				start_pos := f_ast.start_position;
				if written_in_class.is_precompiled then
					if Class_comments_server.has (written_in_class.class_id) then
						c_comments := Class_comments_server.disk_item (written_in_class.class_id);
						feature_comments := c_comments.item (start_pos)
					end
				else
					!! file.make (written_in_class.file_name);
					if file.exists then
						if rout_as /= Void then
							end_pos := rout_as.body_start_position;
							!! eiffel_file.make_with_positions (file.name, start_pos, end_pos);
							eiffel_file.set_current_feature (f_ast);
							feature_comments := eiffel_file.current_feature_comments;
						elseif f_ast.is_attribute then
							!! eiffel_file.make_with_positions (file.name, f_ast.start_position, f_ast.end_position);
							eiffel_file.set_current_feature (f_ast);
							feature_comments := eiffel_file.current_feature_comments;
						end
					end;
				end;
				!! assert_server.make_for_feature (target_feat, f_ast);
				init_feature_context (source_feat, target_feat, f_ast);
				indent;
				if written_in_class.lace_class.hide_implementation then	
					set_is_short
				end;
				f_ast.format (Current);
				commit;
			else
				execution_error := True;
				rescued := False
			end
			System.set_current_class (prev_class);
			Inst_context.set_cluster (prev_cluster);
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end;
		end;

feature -- Element change

	put_origin_comment is
			-- Print the origin comment if necessary and
			-- print the export status.
		do
			{FORMAT_CONTEXT} Precursor;

				--| Print export status.
			if not export_status.is_all then
				put_text_item (ti_Dashdash);
				put_space;
				put_comment_text ("(export status ");
				export_status.format (Current);
				put_comment_text (")");
				new_line;
			end;
		end;

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		do
			Result := assert_server.current_assertion
		end;

feature {NONE} -- Feature comments 

	export_status: EXPORT_I;

end	
