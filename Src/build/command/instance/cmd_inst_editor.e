
class CMD_INST_EDITOR 
	
inherit

	EB_TOP_SHELL
		rename
			make as top_shell_create,
			destroy as shell_destroy
		redefine
			set_geometry
		end
	EB_TOP_SHELL
		redefine
			make, destroy, set_geometry
		select
			make, destroy
		end
	WINDOWS
		select
			init_toolkit
		end
	
	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cmd_inst_ed_width,
						Resources.cmd_inst_ed_height)
		end

feature

	command_instance: CMD_INSTANCE
			-- Currently command_instance

	clear is
			-- Clear current editor.
		do
			instance_hole.set_empty_symbol
			set_title (Widget_names.cmd_instance_editor)
			set_icon_name (Widget_names.cmd_instance_editor)
			save_previous_instance
			arguments.wipe_out
		end

	close is
			-- Close Current Editor
		do
			clear
			window_mgr.close (Current)
		end

feature {NONE}

	save_previous_instance is
		do
			if command_instance /= Void then
				command_instance.save_arguments
				command_instance.reset
				command_instance := Void
			end
		end

feature

	set_instance (c: CMD_INSTANCE) is
			-- Set command_instance to `c' and update
			-- the editor.
		require
			c_not_being_edited: not c.edited
			not_void_c: c /= Void
		do
			instance_hole.set_full_symbol
			save_previous_instance
			command_instance := c
			arguments.set (command_instance.arguments)
			observers.set (command_instance.observers)
--			command_instance.set_arguments (arguments)	
--			command_instance.set_editor (Current)
			update_title
		end

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0)
			tmp.append (Widget_names.instance_label)
			tmp.append (": ")
			tmp.append (command_instance.label)
			set_title (tmp)
			set_icon_name (tmp)
		end

	add_observer (inst: CMD_INSTANCE) is
			-- Add an observer.
		do
			observers.extend (inst)
		end

	remove_observer (inst: CMD_INSTANCE) is
			-- Remove an observer.
		do
			observers.start
			observers.prune (inst)
		end

feature {NONE}

	arguments: ARG_INST_BOX
			-- Arguments of command_instance
	observers: OBSERVER_BOX
			-- Observers of command_instance
	command_hole: CMD_INST_TYPE_H
			-- Hole used to accept command types
	instance_hole: INST_EDIT_HOLE
			-- Hole used to accept command instances
	observer_hole: OBSERVER_HOLE
			-- Hole used to add observers

	trash_hole: CUT_HOLE

feature 

--samik	focus_label: FOCUS_LABEL

	destroy is
		do
			trash_hole.unregister
			instance_hole.unregister
			command_hole.unregister
			arguments.unregister_holes
			shell_destroy
		end

	make (a_name: STRING; a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW
			close_b: CLOSE_WINDOW_BUTTON
			top_form, form: FORM
			argument_sw, observers_sw: SCROLLED_W
		do
				-- **************
				-- Create Widgets
				-- **************
			top_shell_create (a_name, a_screen)
			set_title (a_name)
			set_icon_name (a_name)
			if Pixmaps.command_instance_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.command_instance_pixmap)
			end
			!! form.make (Widget_names.form, Current)
			!! top_form.make (Widget_names.form, form)
--samik			!! focus_label.initialize (top_form)
			!! command_hole.make (Current, top_form)
			!! instance_hole.make (Current, top_form)
			!! trash_hole.make (top_form)
			!! observer_hole.make (Current, form)
			!! close_b.make (Current, top_form)
			!! argument_sw.make (Widget_names.scroll2, form)
--			!! arguments.make (Widget_names.icon_box1, argument_sw)
			!! observers_sw.make (Widget_names.scroll3, form)
			!! observers.make (Widget_names.icon_box4, observers_sw, Current)
			observers.set_row_layout
			observers.set_spacing (5)
			initialize_window_attributes
				-- *******************
				-- Perform attachments 
				-- *******************
			top_form.attach_top (instance_hole, 0)
			top_form.attach_top (trash_hole, 0)
			top_form.attach_top (command_hole, 0)
			top_form.attach_top (close_b, 0)
--samik			top_form.attach_top (focus_label, 0)
--samik			top_form.attach_bottom (focus_label, 0)
			top_form.attach_bottom (close_b, 0)
			top_form.attach_bottom (instance_hole, 0)
			top_form.attach_bottom (command_hole, 0)
			top_form.attach_bottom (trash_hole, 0)
			top_form.attach_left (instance_hole, 0)
			top_form.attach_left_widget (instance_hole, command_hole, 0)
			top_form.attach_left_widget (command_hole, trash_hole, 0)
--samik			top_form.attach_left_widget (trash_hole, focus_label, 0)
--samik			top_form.attach_right_widget (close_b, focus_label, 0)
			top_form.attach_right (close_b, 0)

			form.attach_left (top_form, 0)
			form.attach_right (top_form, 0)
			form.attach_top_widget (top_form, argument_sw, 2)
			form.attach_left (argument_sw, 0)
			form.attach_right (argument_sw, 0)
			form.attach_top_widget (argument_sw, observer_hole, 20)
			form.attach_left (observer_hole, 0)
			form.attach_top_widget (observer_hole, observers_sw, 2)
			form.attach_right (observers_sw, 0)
			form.attach_left (observers_sw, 0)
			form.attach_bottom (observers_sw, 0)	
				-- **********
				-- Set values
				-- **********
--			observers_sw.set_working_area (observers)
			arguments.set_row_layout
			arguments.set_spacing (5)
			!! del_com.make (Current)
			set_delete_command (del_com)	
		end

end
