
class MENU_FORM 

inherit

	WINDOWS;
	COMMAND;
	COMMAND_ARGS;
	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature {NONE}

	title: EB_TEXT_FIELD;
			-- Title of the menu

	context: MENU_C is
		do
			Result ?= editor.edited_context
		end;

	form_number: INTEGER is
		do
			Result := Context_const.menu_sm_form_nbr
		end;

	Menu_cmd: MENU_CMD is
		once
			!!Result
		end;

feature {NONE}

	add_button: PUSH_BG;
	add_submenu: PUSH_BG;
	
	create_buttons is
		do
			!!title.make (Widget_names.textfield, Current, Menu_cmd, editor);
			attach_left (title, 100);
			attach_right (title, 10);

			!!add_button.make (Widget_names.add_button_name, Current);
			!!add_submenu.make (Widget_names.add_submenu_name, Current);

			add_button.add_activate_action (Current, First);
			add_submenu.add_activate_action (Current, Third);

			attach_left (add_button, 10);
			attach_left (add_submenu, 10);
		end;

feature 

	make_visible (a_parent: COMPOSITE) is
		local
			label: LABEL_G;
		do
			initialize (Widget_names.menu_form_name, a_parent);
			!!label.make (Widget_names.title_name, Current);

			create_buttons;

			attach_left (label, 10);

			attach_top (title, 10);
			attach_top (label, 10);
			attach_top_widget (title, add_button, 10);
			attach_top_widget (add_button, add_submenu, 10);
			show_current
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
			tree.display (new_context)
		end;

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
