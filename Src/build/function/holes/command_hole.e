indexing
	description: "Hole which can receive command stones. %
				% Output of behavior function."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 

	COMMAND_HOLE 

inherit

	COMMAND

	ELMT_HOLE
-- 		rename
-- 			make as elmt_hole_make
		redefine
			make, associated_function,
			associated_symbol, associated_label,
			stone_type, process_instance
		end


creation

	make
	
feature 

	make (a_parent: COMPOSITE; func: BEHAVIOR_EDITOR) is
		do
--			elmt_hole_make (a_parent, func)
			Precursor (a_parent, func)
			!! instances_list_wnd.make (a_parent)
			add_button_press_action (3, Current, Void) 
		end

	stone_type: INTEGER is
		do
			Result := Stone_types.command_type	
		end

feature {NONE}

	associated_function: BEHAVIOR_EDITOR

	associated_symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end

	associated_label: STRING is
		do
			Result := Widget_names.command_label
		end

	process_instance (cmd_instance: CMD_INST_STONE) is
        do
			associated_function.update_output_hole (cmd_instance)
        end

	instances_list_wnd: CMD_INSTANCE_CHOICE_WND

	execute (argument: ANY) is
			-- Display a list of possible command instances.
		local
			a_context: CONTEXT
		do
			a_context := associated_function.edited_context
			instances_list_wnd.popup_with_list (Current, a_context.default_commands_list)
		end
end
