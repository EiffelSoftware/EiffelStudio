indexing
	description	: "Objects that represent a space token. %
				  %It represents one of more spaces."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_SPACE

inherit
	EDITOR_TOKEN

create
	make

feature -- Initialisation

	make(number: INTEGER) is
		local
			i: INTEGER
		do
			length := number
			create image.make(number)
			from i := 1 until i > number loop
				image.append_character(' ')
				i := i + 1
			end
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		do
			--[ Don't display anything. If an option is set to see the spaces, 
			--  put it here ]
			Result := d_x + dc.string_width(image)

				-- update width
			width := Result - d_x
		end

feature {NONE} -- Implementation

end -- class EDITOR_TOKEN_SPACE
