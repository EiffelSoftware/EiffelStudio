note
	description: "[
		The default factory for creating code template model nodes.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_FACTORY

feature -- Factory

	new_code_built_in_literal_declaration (a_id: READABLE_STRING_GENERAL; a_parent: CODE_DECLARATION_COLLECTION): CODE_LITERAL_DECLARATION
			-- Creates a built-in code literal declaration.
			--
			-- `a_id': A code declaration identifier.
			-- `a_parent': A parent declaration collection the literal will eventually be contained in.
			-- `Result': A code template literal declaration
		require
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
			a_parent_attached: attached a_parent
		do
			create {CODE_BUILT_IN_LITERAL_DECLARATION} Result.make (a_id, a_parent)
		ensure
			result_attached: attached Result
			result_id_matches_a_id: Result.id.is_case_insensitive_equal (a_id.as_string_8)
			result_is_built_in: Result.is_built_in
		end

	new_code_category_collection (a_parent: CODE_METADATA): CODE_CATEGORY_COLLECTION
			-- Creates a code category collection node.
			--
			-- `a_parent': A parent metadata section the category collection will be a part of.
			-- `Result': A code template collection of metadata categories.
		require
			a_parent_attached: attached a_parent
		do
			create Result.make (a_parent)
		ensure
			result_attached: attached Result
		end

	new_code_declaration_collection (a_parent: CODE_TEMPLATE_DEFINITION): CODE_DECLARATION_COLLECTION
			-- Creates a code declarations collection node.
			--
			-- `a_parent': A parent template definition the declaration collection will be a part of.
			-- `Result': A code template collection of declaration.
		require
			a_parent_attached: attached a_parent
		do
			create Result.make (a_parent)
		ensure
			result_attached: attached Result
		end

	new_code_literal_declaration (a_id: READABLE_STRING_GENERAL; a_parent: CODE_DECLARATION_COLLECTION): CODE_LITERAL_DECLARATION
			-- Creates a code literal declaration.
			--
			-- `a_id': A code declaration identifier.
			-- `a_parent': A parent declaration collection the declaration will be a part of.
			-- `Result': A code literal declaration.
		require
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
			a_parent_Attached: attached a_parent
		do
			create Result.make (a_id, a_parent)
		ensure
			result_attached: attached Result
			result_id_matches_a_id: Result.id.is_case_insensitive_equal (a_id.as_string_8)
			not_result_is_built_in_set: not Result.is_built_in
		end

	new_code_metadata (a_parent: CODE_TEMPLATE_DEFINITION): CODE_METADATA
			-- Creates a code metadata section describing the code template.
			--
			-- `a_parent': A parent template definition the metadata section will be a part of.
			-- `Result': A metadata section.
		require
			a_parent_attached: a_parent /= Void
		do
			create Result.make (a_parent)
		ensure
			result_attached: Result /= Void
		end

	new_code_numeric_version (a_major, a_minor, a_revision, a_qfe: NATURAL_16): CODE_NUMERIC_VERSION
			-- Creates a numerical code version.
			--
			-- `a_major': A major version part.
			-- `a_minor': A minor version part.
			-- `a_revision': A revision version part.
			-- `a_qfe': A QFE version part.
		do
			create Result.make (a_major, a_minor, a_revision, a_qfe)
		ensure
			result_attached: attached Result
		end

	new_code_object_declaration (a_id: READABLE_STRING_GENERAL; a_parent: CODE_DECLARATION_COLLECTION): CODE_OBJECT_DECLARATION
			-- Creates a code object declaration.
			--
			-- `a_id': A code declaration identifier.
			-- `a_parent': A parent declaration collection the literal will eventually be contained in.
			-- `Result': A code template object declaration.
		require
			a_id_attached: attached a_id
			a_parent_attached: attached a_parent
		do
			create Result.make (a_id, a_parent)
		ensure
			result_attached: attached Result
			result_id_matches_a_id: Result.id.is_case_insensitive_equal (a_id.as_string_8)
			not_result_is_built_in_set: not Result.is_built_in
		end

	new_code_template_collection (a_parent: CODE_TEMPLATE_DEFINITION): CODE_TEMPLATE_COLLECTION
			-- Creates a code templates collections node.
			--
			-- `a_parent': A parent template definition the templates collection will be a part of.
			-- `Result': A code template template collection.
		require
			a_parent_attached: attached a_parent
		do
			create Result.make (a_parent)
		ensure
			result_attached: attached Result
		end

	new_code_template_defintion: CODE_TEMPLATE_DEFINITION
			-- Creates a root code template file.
			--
			-- `Result': A top-level template definition.
		do
			create Result.make (Current)
		ensure
			result_attached: attached Result
		end

	new_code_template (a_parent: CODE_TEMPLATE_COLLECTION): CODE_TEMPLATE
			-- Creates a simple, unversioned code template.
			--
			-- `a_parent': A parent template collection the template will be a part of.
			-- `Result': A unversioned code template.
		require
			a_parent_attached: attached a_parent
		do
			create Result.make (a_parent)
		ensure
			result_attached: attached Result
		end

	new_code_version (a_version: READABLE_STRING_GENERAL): CODE_VERSION
			-- Creates an arbitary code version.
			--
			-- `a_version': A version string indicating the version.
			-- `Result': A code version.
		require
			a_version_attached: attached a_version
		do
			create Result.make (a_version)
		ensure
			result_attached: attached Result
		end

	new_code_versioned_template (a_version: CODE_VERSION; a_parent: CODE_TEMPLATE_COLLECTION): CODE_VERSIONED_TEMPLATE
			-- Create a versioned code template, specifying the minimum version of the compiler required
			-- to use the code template.
			--
			-- `a_version': The version to bind the code template to.
			-- `a_parent': A parent collection which the template will be eventually place in.
			-- `Result': A versioned code template.
		require
			a_version_attached: attached a_version
			a_parent_attached: attached a_parent
		do
			create Result.make (a_version, a_parent)
		ensure
			result_attached: attached Result
		end

feature -- Token factory

	new_cursor_token: CODE_TOKEN_CURSOR
			-- Creates a new cursor place-holder code token.
			--
			-- `Result': A new cursor token.
		do
			create Result.make
		ensure
			result_attached: attached Result
		end

	new_eol_token: CODE_TOKEN_EOL
			-- Creates a new end-of-line code token.
			--
			-- `Result': A new end-of-line token.
		do
			create Result.make
		ensure
			result_attached: attached Result
		end

	new_id_token (a_id: STRING_32): CODE_TOKEN_ID
			-- Creates a ID code token to represent a replacable declaration in the code template.
			--
			-- `a_text': A unique id text string.
			-- `Result': A new ID token.
		require
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
		do
			create Result.make (a_id)
		ensure
			result_attached: attached Result
		end

	new_id_ref_token (a_token: CODE_TOKEN_ID): CODE_TOKEN_ID_REF
			-- Creates a ID code token to represent a replacable declaration in the code template.
			--
			-- `a_token': A source code id token, the resulting tokens refers to.
			-- `Result': A new reference ID token.
		require
			a_token_attached: attached a_token
		do
			create Result.make (a_token)
		ensure
			result_attached: attached Result
		end

	new_text_token (a_text: STRING_32): CODE_TOKEN_TEXT
			-- Creates a basic text snippet token, with no operational semantics
			--
			-- `a_text': The non-empty string composing a code token text.
		require
			a_text_attached: attached a_text
			not_a_text_is_empty: not a_text.is_empty
		do
			create Result.make (a_text)
		ensure
			result_attached: attached Result
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
