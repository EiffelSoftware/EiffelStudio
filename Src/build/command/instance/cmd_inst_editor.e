
class CMD_INST_EDITOR 
	
inherit

	TOP_SHELL
		rename
			make as top_shell_create,
			destroy as shell_destroy
		end
	TOP_SHELL
		redefine
			make, destroy
		select
			make, destroy
		end
	WINDOWS;
	CONSTANTS;
	CLOSEABLE

creation

	make

feature 

	command_instance: CMD_INSTANCE;
			-- Currently command_instance

	clear is
			-- Clear current editor.
		do
			set_title (Widget_names.cmd_instance_editor)
			set_icon_name (Widget_names.cmd_instance_editor);
			save_previous_instance;
			arguments.wipe_out;
		end;

	close is
			-- Close Current Editor
		do
			clear;
			window_mgr.close (Current)
		end;

feature {NONE}

	save_previous_instance is
		do
			if not (command_instance = Void) then
				command_instance.save_arguments;
				command_instance := Void
			end
		end;

feature

	set_instance (c: CMD_INSTANCE) is
			-- Set command_instance to `c' and update
			-- the editor.
		require
			c_not_being_edited: not c.edited;
			not_void_c: c /= Void
		do
			save_previous_instance;
			command_instance := c;
			arguments.set (command_instance.arguments);
			command_instance.set_arguments (arguments);	
			command_instance.set_editor (Current);
			update_title
		end

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0);
			tmp.append (Widget_names.instance_label);
			tmp.append (": ");
			tmp.append (command_instance.label);
			set_title (tmp);
			set_icon_name (tmp);
		end;

	update is
		do
			arguments.set (command_instance.arguments);
			command_instance.set_arguments (arguments)
		end;

feature {NONE}

	arguments: ARG_INST_BOX;
			-- Arguments of command_instance
	command_hole: CMD_INST_TYPE_H;
			-- Hole used to accept command types
	instance_hole: INST_EDIT_HOLE;
			-- Hole used to accept command instances

feature 

	focus_label: FOCUS_LABEL

	destroy is
		do
			instance_hole.unregister;
			command_hole.unregister;
			arguments.unregister_holes;
			shell_destroy
		end;

	make (a_name: STRING; a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW
			close_b: CLOSE_WINDOW_BUTTON;
			form: FORM;
			argument_sw: SCROLLED_W;
		do
				-- **************
				-- Create Widgets
				-- **************
			top_shell_create (a_name, a_screen);
			set_title (a_name);
			set_icon_name (a_name);
			if Pixmaps.command_instance_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.command_instance_pixmap);
			end;
			!! form.make (Widget_names.form, Current);
			!! focus_label.make (form);
			!! instance_hole.make (Current, form);
			!! command_hole.make (Current, form);
			!! close_b.make (Current, form, focus_label);
			!! argument_sw.make (Widget_names.scroll2, form);
			!! arguments.make (Widget_names.icon_box1, argument_sw);
				-- *******************
				-- Perform attachments 
				-- *******************
			form.attach_top (instance_hole, 0);
			form.attach_top (command_hole, 0);
			form.attach_top (close_b, 0);
			form.attach_top (focus_label, 5);
			form.attach_top_widget (focus_label, argument_sw, 0);
			form.attach_top_widget (close_b, argument_sw, 2);
			form.attach_top_widget (instance_hole, argument_sw, 2);
			form.attach_top_widget (command_hole, argument_sw, 2);
			form.attach_left (instance_hole, 0);
			form.attach_left_widget (instance_hole, command_hole, 0);
			form.attach_left_widget (command_hole, focus_label, 0);
			form.attach_right_widget (close_b, focus_label, 0);
			form.attach_right (close_b, 0);
			form.attach_left (argument_sw, 0);
			form.attach_right (argument_sw, 0);
			form.attach_bottom (argument_sw, 0);
				-- **********
				-- Set values
				-- **********
			argument_sw.set_working_area (arguments);
			arguments.set_row_layout;
			!! del_com.make (Current);
			set_delete_command (del_com);	
		end;

end
