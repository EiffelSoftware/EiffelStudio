note
	description: "Token that describe an Eiffel string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_STRING

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color_id,
			background_color_id,
			process,
			may_contain_tabulation
		end

create
	make

feature -- Visitor

	process (a_token_visitor: TOKEN_VISITOR)
			--  Process
		do
			a_token_visitor.process_editor_token_string (Current)
		end

feature -- Status Report

	may_contain_tabulation: BOOLEAN = True
		-- <Precursor>

feature -- Color

	text_color_id: INTEGER
		do
			if is_highlighted then
				Result := highlight_text_color_id
			else
				Result := string_text_color_id
			end
		end

	background_color_id: INTEGER
		do
			if is_highlighted then
				Result := highlight_background_color_id
			else
				Result := string_background_color_id
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EDITOR_TOKEN_STRING
