indexing
	description: "Fake AST node assembler for flatting."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FAKE_AST_ASSEMBLER

inherit
	SHARED_EIFFEL_PARSER

	PREFIX_INFIX_NAMES

	COMPILER_EXPORTER

feature -- Assembler

	normal_to_deferred_feature_as (a_feature_as: FEATURE_AS; a_list: LEAF_AS_LIST): FEATURE_AS is
			-- Make a normal feature as to a deferred feature as,
			-- replacing body, removing locals and resecue.
		require
			a_feature_as_is_routine: a_feature_as.body.is_routine
		local
			new_feature_as: FEATURE_AS
			l_routine_body: ROUTINE_AS
			l_index: INTEGER
		do
			new_feature_as := a_feature_as
			l_routine_body ?= new_feature_as.body.content
			check
				l_routine_body_not_void: l_routine_body /= Void
			end
			if a_list /= Void then
				if l_routine_body.routine_body /= Void then
					l_index := l_routine_body.routine_body.first_token (a_list).index
					l_routine_body.set_routine_body (deferred_content_with_index (l_index))
				else
					l_routine_body.set_routine_body (deferred_content)
				end
			else
				l_routine_body.set_routine_body (deferred_content)
			end
			l_routine_body.set_locals (Void)
			l_routine_body.set_rescue_clause (Void)
			Result := new_feature_as
		ensure
			result_not_void: Result /= Void
		end

	replace_name_from_feature (a_ast: FEATURE_AS; a_name: FEATURE_NAME; target_feature: FEATURE_I): FEATURE_AS is
			-- Replace name in `a_ast' with `a_name' using attributes in `target_feature'.
		require
			a_ast_not_void: a_ast /= Void
			a_name_not_void: a_name /= Void
			target_feature_not_void: target_feature /= Void
		local
			new_feature_as: FEATURE_AS
			f_name: FEATURE_NAME
			eiffel_list: EIFFEL_LIST [FEATURE_NAME]
			l_op: STRING_AS
			l_id: ID_AS
			l_is_frozen: BOOLEAN
		do
			f_name := a_name
			new_feature_as := a_ast
			l_is_frozen := f_name.is_frozen
			if target_feature.is_infix then
				create l_op.initialize (extract_symbol_from_infix (target_feature.feature_name), 0, 0, 0, 0)
				l_op.set_index (f_name.internal_name.index)
				create {INFIX_PREFIX_AS} f_name.initialize (l_op, True, Void)
			elseif target_feature.is_prefix then
				create l_op.initialize (extract_symbol_from_prefix (target_feature.feature_name), 0, 0, 0, 0)
				l_op.set_index (f_name.internal_name.index)
				create {INFIX_PREFIX_AS} f_name.initialize (l_op, False, Void)
			elseif target_feature.alias_name /= Void then
				create l_op.initialize (extract_alias_name (target_feature.alias_name), 0, 0, 0, 0)
				l_op.set_index (f_name.internal_name.index)
				create l_id.initialize (target_feature.feature_name)
				l_id.set_index (f_name.internal_name.index)
				create {FEATURE_NAME_ALIAS_AS} f_name.initialize (
					l_id, l_op, target_feature.has_convert_mark, Void, Void)
				if target_feature.is_binary then
					f_name.set_is_binary
				elseif target_feature.is_unary then
					f_name.set_is_unary
				end
			else
				create l_id.initialize (target_feature.feature_name)
				l_id.set_index (f_name.internal_name.index)
				create {FEAT_NAME_ID_AS} f_name.initialize (l_id)
			end
			f_name.set_is_frozen (l_is_frozen)
			create eiffel_list.make (1);
			eiffel_list.extend (f_name);
			new_feature_as.set_feature_names (eiffel_list);
			Result := new_feature_as
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	deferred_content: ROUT_BODY_AS is
			-- Deferred content
		local
			l_feat_text: STRING
			l_routine_as: ROUTINE_AS
		once
			l_feat_text := "feature feature_name is deferred end"
			entity_feature_parser.parse_from_string (l_feat_text)
			l_routine_as ?= entity_feature_parser.feature_node.body.content
			Result := l_routine_as.routine_body
		ensure
			result_not_void: Result /= Void
		end

	deferred_content_with_index (a_index: INTEGER): ROUT_BODY_AS
			-- Deffered content with index of the first token set.
		local
			l_deferred: DEFERRED_AS
		do
			l_deferred ?= deferred_content.twin
			check
				l_deferred_not_void: l_deferred /= Void
			end
			l_deferred.set_index (a_index)
			Result := l_deferred
		end

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

end
