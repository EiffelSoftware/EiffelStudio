

class MENU_ENTRY_C 

inherit

	BUTTON_C
		rename
			create_context as button_create_context
		redefine
			add_widget_callbacks, initialize_transport,
			stored_node, is_selectionable, widget, add_to_option_list,
			is_valid_parent, is_able_to_be_grouped, is_movable
		end;

	BUTTON_C
		redefine
			add_widget_callbacks, initialize_transport,
			stored_node, is_selectionable, create_context, widget,
			add_to_option_list, is_valid_parent, is_able_to_be_grouped,
			is_movable
		select
			create_context
		end
	
feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_entry_type
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.menu_entry_pixmap
		end;

    is_valid_parent (parent_context: COMPOSITE_C): BOOLEAN is
            -- Is `parent_context' a valid parent?
			--| Valid if parent is menu_c
        local
            menu_c: MENU_C
        do
            menu_c ?= parent_context;
            Result := menu_c /= Void
		end

	is_able_to_be_grouped: BOOLEAN is
		do
		end

	is_movable: BOOLEAN is
		do
			Result := False
		end;

feature {NONE}

	add_widget_callbacks is
		do 
			initialize_transport;
		end;


	initialize_transport is
		do
		end;

feature 

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
		end;

	widget: PUSH_B;

	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Menu_entry");
		end;
	
feature 

	eiffel_type: STRING is "PUSH_B";

	create_context (a_parent: COMPOSITE_C): like Current is
		local
			menu: MENU_C;
			opt_pull_c: OPT_PULL_C
			was_managed: BOOLEAN
		do
			menu ?= a_parent;
			if menu /= Void then
				if menu.widget.managed then
					menu.widget.unmanage;
					was_managed := True;
				end;
				Result := button_create_context (a_parent);
				opt_pull_c ?= menu;
				if opt_pull_c /= Void then	
					opt_pull_c.set_default_selected_button (Result)
				end
				if was_managed then
					menu.widget.manage;
				end
			end;
		end;

	is_selectionable: BOOLEAN is
			-- Is current context selectionnable
		do
			Result := False
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.label_text_att_form_nbr,
					Context_const.Attribute_format_nbr);
		end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_MENU_ENTRY_R1 is
		local
			foobar: S_MENU_ENTRY
		do
			!!Result.make (Current);
			if foobar = Void then end;
				-- So it won't be dead code removed
		end;

end
