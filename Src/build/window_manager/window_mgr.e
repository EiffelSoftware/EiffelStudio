
class WINDOW_MGR 

inherit
	
	EDITOR_NAMES
	CONSTANTS

creation

	make
	
feature {NONE}

	command_tools_list: COMMAND_TOOL_MGR
		-- Command tools manager

	state_editors_list: ST_EDITOR_MGR
		-- State editors manager

	context_editors_list: CON_EDITOR_MGR
		-- Context editors manager

	make (a_screen: SCREEN) is
			-- Create a window manager. All editors will be create 
			-- using `a_screen' as the parent. Allow `i' amount for
			-- the free list.
		do
			!!state_editors_list.make (Widget_names.state_editor, 
						a_screen, Resources.window_free_list_number)
			!!context_editors_list.make (Widget_names.context_editor, 
						a_screen, Resources.window_free_list_number)
			!!command_tools_list.make (Widget_names.command_tool, 
						a_screen, Resources.window_free_list_number)
		end

feature 

	state_editors: LINKED_LIST [STATE_EDITOR] is
			-- State editors shown 
		do
			Result := state_editors_list.active_editors
		end

	context_editors: LINKED_LIST [CONTEXT_EDITOR_TOP_SHELL] is
			-- Context editors shown 
		do
			Result := context_editors_list.active_editors
		end

	command_tools: LINKED_LIST [COMMAND_TOOL] is
			-- Command tools shown
		do
			Result := command_tools_list.active_editors
		end

	command_tool: COMMAND_TOOL is
			-- Create a command tool
		do
			Result := command_tools_list.editor
		end

	state_editor: STATE_EDITOR is
			-- Create a state editor
		do
			Result := state_editors_list.editor
		end

	context_editor: CONTEXT_EDITOR_TOP_SHELL is
			-- Create a context editor
		do
			Result := context_editors_list.editor
		end

	display (ed: EB_TOP_SHELL) is
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
		end

	close (ed: EB_TOP_SHELL) is
			-- Close `ed'. 
		local
		 	s_ed: STATE_EDITOR
			cmd_tool: COMMAND_TOOL
			con_ed: CONTEXT_EDITOR_TOP_SHELL			
		do
			s_ed ?= ed
			con_ed ?= ed
			cmd_tool ?= ed
			if s_ed /= Void then
				state_editors_list.remove (s_ed)
			elseif cmd_tool /= Void then
				command_tools_list.remove (cmd_tool)
			elseif con_ed /= Void then
				context_editors_list.remove (con_ed)
			end				
		end

	clear_all_editors is
		do
			state_editors_list.clear_editors
			context_editors_list.clear_editors
		end

	hide_all_editors is
		do
			state_editors_list.hide_editors
			context_editors_list.hide_editors
		end

	show_all_editors is
		do
			state_editors_list.show_editors
			context_editors_list.show_editors
		end

end 
