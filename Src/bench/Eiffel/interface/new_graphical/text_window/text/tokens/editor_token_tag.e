indexing
	description	: "Tokens that describe a tag (indexing or assertion)."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TAG

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
			Result := create {ASSERTION_TAG_TEXT}.make (image)
		end

feature -- Status report

	is_indexing: BOOLEAN
			-- Is `Current' an indexing tag?

feature -- Status setting

	set_indexing (f: BOOLEAN) is
			-- Assign `f' to `is_indexing'.
		do
			is_indexing := f
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			if is_indexing then
				Result := editor_preferences.indexing_tag_text_color
			else
				Result := editor_preferences.assertion_tag_text_color
			end
		end

	background_color: EV_COLOR is
		do
			if is_indexing then
				Result := editor_preferences.indexing_tag_background_color
			else
				Result := editor_preferences.assertion_tag_background_color
			end
		end

end -- class EDITOR_TOKEN_TAG

