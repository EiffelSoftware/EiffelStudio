-- Quit
class COMMAND2

inherit
	NON_UNDOABLE_CMD

creation 
	make

feature 

	quit_label: STRING is "quit";
	
	execute is
		do
			set_transition_label (quit_label)
		end;
	
	make is
		do
		end;
	
end -- class COMMAND2
