indexing
	description: "Formatting decorator for feature ast (flat and breakable format)."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FEAT_TEXT_FORMATTER_DECORATOR

inherit
	TEXT_FORMATTER_DECORATOR
		rename
			execute as old_execute
		redefine
			put_origin_comment, chained_assertion
		end

create
	make

feature -- Property

	assert_server: ASSERTION_SERVER;

feature -- Execution

	execute (a_target_feat: E_FEATURE) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		require
			class_set: current_class /= Void
			valid_target_feat: a_target_feat /= Void
		local
			f_ast: FEATURE_AS
			written_in_class: CLASS_C
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
				initialize (text_formatter)
				System.set_current_class (current_class);
				Inst_context.set_cluster (current_class.cluster);
				begin;
				written_in_class := target_feat.written_class;
				if written_in_class /= current_class then
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

				feature_comments := f_ast.comment (match_list_server.item (written_in_class.class_id))
				create assert_server.make_for_feature (target_feat, f_ast);
				init_feature_context (source_feat, target_feat, f_ast);

				indent;
				ast_output_strategy.format (f_ast)
				if ast_output_strategy.has_error then
					put_new_line
					process_comment_text ("-- An error occured, which was due to a compilation failure.", Void)
				end
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
			Precursor {TEXT_FORMATTER_DECORATOR};

				--| Print export status.
			if not export_status.is_all then
				process_comment_text (ti_Dashdash, Void)
				put_space;
				process_comment_text ("(export status ", Void);
				export_status.format (Current);
				process_comment_text (")", Void);
				put_new_line
			end;
		end;

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		do
			Result := assert_server.current_assertion
		end;

feature {NONE} -- Feature comments

	export_status: EXPORT_I;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FEAT_TEXT_FORMATTER_DECORATOR
