
indexing
	copyright: "See notice at end of class";

class SCROLL_ITEM

inherit

	COMPARABLE
		export
			{NONE} all
		redefine
			infix ">=",
			infix ">",
			infix "<=",
			infix "<"
		end

creation

	make
	
feature 

	name_item: STRING;

	token_item: INTEGER;

	make (a_token: INTEGER; a_name: STRING) is
		do
			token_item := a_token;
			name_item := a_name;
		end;

	infix ">=" (other: like Current): BOOLEAN is
		do
			Result := token_item >= other.token_item
		end;

	infix "<=" (other: like Current): BOOLEAN is
		do
			Result := token_item <= other.token_item
		end;

	infix ">" (other: like Current): BOOLEAN is
		do
			Result := token_item > other.token_item
		end;

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := token_item < other.token_item
		end;
	
end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
