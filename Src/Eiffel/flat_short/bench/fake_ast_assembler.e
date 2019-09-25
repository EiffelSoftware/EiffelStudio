note
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

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Assembler

	normal_to_deferred_feature_as (a_feature_as: FEATURE_AS; a_list: LEAF_AS_LIST): FEATURE_AS
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

	replace_name_from_feature (a_ast: FEATURE_AS; a_name: FEATURE_NAME; target_feature: FEATURE_I): FEATURE_AS
			-- Replace name in `a_ast' with `a_name' using attributes in `target_feature'.
		require
			a_ast_not_void: a_ast /= Void
			a_name_not_void: a_name /= Void
			target_feature_not_void: target_feature /= Void
		local
			new_feature_as: FEATURE_AS
			f_name: FEATURE_NAME
			f_name_alias_as: FEATURE_NAME_ALIAS_AS
			eiffel_list: EIFFEL_LIST [FEATURE_NAME]
			l_op: STRING_AS
			l_id: ID_AS
			l_frozen_keyword: KEYWORD_AS
			l_aliases: ARRAYED_LIST [ALIAS_NAME_INFO]
		do
			f_name := a_name
			new_feature_as := a_ast
			l_frozen_keyword := f_name.frozen_keyword
			if
				target_feature.has_alias and then
				attached target_feature.alias_names as l_alias_names and then
				not l_alias_names.is_empty and then
				attached l_alias_names.first as l_first_alias_name
			then
				create l_op.initialize (extract_alias_name (l_first_alias_name), 0, 0, 0, 0, 0, 0, 0)
				l_op.set_index (f_name.internal_name.index)
				create l_id.initialize (target_feature.feature_name)
				l_id.set_index (f_name.internal_name.index)
				create l_aliases.make (1)
				l_aliases.extend (create {ALIAS_NAME_INFO}.make (Void, l_op))
				create f_name_alias_as.initialize_with_list (l_id, l_aliases, Void)
				f_name_alias_as.has_convert_mark := target_feature.has_convert_mark
				if target_feature.is_binary then
					f_name_alias_as.set_is_binary
				elseif target_feature.is_unary then
					f_name_alias_as.set_is_unary
				end
				f_name := f_name_alias_as
			else
				create l_id.initialize (target_feature.feature_name)
				l_id.set_index (f_name.internal_name.index)
				create {FEAT_NAME_ID_AS} f_name.initialize (l_id)
			end
			f_name.set_frozen_keyword (l_frozen_keyword)
			create eiffel_list.make (1);
			eiffel_list.extend (f_name);
			new_feature_as.set_feature_names (eiffel_list);
			Result := new_feature_as
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	deferred_content: ROUT_BODY_AS
			-- Deferred content
		local
			l_routine_as: ROUTINE_AS
		once
			entity_feature_parser.parse_from_string_32 ({STRING_32} "feature feature_name is deferred end", Void)
			l_routine_as ?= entity_feature_parser.feature_node.body.content
			Result := l_routine_as.routine_body
		ensure
			result_not_void: Result /= Void
		end

	deferred_content_with_index (a_index: INTEGER): ROUT_BODY_AS
			-- Deferred content with index of the first token set.
		do
			check is_deferred_as: attached {DEFERRED_AS} deferred_content.twin as l_deferred then
				l_deferred.set_index (a_index)
				Result := l_deferred
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
