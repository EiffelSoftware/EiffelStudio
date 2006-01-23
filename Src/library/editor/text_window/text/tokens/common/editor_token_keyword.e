indexing
	description	: "Token that describe a keyword (create, loop, ...)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_KEYWORD

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, 
			background_color,
			font,
			process
		end

create
	make

feature -- Visitor
	
	process (a_visitor: TOKEN_VISITOR) is
			--
		do
			a_visitor.process_keyword_token (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.keyword_text_color
		end

	background_color: EV_COLOR is
		do
			if is_highlighted then				
				Result := editor_preferences.highlight_color
			else
				Result := editor_preferences.keyword_background_color
			end
		end
		
	font: EV_FONT is
			-- Font used in the editor
		do
			Result := keyword_font_cell.item.value
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




end -- class EDITOR_KEYWORD
