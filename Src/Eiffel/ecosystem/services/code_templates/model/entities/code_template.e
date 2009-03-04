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
			-- Initializes the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		do
			create internal_tokens.make_default
		end

feature -- Access

	text: attached STRING_32
			-- Raw text of the code template.
		local
			l_tokens: DS_BILINEAR_CURSOR [attached CODE_TOKEN]
			l_token: CODE_TOKEN
			l_is_id: BOOLEAN
		do
			if internal_tokens.is_empty then
				create Result.make_empty
			else
				create Result.make (100)
				
				l_tokens := tokens.new_cursor
				from l_tokens.start until l_tokens.after loop
					l_token := l_tokens.item
					l_is_id := attached {CODE_TOKEN_ID} l_token as l_id
					if l_is_id then
						Result.append ("${")
					end

					Result.append (l_token.text)

					if l_is_id then
						Result.append_character ('}')
					end
					l_tokens.forth
				end
			end
		end

	tokens: attached DS_BILINEAR [attached CODE_TOKEN] assign set_tokens
			-- List of code tokens that make up the template
		do
			Result := internal_tokens
		end

feature {NONE} -- Access

	tokenizer: attached CODE_TOKENIZER
			-- Code tokenized, used to create code tokens from a code string.
		once
			create Result
		end

feature -- Element change

	set_tokens (a_tokens: like tokens)
			-- Sets the code template's list of token.
			--
			-- `a_tokens': List of tokens to set for the code template
		do
			internal_tokens.wipe_out
			internal_tokens.append_last (a_tokens)
		end

	set_tokens_with_text (a_text: attached STRING_32)
			-- Sets the code template using a code token string.
			--
			-- `a_text': Code template text.
		do
			set_tokens (tokenizer.tokenize (a_text, code_factory))
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

	process (a_visitor: attached CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_template (Current)
		end

feature -- Basic operations

	process_tokens (a_visitor: attached CODE_TOKEN_VISITOR_I)
			-- Processes all tokens.
			--
			-- `a_visitor': Visitor to process all tokens with
		local
			l_tokens: DS_ARRAYED_LIST_CURSOR [attached CODE_TOKEN]
		do
			l_tokens := internal_tokens.new_cursor
			from l_tokens.start until l_tokens.after loop
				l_tokens.item.process (a_visitor)
				l_tokens.forth
			end
		end

feature {NONE} -- Internal implementation cache

	internal_tokens: attached DS_ARRAYED_LIST [attached CODE_TOKEN]
			-- Mutable version of `tokens'

;note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
