--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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
