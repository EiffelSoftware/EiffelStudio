
class EB_BULLETIN_D 

inherit

	BULLETIN_D
		rename
			make as bulletin_d_create,
			set_width as old_set_width,
			set_height as old_set_height,
			set_size as old_set_size
		end;

	BULLETIN_D
		rename
			make as bulletin_d_create
		redefine
			set_size, set_height, set_width
		select
			set_size, set_height, set_width
		end;

	COMMAND;

	SCALABLE;

creation

	make

feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			bulletin_d_create (a_name, a_parent);
			forbid_recompute_size;
			!!widget_coordinates.make;
				-- Callback
			dialog_command_target;
			set_action ("<Configure>", Current, Current);
			widget_command_target;
		end;

feature 

	set_width (new_width: INTEGER) is
		do	
			old_set_width (new_width);
			if old_width = 0 then
				old_width := width
			end;
		end;

	set_height (new_height: INTEGER) is
		do	
			old_set_height (new_height);
			if old_height = 0 then
				old_height := height
			end;
		end;

	set_size (new_width, new_height: INTEGER) is
		do	
			old_set_size (new_width, new_height);
			if old_width = 0 then
				old_width := width
			end;
			if old_height = 0 then
				old_height := height
			end;
		end;

end

