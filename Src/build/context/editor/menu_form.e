
class MENU_FORM 

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
	COMMAND_ARGS
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

	
feature {NONE}

	title: EB_TEXT_FIELD;
			-- Title of the menu

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, menu_form_number);
		end;

	
feature {NONE}

	create_buttons is
		do
			!!title.make (T_extfield, Current, menu_cmd, editor);
			attach_left (title, 100);
			attach_right (title, 10);

			!!add_button.make (A_dd_button, Current);
			!!add_submenu.make (A_dd_submenu, Current);

			add_button.add_activate_action (Current, First);
			add_submenu.add_activate_action (Current, Third);

			attach_left (add_button, 10);
			attach_left (add_submenu, 10);
		end;

	add_button: PUSH_BG;
	add_submenu: PUSH_BG;

	
feature 

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			label: LABEL_G;
		do
			initialize (Menu_form_name, a_parent);
			!!label.make (T_itle, Current);

			create_buttons;

			attach_left (label, 10);

			attach_top (title, 10);
			attach_top (label, 10);
			attach_top_widget (title, add_button, 10);
			attach_top_widget (add_button, add_submenu, 10);
		end;

	
feature {NONE}

	execute (argument: ANY) is
			-- One of the two buttons is pressed,
			-- create a menu button or a submenu
		local
			type: CONTEXT_TYPE;
			new_context: CONTEXT
		do
			if argument = First then
				-- Create a button
				type := context_catalog.menu_entry_type;
			else
				-- Create a submenu
				type := context_catalog.submenu_type;
			end;
			new_context := type.create_context (context);
			new_context.realize;
			tree.display (new_context)
		end;

	context: MENU_C;

	reset is
		do
			if not (context.title = Void) then
				title.set_text (context.title);
			else
				title.set_text ("");
			end;
		end;

	
feature 

	apply is
		do
			context.set_title (title.text);
		end;

end
