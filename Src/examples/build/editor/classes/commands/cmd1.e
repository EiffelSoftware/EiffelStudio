-- View
class COMMAND1

inherit
	OPEN
		rename
			execute as open_execute,
			make as open_make,
			argument1 as open_argument1
		end;
	OPEN
		rename
			make as open_make,
			argument1 as open_argument1
		redefine
			execute
		select
			execute
		end;

	SHARED

creation 
	make

feature 

	view_label: STRING is "view";
	
	execute is
		do
			if not asked_for_name then
				saved_text.wipe_out;
				saved_text.append (open_argument1.text);
				asked_for_name := true;
				file_box.popup (Current)
			else
				open_execute;
				if equal (open_label, transition_label) then
					open_argument1.set_read_only;
					set_transition_label (view_label)
				end
			end
		end;
	
	make (arg1: SCROLLED_T) is
		do
			open_make (arg1)
		end;
	
end -- class COMMAND1
