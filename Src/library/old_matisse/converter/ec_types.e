indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_TYPES 

feature

	Identifier_ttype:	INTEGER is  1;
	String_ttype: 		INTEGER is  2;
	Real_ttype: 		INTEGER is  3;
	Integer_ttype: 		INTEGER is  4;
	Space_ttype: 		INTEGER is  5;
	Field_sep_ttype: 	INTEGER is  6;	
	Separator_ttype: 	INTEGER is  7;
	Left_del_ttype: 	INTEGER is  8;
	Right_del_ttype: 	INTEGER is  9;
	Boolean_ttype: 		INTEGER is 10;
	Basic_ttype : 		INTEGER is 11;
	Label_sep_ttype:	INTEGER is 12

end -- class EC_TYPES


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
