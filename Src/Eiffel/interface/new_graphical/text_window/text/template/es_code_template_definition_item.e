note
	description: "[
		Represents an actual code template definition.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_TEMPLATE_DEFINITION_ITEM

inherit

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_feature: FEATURE_AS; a_ast_match_list: LEAF_AS_LIST)
		do
			internal_feature := a_feature
			ast_match_list := a_ast_match_list
			initialize
		ensure
			internal_feature_set: internal_feature = a_feature
			ast_match_list_set: ast_match_list = a_ast_match_list
		end

	initialize
		do
			set_name (internal_feature.feature_name.name_32)
		end

feature -- Access

	name: detachable STRING_32
		-- template name

	title: detachable STRING_32
			-- Code template title.

	description: detachable STRING_32
			-- Code template description.

	tags: detachable LIST [STRING_32]
			-- A potential list of tags to classify a code template.
			--! example: Algorithm, ARRAY, Maximun.

	version: detachable STRING
			-- Version of the Eiffel compiler.

	dependencies: detachable LIST [STRING_32]
			-- A potential list of required libraries for the current template.

	is_query: BOOLEAN
			-- Is the current feature a query?

	is_command: BOOLEAN
			-- Is the current feature a command?

	code: detachable STRING_32
			-- Code template associated.

	declarations: detachable STRING_TABLE [STRING_32]
			-- Arguments and Locals declarations for the current feature, if any.
		do
			if attached arguments as l_arguments then
				Result := l_arguments.twin
			end
			if  attached locals as l_locals then
				if attached Result then
					Result.merge (l_locals)
				else
					Result := l_locals.twin
				end
			end
			if is_query and then attached return_type as l_return_type then
				Result.force (l_return_type, "Result")
			end
		end

	arguments: detachable STRING_TABLE [STRING_32]
			-- Argument fo the current feature, if any.
		do
			Result := internal_arguments
		end

	locals: detachable STRING_TABLE [STRING_32]
			-- Argument fo the current feature, if any.
		do
			Result := internal_locals
		end

	return_type: detachable STRING_32
			-- Return type of the current template, iff it's a query.


	string_from_type (a_type: TYPE_AS): detachable STRING_32
		local
			l_token_region: ERT_TOKEN_REGION
		do
			if attached {LIST_DEC_AS} a_type as l_type then
				if
					attached l_type.type.first_token (ast_match_list) as l_first and then
					attached l_type.type.last_token (ast_match_list) as l_last
				then
					create l_token_region.make (l_first.index, l_last.index)
					Result := ast_match_list.text_32 (l_token_region)
				end
			elseif attached {TYPE_DEC_AS} a_type as l_type then
				if
					attached l_type.type.first_token (ast_match_list) as l_first and then
					attached l_type.type.last_token (ast_match_list) as l_last
				then
					create l_token_region.make (l_first.index, l_last.index)
					Result := ast_match_list.text_32 (l_token_region)
				end
			end
		end
feature -- Change Element.

	set_title (a_title: like title)
			-- Sets a code template title.
			--
			-- `a_title': The title for the code template.
		require
			a_title_attached: attached a_title
		do
			create title.make_from_string (a_title)
		ensure
			title_set: title ~ a_title
		end

	set_description (a_description: like description)
			-- Sets a code template description.
			--
			-- `a_description': A new code template description.
		require
			a_description_attached: attached a_description
		do
			create description.make_from_string (a_description)
		ensure
			description_set: description ~ a_description
		end

	set_tags (a_tags: LIST [STRING_32])
			-- Set `tags' with `a_tags'
		do
			tags := a_tags
		ensure
			tags_set: tags = a_tags
		end

	set_name (a_name: STRING_32)
			-- Set `name' with `a_name'
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	mark_query
			-- Set `is_query' to `True'
			-- and `is_command' to `False'
		do
			is_query := True
			is_command := False
		ensure
			query_true: is_query
			command_false: not is_command
		end

	mark_command
			-- Set `is_query' to `False'
			-- and `is_command' to `True'
		do
			is_query := False
			is_command := True
		ensure
			query_false: not is_query
			command_true: is_command
		end

	set_locals (a_locals: like internal_locals)
			-- Set `internal_locals with `a_locals'.
		do
			internal_locals := a_locals.twin
		end

	set_arguments (a_arguments: like internal_arguments)
			-- Set `internal_arguments' with `a_arguments'.
		do
			internal_arguments := a_arguments.twin
		end

	set_return_type (a_type: like return_type)
			-- Set `return_type' with `a_type'
		do
			return_type := a_type
		ensure
			return_type_set: return_type = a_type
		end

	set_code (a_code: STRING_32)
			-- Set `code' with `a_code'
		do
			code := a_code
		ensure
			code_set: code = a_code
		end

feature {NONE} -- Internal Representation.

	internal_feature: FEATURE_AS
			-- internal feature.

	internal_arguments: detachable STRING_TABLE [STRING_32]
			-- List (of list) of arguments

	internal_locals: detachable STRING_TABLE [STRING_32]
			-- Local declarations

	ast_match_list: LEAF_AS_LIST
			-- match list generated of the current templates.		

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
