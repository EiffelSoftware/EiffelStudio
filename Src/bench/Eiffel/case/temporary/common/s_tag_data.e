indexing

	description: 
		"Data representing tagged information%
		%that has a tag and associated text.";
	date: "$Date$";
	revision: "$Revision $"

class S_TAG_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE} -- Initialization

	make (tg, txt: STRING) is
			-- Make invariant with tag `tg' with expression `exp'.
		require
			valid_txt: txt /= Void
		do
			tag := tg;
			text := txt;
		ensure
			tag_set: tag = tg;
			text_set: text = txt
		end;

feature -- Properties

	tag: STRING;
			-- Tag of Current 

	text: STRING
			-- Expression

end -- class S_TAG_DATA
