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

end
