
class BAR_FORM 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	CONTEXT_CMDS
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	EDITOR_FORM
		undefine
			init_toolkit
		redefine
			form_name, context
		end


creation

	make

	
feature 

	form_name: STRING is
			-- Name of the form in the menu
		do
			Result := S_ubmenu_form_name
		end;

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, bar_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			add_submenu: PUSH_BG;
		do
			initialize (Bar_form_name, a_parent);

			!!add_submenu.make (A_dd_submenu, Current);
			add_submenu.add_activate_action (Current, add_submenu);

			attach_left (add_submenu, 10);
			attach_top (add_submenu, 10);
		end;

	
feature {NONE}

	execute (argument: ANY) is
			-- create a submenu
		local
			new_context: CONTEXT
		do
			new_context := context_catalog.submenu_type.create_context (context);
			new_context.realize;
			tree.display (new_context)
		end;

	context: MENU_C;

	reset is
		do
		end;

	
feature 

	apply is
		do
		end;

end
