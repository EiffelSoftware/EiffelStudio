
class CONTEXT_CATALOG 

inherit

	TOP_SHELL
		rename
			make as top_shell_create,
			realize as top_shell_realize
		export
			{NONE} all;
			{ANY} show, hide, shown
		undefine
			init_toolkit
		redefine
			delete_window_action
		end;
	WINDOWS;
	CONTEXT_NAMES;
	COMMAND;
	GROUP_SHARED;
	CONTEXT_SHARED;
	COMMAND_ARGS;
	TRANSL_SHARED;
	PIXMAPS

creation

	make

feature {NONE}

	bottom_form: CONTEXT_CAT_PAGE;
	
feature 

	window_page: WINDOW_PAGE;
	primitive_page: PRIMITIVE_PAGE;
	menu_page: MENU_PAGE;
	group_page: GROUP_PAGE;
	set_page: SET_PAGE;
	scroll_page: SCROLL_PAGE;

	focus_label: LABEL;

	
feature {NONE}

	page_label: LABEL;

	
feature {CONTEXT_CAT_PAGE}

	top_form: FORM;

	second_separator: SEPARATOR;

	
feature 

	make is 
		local
			first_separator: SEPARATOR;
			edit_hole: CON_CAT_ED_H
		do
			top_shell_create (C_ontextcatalog, eb_screen);
			set_size (240, 260);
			!!top_form.make (F_orm, Current);
			--!!window_page;
			--!!primitive_page;
			--!!menu_page;
			--!!group_page;
			--!!set_page;
			--!!scroll_page;

			!!first_separator.make (S_eparator, top_form);
			first_separator.set_horizontal (true);

			!!second_separator.make (S_eparator, top_form);
			second_separator.set_horizontal (true);

			!!edit_hole.make (P_Cbutton, top_form);

			!!window_page.make (W_indows, Windows_pixmap);
			!!primitive_page.make (P_rimitives, Primitives_pixmap);
			!!menu_page.make (M_enus, Menus_pixmap);
			!!group_page.make (G_roups, Groups_pixmap);
			!!set_page.make (S_ets, Sets_pixmap);
			!!scroll_page.make (S_crolled_items, Scrolled_w_pixmap);

			!!page_label.make (L_abel, top_form);

			page_label.set_left_alignment;
		
		
			!!focus_label.make (L_abel, top_form);
			page_label.set_text (primitive_page.page_name);

			top_form.attach_top (window_page.button, 10);
			top_form.attach_right (group_page.button, 10);
			top_form.attach_right_widget (group_page.button, set_page.button, 10);
			top_form.attach_top (primitive_page.button, 10);
			top_form.attach_right_widget (set_page.button, menu_page.button, 10);
			top_form.attach_top (scroll_page.button, 10);
			top_form.attach_right_widget (menu_page.button, scroll_page.button, 10);
			top_form.attach_top (menu_page.button, 10);
			top_form.attach_right_widget (scroll_page.button, primitive_page.button, 10);
			top_form.attach_top (set_page.button, 10);
			top_form.attach_right_widget (primitive_page.button, window_page.button, 10);
			top_form.attach_top (group_page.button, 10);
			top_form.attach_top (edit_hole, 10);
			top_form.attach_left (edit_hole, 10);

			top_form.attach_top (first_separator, 40);
			top_form.attach_right (first_separator, 0);
			top_form.attach_left (first_separator, 0);

			top_form.attach_left (page_label, 10);
			top_form.attach_top_widget (first_separator, page_label, 5);

			top_form.attach_right (focus_label, 10);
			top_form.attach_top_widget (first_separator, focus_label, 5);

			top_form.attach_top_widget (focus_label, second_separator, 5);
			top_form.attach_top_widget (page_label, second_separator, 5);
			top_form.attach_right (second_separator, 0);
			top_form.attach_left (second_separator, 0);

			bottom_form := window_page;
			page_label.set_text ("dummy initial value");
			focus_label.unmanage;
			focus_label.set_text ("dummy initial value");
			focus_label.manage;
		end;

	delete_window_action is
		do
			iterate;
		end;
	
feature {NONE}

	execute (argument: CONTEXT_CAT_PAGE) is
		do
			-- Buttons in the top of the catalog
			if argument /= bottom_form then
				bottom_form.hide;
				bottom_form := argument;
	
				page_label.set_text (bottom_form.page_name);
				bottom_form.show
			end
		end; -- execute

	-- *****************
	-- * Context types *
	-- *****************

	
feature 

	perm_wind_type: CONTEXT_TYPE is
		do
			Result := window_page.perm_wind_type
		end;

	temp_wind_type: CONTEXT_TYPE is
		do
			Result := window_page.temp_wind_type
		end;

	toggle_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.toggle_b_type
		end;

	text_type: CONTEXT_TYPE is
		do
			Result := scroll_page.text_type
		end;

	scroll_list_type: CONTEXT_TYPE is
		do
			Result := scroll_page.scroll_list_type
		end;


	drawing_area_type: CONTEXT_TYPE is
		do
			Result := scroll_page.drawing_area_type
		end;

	label_type: CONTEXT_TYPE is
		do
			Result := primitive_page.label_type
		end;

	push_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.push_b_type
		end;

	text_field_type: CONTEXT_TYPE is
		do
			Result := primitive_page.text_field_type
		end;

	menu_entry_type: CONTEXT_TYPE is
		do
			Result := menu_page.menu_entry_type
		end;

	submenu_type: CONTEXT_TYPE is
		do
			Result := menu_page.submenu_type
		end;

	separator_type: CONTEXT_TYPE is
		do
			Result := primitive_page.separator_type
		end;

	scale_type: CONTEXT_TYPE is
		do
			Result := primitive_page.scale_type
		end;

	pict_color_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.pict_color_b_type
		end;

	arrow_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.arrow_b_type
		end;

	bar_type: CONTEXT_TYPE is
		do
			Result := menu_page.bar_type
		end;

	option_btn_type: CONTEXT_TYPE is
		do
			Result := menu_page.option_btn_type
		end;

	bulletin_type: CONTEXT_TYPE is
		do
			Result := set_page.bulletin_type
		end;

	radio_box_type: CONTEXT_TYPE is
		do
			Result := set_page.radio_box_type
		end;

	check_box_type: CONTEXT_TYPE is
		do
			Result := set_page.check_box_type
		end;




	-- *******************
	-- * Group managment *
	-- *******************

	context_group_types: LINKED_LIST [CONTEXT_GROUP_TYPE] is
		once
			!!Result.make
		end;

	add_new_group (a_group: GROUP) is
		local
			a_context_type: CONTEXT_GROUP_TYPE;
			group_c: GROUP_C;
		do
			!!group_c;
			group_c.set_type (a_group);

			!!a_context_type.make (a_group.entity_name, group_c);
			append_group_type (a_context_type);
		end;

	append_group_type (a_context_group: CONTEXT_GROUP_TYPE) is
		do
			context_group_types.finish;
			context_group_types.put_right (a_context_group);
			group_page.icon_box.extend (a_context_group);
		end;

	update_groups is
		do
			group_page.icon_box.wipe_out;
			from
				group_list.start
			until
				group_list.after
			loop
				add_new_group (group_list.item);
				group_list.forth
			end;
		end;

	remove_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
		do
			group_list.start;
			group_list.search (a_context_type.group);
			group_list.remove;
			context_group_types.start;
			context_group_types.search (a_context_type);
			context_group_types.remove;
			update_groups;
		end;

	-- ***********************
	-- * Context_editor list *
	-- ***********************

	update_name_in_editors (a_context: CONTEXT) is
			-- Update the icon name of `a_context' that
			-- is being edited.
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR];
			an_editor: CONTEXT_EDITOR;
		do
			editor_list := window_mgr.context_editors;
			from
				editor_list.start
			until
				editor_list.after
			loop
				an_editor := editor_list.item;
				if an_editor.edited_context =  a_context then
					an_editor.update_icon_name;
				end;
				editor_list.forth;
			end;
		end;

	editor (a_context: CONTEXT; a_form_number: INTEGER): CONTEXT_EDITOR is
			-- Editor for `a_context' with current
			-- option `a_form_number'. (Void if this
			-- does not exists).
		local
			ed: CONTEXT_EDITOR;
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
		do
			editor_list := window_mgr.context_editors;
			from
				editor_list.start
			until
				editor_list.after or else
				(Result /= Void)
			loop
				ed := editor_list.item;
				if
					((ed.edited_context = a_context) and then
					(ed.current_form_number = a_form_number))
				--! Only one option form open per context
				then
					Result := ed
				end;
				editor_list.forth;
			end;
		end;

	update_editors (a_context: CONTEXT; a_form_number: INTEGER) is
			-- Update editor for `a_context' with current
			-- option `a_form_number'. (Do nothing if
			-- does not exists).
		local
			other_editor: CONTEXT_EDITOR
		do
			other_editor := editor (a_context, a_form_number);
			if other_editor /= Void then
				other_editor.current_form.reset_form
			end
		end;

	clear is
			-- Clear the group page (of Current) and 
			-- the translation page of the Behaviour editor.
		do
			from
				window_list.start
			until	
				window_list.after
			loop
				window_list.item.hide;
				window_list.item.widget.destroy;
				window_list.forth
			end;
			window_list.wipe_out;
			tree.wipe_out;
			tree.clear;
			group_page.clear;	
			translation_list.wipe_out;
			update_translation_page;
			perm_wind_type.reset;
			temp_wind_type.reset;
			toggle_b_type.reset;
			text_type.reset;
			label_type.reset;
			push_b_type.reset;
			text_field_type.reset;
			menu_entry_type.reset;
			submenu_type.reset;
			separator_type.reset;
			scale_type.reset;
			pict_color_b_type.reset;
			arrow_b_type.reset;
			bar_type.reset;
			option_btn_type.reset;
			bulletin_type.reset;
			radio_box_type.reset;
			check_box_type.reset;
			scroll_list_type.reset;
			drawing_area_type.reset;
		end;

	update_translation_page is
			-- Display all the translations in the event
			-- catalog. 
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR];
			form: BEHAVIOR_FORM
		do
			editor_list := window_mgr.context_editors;
			from
				editor_list.start
			until
				editor_list.after 
			loop
				if editor_list.item.behavior_form_shown then
					form ?= editor_list.item.current_form;
					form.update_translation_page
				end;
				editor_list.forth;
			end;
		end;

	clear_editors (a_context: CONTEXT) is
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
		do
			editor_list := window_mgr.context_editors;
			from
				editor_list.start
			until
				editor_list.after
			loop
				if editor_list.item.edited_context =  a_context then
					editor_list.item.clear
				end;
				editor_list.forth;
			end;
		end;

	realize is
		do	
			top_shell_realize;
			primitive_page.hide;
			menu_page.hide;
			group_page.hide;
			set_page.hide;
			scroll_page.hide;
			page_label.set_text (window_page.page_name);
			focus_label.set_text ("");
		end;

end
