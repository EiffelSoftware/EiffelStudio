
class CMD_ED_INST_ED_H 
 
inherit
 
	ICON_HOLE
		rename
			make_visible as make_button_visible
		end;
	ICON_HOLE
		redefine
			make_visible
		select
			make_visible
		end;
	WINDOWS;
	COMMAND

creation

	make

	
feature 

	make (ed: CMD_EDITOR) is
		do
			associated_editor := ed;
		end;
 
	make_visible (a_parent: COMPOSITE) is
		do
			make_button_visible (a_parent);
			set_symbol (Pixmaps.create_command_instance_b_pixmap);
			add_activate_action (Current, Void)
		end;

	
feature {NONE}

	associated_editor: CMD_EDITOR;

	create_instance_editor (c: CMD) is
		local
			inst_editor: CMD_INST_EDITOR;
			inst: CMD_INSTANCE;
		do
			if not (c = Void) then
				!!inst.session_init (c);
				inst_editor := window_mgr.cmd_inst_editor;
				inst_editor.set_instance (inst);
				window_mgr.display (inst_editor)	
			end
		end;
 
	process_stone is
		local
			cmd_type: CMD_STONE;
			cmd_inst: CMD_INST_STONE
		do
			cmd_type ?= stone;
			cmd_inst ?= stone;
			if not (cmd_type = Void) then
				create_instance_editor (cmd_type.original_stone);
			elseif not (cmd_inst = Void) then
				create_instance_editor (cmd_inst.associated_command)
			end
		end; -- process_stone

	execute (argument: ANY) is
		do
			create_instance_editor (associated_editor.current_command)	
		end;
 
end
