indexing
	description: "A command page in the command catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class COMMAND_PAGE 

inherit
	
	CAT_PAGE [CMD]
		rename
			make as old_make
		undefine
			init_toolkit
		redefine
			associated_catalog, 
			new_icon, create_new_icon, 
			button
		end

	WINDOWS

	ERROR_POPUPER

	SHARED_PREDEF_COMS

feature {CAT_COM_IS}

	associated_catalog: COMMAND_CATALOG 
			-- Command catalog in main panel

feature {CATALOG}

	button: CMD_CAT_BUTTON

	reset_commands is
		deferred
		end

feature {NONE}

	new_icon: CAT_COM_IS

	create_new_icon is
		do
			!!new_icon.make (Current)
		end

feature 

	remove_command (c: USER_CMD) is
		local
			command_tools: LINKED_LIST [COMMAND_TOOL]
			remove_cmd: CAT_CUT_COMMAND
		do
			if c.has_instances then
				error_box.popup (Current, 
					Messages.instance_rem_com_er, Void)
			else
				if not (c.command_editor = Void) then
					c.command_editor.clear
				end
				from
					command_tools := window_mgr.command_tools
					command_tools.start
				until
					command_tools.after
				loop
					if (command_tools.item.command_instance /= Void) and then 
						(command_tools.item.command_instance.associated_command = c)
					then
						command_tools.item.clear
					end
					command_tools.forth
				end
				start
				search (c)
				if
					not after
				then
					!!remove_cmd
					remove_cmd.execute (Current)
				end

			end
		end

	popuper_parent: COMPOSITE is
		do
			Result := Command_catalog
		end
 

end
