
class BAR_FORM 

inherit

	WINDOWS;
	COMMAND;
	EDITOR_FORM
		undefine
			init_toolkit
		redefine
			context
		end

creation

	make

feature -- Interface 

	make_visible (a_parent: COMPOSITE) is
		local
			add_submenu: PUSH_BG;
		do
			initialize (Context_const.bar_form_name, a_parent);

			!!add_submenu.make (Context_const.add_submenu_name, Current);
			add_submenu.add_activate_action (Current, add_submenu);

			attach_left (add_submenu, 10);
			attach_top (add_submenu, 10);
			show_current
		end;

feature {NONE}

	context: MENU_C is
		do
			Result ?= editor.edited_context;
		end;

	execute (argument: ANY) is
			-- create a submenu
		local
			new_context: CONTEXT
		do
			new_context := context_catalog.submenu_type.create_context (context);
			new_context.realize;
			tree.display (new_context)
		end;

	reset is
		do
		end;

	form_number: INTEGER is
		do
			Result := Context_const.bar_sm_form_nbr
		end;

	apply is
		do
		end;

end
