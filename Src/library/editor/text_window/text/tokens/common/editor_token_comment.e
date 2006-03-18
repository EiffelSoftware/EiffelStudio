indexing
	description	: "Token that describe an Eiffel comment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_COMMENT

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color_id,
			background_color_id,
			process
		end

create
	make

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR) is
			-- Visitor
		do
			a_visitor.process_editor_token_comment (Current)
		end

feature -- Color

	text_color_id: INTEGER is
		do
			Result := editor_preferences.comments_text_color_id
		end

	background_color_id: INTEGER is
		do
			if is_highlighted then
				Result := editor_preferences.highlight_color_id
			else
				Result := editor_preferences.comments_background_color_id
			end
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

end -- class EDITOR_COMMENT
