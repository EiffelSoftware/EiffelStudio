--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Menu which is part of a menu system.  
-- It has to be attached to a menu button which will make appear 
-- it when armed.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class PULLDOWN 

inherit

	MENU
		redefine
			implementation
		end
	
feature 

	button: BUTTON is
			-- button 
		deferred
		end;
	
feature -- Text

	text: STRING is
			-- Label of menu button
		do
			Result := implementation.text
		end;

	set_text (a_text: STRING) is
			-- Set button label to `a_text'.
		do
			implementation.set_text(a_text)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: PULLDOWN_I;
			-- Implementation of pulldown menu
	
end 
