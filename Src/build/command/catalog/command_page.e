
deferred class COMMAND_PAGE 

inherit
	
	CAT_PAGE [CMD]
		rename
			make as old_make
-- added by samik
		undefine
			init_toolkit
-- end of samik
		redefine
			associated_catalog, 
			new_icon, create_new_icon, 
			button
	
		end;
	WINDOWS;
	ERROR_POPUPER;
	SHARED_PREDEF_COMS

feature {CAT_COM_IS}

	associated_catalog: CMD_CATALOG

feature {CATALOG}

	button: CMD_CAT_BUTTON;

	reset_commands is
		deferred
		end;

feature {NONE}

	new_icon: CAT_COM_IS;

	create_new_icon is
		do
			!!new_icon.make (Current);
		end;

feature 

	remove_command (c: USER_CMD) is
		local
			inst_editors: LINKED_LIST [CMD_INST_EDITOR];
			remove_cmd: CAT_CUT_COMMAND
		do
			if c.has_instances then
				error_box.popup (Current, 
					Messages.instance_rem_com_er, Void);
			else
				if not (c.command_editor = Void) then
					c.command_editor.clear
				end;
				from
					inst_editors := window_mgr.instance_editors;
					inst_editors.start
				until
					inst_editors.after
				loop
					if (inst_editors.item.command_instance /= Void) and then 
						(inst_editors.item.command_instance.associated_command = c)
					then
						inst_editors.item.clear
					end;
					inst_editors.forth
				end;
				start;
				search (c);
				if
					not after
				then
					!!remove_cmd;
					remove_cmd.execute (Current)
				end;

			end;
		end;

	popuper_parent: COMPOSITE is
		do
			Result := Command_catalog
		end
 

end
