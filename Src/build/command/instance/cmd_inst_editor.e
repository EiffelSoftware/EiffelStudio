
class CMD_INST_EDITOR 
	
inherit

	TOP_SHELL
		rename
			make as top_shell_create
		redefine
			delete_window_action
		end;
	TOP_SHELL
		redefine
			make, delete_window_action
		select
			make
		end;
	WINDOWS;
	CONSTANTS;
	COMMAND

creation

	make

-- ****************
-- Editing features
-- ****************
	
feature 

	command_instance: CMD_INSTANCE;
			-- Currently command_instance

	clear is
			-- Clear current editor.
		do
			save_previous_instance;
			arguments.wipe_out;
			instance_hole.reset;
		end;

	close is
			-- Close Current Editor
		do
			clear;
			window_mgr.close (Current)
		end;

	delete_window_action is
		do
			close;
		end;
	
feature {NONE}

	save_previous_instance is
		do
			if not (command_instance = Void) then
				command_instance.save_arguments;
				command_instance.reset;
				command_instance := Void
			end
		end;
	
feature 
	set_instance_stone is
		do
			instance_hole.set_instance (command_instance);
		end;

	set_instance (c: CMD_INSTANCE) is
			-- Set command_instance to `c' and update
			-- the editor.
		require
			c_not_being_edited: not c.edited;
			not_void_c: not (c = Void)
		do
			save_previous_instance;
			command_instance := c;
			arguments.set (command_instance.arguments);
			command_instance.set_arguments (arguments);	
			command_instance.set_editor (Current);
			instance_hole.set_instance (command_instance);
		end;

	update is
		do
			arguments.set (command_instance.arguments);
			command_instance.set_arguments (arguments)
		end;

-- ********************
-- EiffelVision Section
-- ********************

	
feature {NONE}

	arguments: ARG_INST_BOX;
			-- Arguments of command_instance
	command_hole: CMD_INST_TYPE_H;
			-- Hole used to accept command types
	instance_hole: INST_EDIT_HOLE;
			-- Hole used to accept command instances
	close_b: CMD_INST_CLOSE_B;
			-- Close button associated with
			-- Current window
	form: FORM;
	argument_sw: SCROLLED_W;
	separator: SEPARATOR;

	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
		do
				-- **************
				-- Create Widgets
				-- **************
			top_shell_create (a_name, a_screen);
			!!form.make (Widget_names.form, Current);
			!!instance_hole.make (Current);
			instance_hole.make_visible (form);
			!!command_hole.make (Current);
			command_hole.make_visible (form);	
			!!close_b.make (Current);
			!!argument_sw.make (Widget_names.scroll2, form);
			!!arguments.make (Widget_names.icon_box1, argument_sw);
			!!separator.make (Widget_names.separator, form);
				-- *******************
				-- Perform attachments 
				-- *******************
			form.attach_top (instance_hole, 10);
			form.attach_top (command_hole, 10);
			form.attach_top (close_b, 10);
			form.attach_left (separator, 10);
			form.attach_right (separator, 10);
			form.attach_left (command_hole, 10);
			form.attach_left_widget (command_hole, instance_hole, 10);
			form.attach_top_widget (separator, argument_sw, 5);
			form.attach_right (close_b, 10);
			form.attach_top (separator, 60);
			form.attach_left (argument_sw, 10);
			form.attach_right (argument_sw, 10);
			form.attach_bottom (argument_sw, 10);
				-- **********
				-- Set values
				-- **********
			argument_sw.set_working_area (arguments);
			arguments.set_row_layout;
			separator.set_single_line;
			separator.set_horizontal (True);
			form.set_action("Shift<Btn2Down>", Current, raise_arg)
		end;

	raise_arg: ANY is
		once
			!!Result
		end

	execute (arg: ANY) is
		do
			if arg = raise_arg then
				main_panel.base.raise
			end
		end
end
