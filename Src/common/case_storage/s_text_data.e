class S_TEXT_DATA

inherit

	S_ELEMENT_DATA
		redefine
			is_equal
		end

creation

	make

feature

	text: STRING;

	is_equal (other: like Current): BOOLEAN is
		do
			Result := text.is_equal (other.text)
		end;

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
