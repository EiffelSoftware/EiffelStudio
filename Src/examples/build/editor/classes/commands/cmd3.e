-- Modify
class COMMAND3

inherit
	NON_UNDOABLE_CMD

creation 
	make

feature 

	modify_label: STRING is "modify";
	
	execute is
		do
			set_transition_label (modify_label)
		end;
	
	make is
		do
		end;
	
end -- class COMMAND3
