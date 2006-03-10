indexing
	description: "Visitor of EDITOR_TOKEN"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TOKEN_VISITOR

feature -- Visit

	process_editor_token_line_number (a_tok: EDITOR_TOKEN_LINE_NUMBER) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_space (a_tok: EDITOR_TOKEN_SPACE) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_tabulation (a_tok: EDITOR_TOKEN_TABULATION) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_text (a_tok: EDITOR_TOKEN_TEXT) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_comment (a_tok: EDITOR_TOKEN_COMMENT) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_operator (a_tok: EDITOR_TOKEN_OPERATOR) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_keyword (a_tok: EDITOR_TOKEN_KEYWORD) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_character (a_tok: EDITOR_TOKEN_CHARACTER) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_number (a_tok: EDITOR_TOKEN_NUMBER) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_string (a_tok: EDITOR_TOKEN_STRING) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_eol (a_tok: EDITOR_TOKEN_EOL) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_group (a_tok: EDITOR_TOKEN_GROUP) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_symbol (a_tok: EDITOR_TOKEN_SYMBOL) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

indexing
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

