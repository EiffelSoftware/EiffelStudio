
class EWB_STRING 

inherit

	EWB_CMD

creation

	make

feature -- Creation

	name: STRING;

	help_message: STRING;

	abbreviation: CHARACTER;

	sub_menu : EWB_MENU;

	make (n, h: STRING; c: CHARACTER; s: EWB_MENU) is
		do
			name := n;
			help_message := h;
			abbreviation := c;
			sub_menu := s
		end;

feature

	loop_execute is
		do
		end;

	execute is
		do
		end;

end
