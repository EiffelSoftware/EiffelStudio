indexing
	description	: "Token that describe the address of an Eiffel object"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_OBJECT

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, background_color
		end

	EB_GRAPHICAL_DATA

create
	make

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := object_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.string_background_color
		end

end -- class EDITOR_TOKEN_OBJECT
