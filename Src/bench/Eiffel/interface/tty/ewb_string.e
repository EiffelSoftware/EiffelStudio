indexing

	description: 
		"Description of a menu entry string for%
		%command line option for ec -loop.";
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
			int_help_message := h;
			abbreviation := c;
			sub_menu := s
		end;

feature -- Properties

	name: STRING;

	help_message: STRING is
		do
			Result := int_help_message;
		end;

	abbreviation: CHARACTER;

	sub_menu: EWB_MENU;

feature {NONE} -- Execution

	execute is
		do
		end;

feature {NONE} -- Attributes

	int_help_message: STRING;

end -- class EWB_STRING
