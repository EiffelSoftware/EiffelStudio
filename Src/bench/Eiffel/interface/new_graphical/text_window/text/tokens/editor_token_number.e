indexing
	description	: "Token that describe an number (integer, real, ...) "
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_NUMBER

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, background_color,
			corresponding_text_item
		end

create
	make

feature -- Access

	corresponding_text_item: TEXT_ITEM is
			-- Item of a structured text that corresponds
			-- to `Current'
		do
			Result := create {NUMBER_TEXT}.make (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.number_text_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.number_background_color
		end

end -- class EDITOR_TOKEN_NUMBER
