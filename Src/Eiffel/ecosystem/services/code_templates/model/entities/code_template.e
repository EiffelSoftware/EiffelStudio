note
	description: "[
		Represents an actual code template tokenized code template.
	]"
	doc: "wiki://Code Templates:Code Templates"
	doc: "wiki://Code Templates:Un-versioned Code Templates"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TEMPLATE

inherit
	CODE_SUB_NODE [CODE_TEMPLATE_COLLECTION]

create
	make

feature {NONE} -- Initialization

	initialize_nodes (a_factory: like code_factory)
			-- <Precursor>
		do
			create internal_tokens.make_default
		end

feature -- Access

	text: STRING_32
			-- Raw text of the code template.
		local
			l_cursor: DS_BILINEAR_CURSOR [CODE_TOKEN]
			l_is_id: BOOLEAN
		do
			if internal_tokens.is_empty then
				create Result.make_empty
			else
				create Result.make (100)

				l_cursor := tokens.new_cursor
				from l_cursor.start until l_cursor.after loop
					if attached l_cursor.item as l_token then
						l_is_id := attached {CODE_TOKEN_ID} l_token
						if l_is_id then
							Result.append ("${")
						end

						Result.append (l_token.text)

						if l_is_id then
							Result.append_character ('}')
						end
					end
					l_cursor.forth
				end
				check gobo_memory_leak: l_cursor.off end
			end
		ensure
			result_attached: Result /= Void
		end

	tokens: DS_BILINEAR [CODE_TOKEN] assign set_tokens
			-- List of code tokens that make up the template.
		do
			Result := internal_tokens
		ensure
			result_attached: Result /= Void
			result_contians_attached_items:
				(attached {DS_LINEAR [detachable ANY]} Result as l_result) and then
				not l_result.has (Void)
		end

feature {NONE} -- Access

	tokenizer: CODE_TOKENIZER
			-- Code tokenized, used to create code tokens from a code string.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Element change

	set_tokens (a_tokens: like tokens)
			-- Sets the code template's list of token.
			--
			-- `a_tokens': List of tokens to set for the code template
		require
			a_tokens_attached: a_tokens /= Void
			a_tokens_contains_attached_items:
				(attached {DS_LINEAR [detachable ANY]} a_tokens as l_list) and then
				not l_list.has (Void)
		local
			l_tokens: like internal_tokens
		do
			l_tokens := internal_tokens
			l_tokens.wipe_out
			l_tokens.append_last (a_tokens)
		end

	set_tokens_with_text (a_text: STRING_32)
			-- Sets the code template using a code token string.
			--
			-- `a_text': Code template text.
		require
			a_text_attached: a_text /= Void
		do
			if not a_text.is_empty then
				set_tokens (tokenizer.tokenize (a_text, code_factory))
			else
				set_tokens (create {DS_ARRAYED_LIST [CODE_TOKEN]}.make (0))
			end
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is the template an empty template?
		do
			Result := internal_tokens.is_empty
		ensure
			not_tokens_is_empty: Result implies not internal_tokens.is_empty
		end

feature -- Visitor

	process (a_visitor: CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_template (Current)
		end

feature -- Basic operations

	process_tokens (a_visitor: CODE_TOKEN_VISITOR_I)
			-- Processes all tokens.
			--
			-- `a_visitor': Visitor to process all tokens with
		require
			a_visitor_attached: a_visitor /= Void
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [CODE_TOKEN]
		do
			l_cursor := internal_tokens.new_cursor
			from l_cursor.start until l_cursor.after loop
				if attached l_cursor.item as l_item then
					l_item.process (a_visitor)
				end
				l_cursor.forth
			end
			check gobo_memory_leak: l_cursor.off end
		end

feature {NONE} -- Internal implementation cache

	internal_tokens: DS_ARRAYED_LIST [CODE_TOKEN]
			-- Mutable version of `tokens'

invariant
	internal_tokens_attached: internal_tokens /= Void
	internal_tokens_contains_attached_items:
		(attached {DS_LINEAR [detachable ANY]} internal_tokens as l_tokens) and then
		not l_tokens.has (Void)

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
