indexing
	description: "A command page in the command catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class
	COMMAND_PAGE 

inherit
	CATALOG_PAGE [CMD]
		redefine
			make
		end

	EV_COMMAND

	WINDOWS

--	ERROR_POPUPER

	SHARED_PREDEF_COMS

feature {NONE} -- Initialization

	make (cat: COMMAND_CATALOG) is
			-- Create a catalog page.
		do
			{CATALOG_PAGE} Precursor (cat)
			set_column_title ("Commands", 1)

			add_pnd_command (Pnd_types.command_type, Current, Void)
			add_pnd_command (Pnd_types.instance_type, Current, Void)
		end

feature -- Access

--	remove_command (c: USER_CMD) is
--		local
--			command_tools: LINKED_LIST [COMMAND_TOOL]
--			remove_cmd: CAT_CUT_COMMAND
--			arg: EV_ARGUMENT2 [USER_CMD, like Current]
--		do
--			if c.has_instances then
--				error_box.popup (Current, 
--					Messages.instance_rem_com_er, Void)
--			else
--				if not (c.command_editor = Void) then
--					c.command_editor.clear
--				end
--				from
--					command_tools := window_mgr.command_tools
--					command_tools.start
--				until
--					command_tools.after
--				loop
--					if (command_tools.item.command_instance /= Void) and then 
--						(command_tools.item.command_instance.associated_command = c)
--					then
--						command_tools.item.clear
--					end
--					command_tools.forth
--				end
--				create remove_cmd
--				create arg.make (c, Current)
--				remove_cmd.execute (arg, Void)
--			end
--		end

--	popuper_parent: COMPOSITE is
--		do
--			Result := Command_catalog
--		end


feature {NONE} -- Pick and Drop

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			cmd: CMD
			cmd_inst: CMD_INSTANCE
		do
			if main_window.project_initialized then
				cmd ?= ev_data.data
				if cmd /= Void then
					cmd.create_editor
				else
					cmd_inst ?= ev_data.data
					cmd_inst.create_editor
				end
			end
		end

	pnd_type: EV_PND_TYPE is
		do
			Result := Pnd_types.command_type
		end

end -- class COMMAND_PAGE

