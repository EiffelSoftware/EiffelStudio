indexing
	description: "Windows manager."
	Id: "$Id$" 
	Date: "$Date$"
	Revision: "$Revision$"

class WINDOW_MGR 

inherit
--useless	EDITOR_NAMES
	
	CONSTANTS

creation

	make
	
feature {NONE} -- Initialization

	command_tools_list: COMMAND_TOOL_MGR
		-- Command tools manager

	state_editors_list: ST_EDITOR_MGR
		-- State editors manager

	context_editors_list: CON_EDITOR_MGR
		-- Context editors manager

	make (par: MAIN_WINDOW) is
			-- Create a window manager. All editors will be created 
			-- using `par' as the parent. Allow `i' amount for
			-- the free list.
		do
			create state_editors_list.make (par.app_editor, Resources.window_free_list_number)
			create context_editors_list.make (par, Resources.window_free_list_number)
			create command_tools_list.make (par, Resources.window_free_list_number)
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

	display (ed: EB_WINDOW) is
			-- Display `ed' (or raise `ed' if already
			-- displayed).
		do
			if not ed.shown then
				ed.show
--			else
--				ed.raise
			end
		end

	close (ed: EB_WINDOW) is
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

	hide_all_command_tools is
		do
			command_tools_list.hide_editors
		end
	
	show_all_command_tools is
		do
			command_tools_list.show_editors
		end

end -- class WINDOW_MGR 

