indexing

	description: "Top defines";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class  TOP_R_O
		
feature {NONE}

	Oiconic: STRING is "iconic";
						-- Name of openlook resource

	OiconName: STRING is "iconName";
						-- Name of openlook resource

	OiconNameEncoding: STRING is "iconNameEncoding";
			-- Name of openlook resource
			-- from new release 4

	OinitialState: STRING is "initialState";
								-- Name of openlook resource

	OICONIC_STATE: INTEGER is 3;

	ONORMAL_STATE: INTEGER is 1;

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
