indexing

	description: 
		"Description of a menu entry string for%
		%command line option for es3 -loop.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_STRING 

inherit

	EWB_CMD

creation

	make

feature -- Initialization

	make (n, h: STRING; c: CHARACTER; s: EWB_MENU) is
		do
			name := n;
			help_message := h;
			abbreviation := c;
			sub_menu := s
		end;

feature -- Properties

	name: STRING;

	help_message: STRING;

	abbreviation: CHARACTER;

	sub_menu: EWB_MENU;

feature {NONE} -- Execution

	execute is
		do
		end;

end -- class EWB_STRING
