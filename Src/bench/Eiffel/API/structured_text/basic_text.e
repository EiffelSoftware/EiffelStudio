class BASIC_TEXT

inherit
	TEXT_ITEM
		redefine
			image
		end

creation
	make

feature

	make (text: like image) is
		do
			image := text;
		end;

	image: STRING;

	is_special: BOOLEAN;

	is_comment: BOOLEAN;

	is_keyword: BOOLEAN;

	set_is_keyword is
		do
			is_keyword := true;
		end;

	set_is_comment is
		do
			is_comment := true;
		end;

	set_is_special is
		do
			is_special := true;
		end;

end

