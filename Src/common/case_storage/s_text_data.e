indexing

	description: 
		"Data representing text information.";
	date: "$Date$";
	revision: "$Revision $"

class S_TEXT_DATA

inherit

	S_ELEMENT_DATA
		redefine
			is_equal
		end

creation

	make

feature {NONE} -- Initialization

	make (txt: STRING) is
			-- Set text to `txt'.
		require
			valid_txt: txt /= Void
		do
			text := txt
		ensure
			text_set: text = txt
		end;

feature -- Properties

	text: STRING;
			-- Text representing Current

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := text.is_equal (other.text)
		end;

end -- class S_TEXT_DATA
