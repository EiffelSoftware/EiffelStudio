indexing
	description	: "Token that describe an Eiffel string"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_CLUSTER

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
			Result := cluster_color
		end

	background_color: EV_COLOR is
		do
			Result := Void
		end

end -- class EDITOR_TOKEN_CLUSTER
