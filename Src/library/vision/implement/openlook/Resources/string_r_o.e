indexing

	description: "Xm string defines";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class  STRING_R_O
	
feature {NONE}

	OSTRING_DIRECTION_L_TO_R: INTEGER is 0;
			-- OpenLook constant value

	OSTRING_DIRECTION_R_TO_L: INTEGER is 1;
			-- OpenLook constant value

	OSTRING_DIRECTION_DEFAULT: INTEGER is 255;
			-- OpenLook constant value

	OSTRING_COMPONENT_UNKNOWN: INTEGER is 0;
			-- OpenLook constant value

	OSTRING_COMPONENT_CHARSET: INTEGER is 1;
			-- OpenLook constant value

	OSTRING_COMPONENT_TEXT: INTEGER is 2;
			-- OpenLook constant value

	OSTRING_COMPONENT_DIRECTION: INTEGER is 3;
			-- OpenLook constant value

	OSTRING_COMPONENT_SEPARATOR: INTEGER is 4;
			-- OpenLook constant value

	OSTRING_COMPONENT_END: INTEGER is 126;
			-- OpenLook constant value

	OSTRING_COMPONENT_USER_BEGIN: INTEGER is 128;
			-- OpenLook constant value

	OSTRING_COMPONENT_USER_END: INTEGER is 255;
			-- OpenLook constant value

	OSTRING_DEFAULT_CHARSET: STRING is "";
			-- OpenLook constant value

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
