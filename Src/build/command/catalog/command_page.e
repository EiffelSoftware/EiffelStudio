

class COMMAND_PAGE 

inherit
	
	CAT_PAGE [CMD]
		rename
			make as old_create, 
			make_visible as cat_page_make_visible
		undefine
			init_toolkit
		redefine
			associated_catalog, 
			new_icon, create_new_icon, 
			button, create_button
		end;
	CAT_PAGE [CMD]
		rename
			make as old_create
		undefine
			init_toolkit
		redefine
			associated_catalog, 
			new_icon, create_new_icon, 
			button, create_button, make_visible
		select
			make_visible
		end;
	WINDOWS
		export
			{NONE} all
		end;
	ERROR_POPUPER
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	associated_catalog: CMD_CATALOG;

	
feature {CATALOG}

	button: CMD_CAT_BUTTON;

	
feature {NONE}

	new_icon: CAT_COM_IS;

feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: CMD_CATALOG) is
		do
			old_create (page_n, a_symbol, cat);
		end;

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
		do
			cat_page_make_visible (a_name, a_parent);
			set_column_layout;
			set_preferred_count (5);
		end;

	
feature {NONE}

	create_new_icon is
		do
			!!new_icon.make (Current);
		end;

	create_button is
		do
			!!button.make (page_name, Current)
		end;

	
feature 

	remove_command (c: USER_CMD) is
		local
			msg: STRING;
			inst_editors: LINKED_LIST [CMD_INST_EDITOR];
			remove_cmd: CAT_CUT_COMMAND
		do
			if c.has_instances then
				!!msg.make (0);
				msg.append ("Command has instances. Cannot remove command%N");
				error_box.popup (Current, msg);
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
					if (inst_editors.item.command_instance.associated_command = c)
					then
						inst_editors.item.clear
					end;
					inst_editors.forth
				end;
				start;
				search (c);
				if
					not offright
				then
					!!remove_cmd;
					remove_cmd.execute (Current)
				end;

			end;
		end;
 

end
