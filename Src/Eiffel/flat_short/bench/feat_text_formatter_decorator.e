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

	EXPORT_FORMATTER
		rename
			format as format_export
		end

	FAKE_AST_ASSEMBLER

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
			prev_cluster: CONF_GROUP
			l_match_list: LEAF_AS_LIST
			l_deep_twined: BOOLEAN
		do
			if not rescued then
				prev_class := System.current_class
				prev_cluster := Inst_context.group
				target_feat := a_target_feat.associated_feature_i
				if target_feat = Void then
						-- This could happen when trying to look at a feature which is not yet
						-- part of the FEATURE_TABLE of a class. See bug#11168.
					execution_error := True
				else
					execution_error := False
					Error_handler.wipe_out
					f_ast := target_feat.body
					export_status := target_feat.export_status
					initialize (text_formatter)
					System.set_current_class (current_class);
					Inst_context.set_group (current_class.group);
					begin;
				
						-- We use access_class as the written class so that replicated features are retrieved correctly		
					written_in_class := target_feat.access_class;
					if written_in_class /= current_class then
							-- Retrieve source feature.
						source_feat := a_target_feat.written_feature.associated_feature_i
						if source_feat = Void then
							-- Shouldn't happen - but just in case
							source_feat := target_feat
						end
					else
						source_feat := target_feat
					end;

					l_match_list := match_list_server.item (written_in_class.class_id)

						-- We only display one name in a feature_as.
					if f_ast.feature_names.count > 1 then
						f_ast := replace_name_from_feature (f_ast.deep_twin, f_ast.feature_names.first, source_feat)
						l_deep_twined := True
					end
						-- If the target feature is an undefined one, we create a fake ast.
					if target_feat.is_deferred and then not source_feat.is_deferred then
						if not l_deep_twined then
							f_ast := f_ast.deep_twin
						end
						f_ast := normal_to_deferred_feature_as (f_ast, l_match_list)
					end

					if {l_feat: !E_FEATURE} a_target_feat then
						feature_comments := (create {COMMENT_EXTRACTOR}).feature_comments (l_feat)
					end

					create assert_server.make_for_feature (target_feat, f_ast);
					init_feature_context (source_feat, target_feat, f_ast);

					indent;
					put_new_line
					ast_output_strategy.format (f_ast)
					if ast_output_strategy.has_error then
						put_new_line
						print_error
					end

					commit;
				end
			else
				execution_error := True;
				rescued := False
			end
			System.set_current_class (prev_class);
			Inst_context.set_group (prev_cluster);
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
				format_export (Current, export_status)
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

	print_error is
			-- Print error if any.
		local
			l_array: ARRAYED_LIST [STRING]
		do
			l_array := ast_output_strategy.error_message
			process_comment_text ("-- Error(s) occurred, which was due to a compilation failure.", Void)
			put_new_line
			from
				l_array.start
			until
				l_array.after
			loop
				process_comment_text ("-- ", Void)
				process_comment_text (l_array.item, Void)
				put_new_line
				l_array.forth
			end
		end

	export_status: EXPORT_I;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
