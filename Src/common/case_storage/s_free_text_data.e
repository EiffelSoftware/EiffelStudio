indexing

	description: 
		"Free form text notion where no checks are made for%
		%its content";
	date: "$Date$";
	revision: "$Revision $"

class S_FREE_TEXT_DATA

inherit

	S_ELEMENT_DATA
		undefine
			consistent, copy, 
			setup, is_equal
		end;
	FIXED_LIST [STRING]

creation

	make

end -- class S_FREE_TEXT_DATA
