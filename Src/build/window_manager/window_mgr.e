
class WINDOW_MGR 

inherit
	
	EDITOR_NAMES;
	CONSTANTS

creation

	make
	
feature {NONE}

	cmd_editors_list: CMD_EDITOR_MGR;
		-- Command type editors manager

	cmd_inst_editors_list: INST_EDITOR_MGR;
		-- Command instance editors manager

	state_editors_list: ST_EDITOR_MGR;
		-- State editors manager

	context_editors_list: CON_EDITOR_MGR;
		-- Context editors manager

	Window_free_list_nbr: INTEGER is 0
	
	make (a_screen: SCREEN) is
			-- Create a window manager. All editors will be create 
			-- using `a_screen' as the parent. Allow `i' amount for
			-- the free list.
		do
			!!state_editors_list.make (Widget_names.state_editor, 
						a_screen, Window_free_list_nbr);
			!!context_editors_list.make (Widget_names.context_editor, 
						a_screen, Window_free_list_nbr);
			!!cmd_editors_list.make (Widget_names.command_type_editor, 
						a_screen, Window_free_list_nbr);
			!!cmd_inst_editors_list.make (Widget_names.cmd_instance_editor, 
						a_screen, Window_free_list_nbr);
		end;

feature 

	cmd_editors: LINKED_LIST [CMD_EDITOR] is
			-- Command editors shown 
		do
			Result := cmd_editors_list.active_editors
		end;

	state_editors: LINKED_LIST [STATE_EDITOR] is
			-- State editors shown 
		do
			Result := state_editors_list.active_editors
		end;

	instance_editors: LINKED_LIST [CMD_INST_EDITOR] is
			-- Instance editors shown 
		do
			Result := cmd_inst_editors_list.active_editors
		end;

	context_editors: LINKED_LIST [CONTEXT_EDITOR] is
			-- Context editors shown 
		do
			Result := context_editors_list.active_editors
		end;

	cmd_editor: CMD_EDITOR is
			-- Create a command type editor
		do
			Result := cmd_editors_list.editor
		end;

	cmd_inst_editor: CMD_INST_EDITOR is
			-- Create a command instance editor
		do
			Result := cmd_inst_editors_list.editor
		end;

	state_editor: STATE_EDITOR is
			-- Create a state editor
		do
			Result := state_editors_list.editor
		end;

	context_editor: CONTEXT_EDITOR is
			-- Create a context editor
		do
			Result := context_editors_list.editor
		end;

	display (ed: TOP_SHELL) is
			-- Display `ed' (or raise `ed' if already
			-- displayed).
		do
			if ed.realized then
				if not ed.shown then
					ed.show
				else
					ed.raise
				end
			else
				ed.realize
			end		
		end;

	close (ed: TOP_SHELL) is
			-- Close `ed'. 
		local
		 	s_ed: STATE_EDITOR;
			cmd_ed: CMD_EDITOR;
			cmd_inst_ed: CMD_INST_EDITOR;
			con_ed: CONTEXT_EDITOR			
		do
			s_ed ?= ed;
			cmd_ed ?= ed;
			cmd_inst_ed ?= ed;
			con_ed ?= ed;
			if s_ed /= Void then
				state_editors_list.remove (s_ed)
			elseif cmd_ed /= Void then
				cmd_editors_list.remove (cmd_ed)
			elseif cmd_inst_ed /= Void then
				cmd_inst_editors_list.remove (cmd_inst_ed)
			elseif con_ed /= Void then
				context_editors_list.remove (con_ed)
			end;				
		end;

	clear_all_editors is
		do
			state_editors_list.clear_editors;
			cmd_editors_list.clear_editors;
			cmd_inst_editors_list.clear_editors;
			context_editors_list.clear_editors;
		end;

	hide_all_editors is
		do
			state_editors_list.hide_editors;
			cmd_editors_list.hide_editors;
			cmd_inst_editors_list.hide_editors;
			context_editors_list.hide_editors;
		end;

	show_all_editors is
		do
			state_editors_list.show_editors;
			cmd_editors_list.show_editors;
			cmd_inst_editors_list.show_editors;
			context_editors_list.show_editors;
		end

end 
