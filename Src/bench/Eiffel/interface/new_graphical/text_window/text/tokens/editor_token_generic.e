indexing
	description	: "Tokens for formal generics."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_GENERIC

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
			Result := create {GENERIC_TEXT}.make (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			--| FIXME Should be a preference
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

	background_color: EV_COLOR is
		do
			--| FIXME Should be a preference
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

end -- class EDITOR_TOKEN_GENERIC

