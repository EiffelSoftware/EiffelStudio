class S_TEXT_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature

	text: STRING;

feature {NONE} -- Setting values

	make (txt: STRING) is
			-- Set text to `txt'.
		require
			valid_txt: txt /= Void
		do
			text := txt
		ensure
			text_set: text = txt
		end;

end
