indexing
	description	: "Tokens for local symbols."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_LOCAL

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
			Result := create {LOCAL_TEXT}.make (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.local_text_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.local_background_color
		end

end -- class EDITOR_TOKEN_LOCAL
