note
	description: "Visitor of EDITOR_TOKEN"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TOKEN_VISITOR

feature -- Visit

	process_editor_token_line_number (a_tok: EDITOR_TOKEN_LINE_NUMBER)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_space (a_tok: EDITOR_TOKEN_SPACE)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_tabulation (a_tok: EDITOR_TOKEN_TABULATION)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_text (a_tok: EDITOR_TOKEN_TEXT)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_comment (a_tok: EDITOR_TOKEN_COMMENT)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_operator (a_tok: EDITOR_TOKEN_OPERATOR)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_keyword (a_tok: EDITOR_TOKEN_KEYWORD)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_character (a_tok: EDITOR_TOKEN_CHARACTER)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_number (a_tok: EDITOR_TOKEN_NUMBER)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_string (a_tok: EDITOR_TOKEN_STRING)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_eol (a_tok: EDITOR_TOKEN_EOL)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_group (a_tok: EDITOR_TOKEN_GROUP)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_symbol (a_tok: EDITOR_TOKEN_SYMBOL)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_glyph (a_tok: EDITOR_TOKEN_GLYPH)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TOKEN_VISITOR

