indexing

	description: "Text defines";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class  TEXT_R_O
	
feature {NONE}

	Osource: STRING is "source";
						-- Name of openlook resource

	OtopMargin: STRING is "topMargin";
						-- Name of openlook resource

	ObottomMargin: STRING is "bottomMargin";
						-- Name of openlook resource

	OleftMargin: STRING is "leftMargin";
						-- Name of openlook resource

	OrightMargin: STRING is "rightMargin";
						-- Name of openlook resource

	OgrowMode: STRING is "GrowMode";
						-- Name of openlook resource

	OselectStart: STRING is "selectStart";
						-- Name of openlook resource

	OselectEnd: STRING is "selectEnd";
						-- Name of openlook resource

	OwordWrap: STRING is "wrap";
						-- Name of openlook resource

	OwrapMode: STRING is "wrapMode";
						-- Name of openlook resource

	OcharsVisible: STRING is "charsVisible";
						-- Name of openlook resource

	OMULTI_LINE_EDIT: INTEGER is 0;
						-- OpenLook constant value

	OSINGLE_LINE_EDIT: INTEGER is 1;
						-- OpenLook constant value

	OTEXT_READ: INTEGER is 67;
						-- OpenLook constant value

	OWRAP_WHITE_SPACE: INTEGER is 76;
						-- OpenLook constant value

	OGROW_OFF: INTEGER is 147;
						-- OpenLook constant value

	OGROW_BOTH: INTEGER is 150;
						-- OpenLook constant value

	OGROW_VERTICAL: INTEGER is 149;
						-- OpenLook constant value

	OGROW_HORIZONTAL: INTEGER is 148;
						-- OpenLook constant value

	ModifyingTextValue: INTEGER is 20;

	MovingInsertCursor: INTEGER is 21;


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
