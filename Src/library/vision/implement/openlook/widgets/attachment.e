--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class ATTACHMENT
	
feature 

	is_form_or_posit: BOOLEAN is 
			-- Is Current attachment using forms or positioning?			
		do
			Result := false;
		end;

	perform_attach (widget: WIDGET_I; length: INTEGER; fraction_base: INTEGER; side: INTEGER) is
			-- Do nothing.
		do
		end;

end 
