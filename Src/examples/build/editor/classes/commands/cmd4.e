-- Back
class COMMAND4

inherit
	NON_UNDOABLE_CMD;
	SHARED

creation 
	make

feature 

	back_label: STRING is "back";
	
	argument1: SCROLLED_T;
	
	execute is
		do
			argument1.set_text (saved_text);
			argument1.set_editable;
			set_transition_label (back_label)
		end;
	
	make (arg1: SCROLLED_T) is
		do
			argument1 := arg1
		end;
	
end -- class COMMAND4
