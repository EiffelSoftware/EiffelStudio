--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class ATTACH_WIDGET

inherit
	
	ATTACHMENT

creation

	make
	
feature 

	extremity: WIDGET_I;

	offset: INTEGER;

	make (a_widget: WIDGET_I; an_offset: INTEGER) is
			-- Make an attach_widget  with `a_widget' as extremity
			-- and `an_offset' as offset.
		do
			extremity := a_widget;
			offset := an_offset;
		end;

end 
