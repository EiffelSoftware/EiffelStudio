

class MENU_ENTRY_C 

inherit

	BUTTON_C
		rename
			create_context as button_create_context
		redefine
			add_widget_callbacks, remove_widget_callbacks,
			initialize_transport,
			stored_node, is_selectionnable, widget, add_to_option_list
		end;

	BUTTON_C
		redefine
			add_widget_callbacks, remove_widget_callbacks, initialize_transport,
			stored_node, is_selectionnable, create_context, widget,
			add_to_option_list
		select
			create_context
		end
	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_entry_type
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.menu_entry_pixmap
		end;

feature {NONE}

	add_widget_callbacks is
		do 
			initialize_transport;
		end;


	initialize_transport is
		do
		end;

	remove_widget_callbacks is
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
		do
			menu ?= a_parent;
			if not (menu = Void) then
				Result := button_create_context (a_parent);
			end;
		end;

	is_selectionnable: BOOLEAN is
			-- Is current context selectionnable
		do
			Result := False
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.label_text_att_form_nbr,
					Context_const.Attribute_format_nbr);
		end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_MENU_ENTRY is
		do
			!!Result.make (Current);
		end;

end
