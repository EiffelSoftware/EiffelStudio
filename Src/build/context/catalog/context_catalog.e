
class CONTEXT_CATALOG 

inherit

	EB_TOP_SHELL
		rename
			make as top_shell_create,
			realize as top_shell_realize
		redefine
			set_geometry
		end;
	WINDOWS
		select
			init_toolkit
		end
	SHARED_TRANSLATIONS;
	SHARED_CONTEXT;
	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_x_y (Resources.cont_cat_x,
					Resources.cont_cat_y);
			set_size (Resources.cont_cat_width,
					Resources.cont_cat_height);
		end;

feature {NONE}

	current_button: CON_CAT_BUTTON;
	
feature 

	window_page: WINDOW_PAGE;
	primitive_page: PRIMITIVE_PAGE;
	menu_page: MENU_PAGE;
	group_page: GROUP_PAGE;
	set_page: SET_PAGE;
	scroll_page: SCROLL_PAGE;

feature {CONTEXT_CAT_PAGE}

	form: FORM;

	first_separator: SEPARATOR;

	second_separator: SEPARATOR

feature 

	make is 
		local
			edit_hole: CON_ED_HOLE;
			cut_hole: CUT_HOLE;
			del_com: DELETE_WINDOW;
			cat_button: CON_CAT_BUTTON;
			rc: ROW_COLUMN;
			close_b: CLOSE_WINDOW_BUTTON;
			top_form: FORM
		do
			top_shell_create (Widget_names.context_catalog, eb_screen);
			--set_size (240, 260);
			!! form.make (Widget_names.form, Current);
			!! top_form.make (Widget_names.form, form);

			!! first_separator.make (Widget_names.Separator, form);
			first_separator.set_horizontal (true);
			!! second_separator.make (Widget_names.Separator2, form);
			second_separator.set_horizontal (true);
			!! rc.make (Widget_names.row_column, form);
			rc.set_preferred_count (1);
			rc.set_row_layout;


			!! edit_hole.make (top_form);
			!! cut_hole.make (top_form);
			!! close_b.make (Current, top_form);

			!! window_page.make (form, rc);
			!! primitive_page.make (form, rc);
			!! scroll_page.make (form, rc);
			!! menu_page.make (form, rc);
			!! set_page.make (form, rc);
			!! group_page.make (form, rc);
			
			current_button := window_page.button;

			top_form.attach_top (edit_hole, 0);
			top_form.attach_top (cut_hole, 0);
			top_form.attach_top (close_b, 0);
			top_form.attach_left (edit_hole, 0);
			top_form.attach_left_widget (edit_hole, cut_hole, 0);
			top_form.attach_right (close_b, 0);
			top_form.attach_bottom (edit_hole, 0);
			top_form.attach_bottom (cut_hole, 0);
			top_form.attach_bottom (close_b, 0);

			form.attach_left (first_separator, 0);
			form.attach_right (first_separator, 0);
			form.attach_left (second_separator, 0);
			form.attach_right (second_separator, 0);
			form.attach_left (top_form, 0);
			form.attach_right (top_form, 0);
			form.attach_top_widget (top_form, first_separator, 2);

			attach_page (window_page);
			attach_page (group_page);
			attach_page (primitive_page);
			attach_page (set_page);
			attach_page (scroll_page);
			attach_page (menu_page);

			form.attach_bottom_widget (rc, second_separator, 2);
			form.attach_left (rc, 0);
			form.attach_right (rc, 0);
			form.attach_bottom (rc, 0);
			initialize_window_attributes;
			current_button.set_selected;
			!! del_com.make (Current);
			set_delete_command (del_com);
		end;

feature {NONE}

	close is
		do
			hide;
			main_panel.cont_cat_t.set_toggle_off
		end;

	attach_page (page: CONTEXT_CAT_PAGE) is
		do
			form.attach_top_widget (first_separator, page, 5);
			form.attach_left (page, 0);
			form.attach_right (page, 0);
			form.attach_bottom_widget (second_separator, page, 5);
		end;

feature

	update_page (bt: like current_button) is
		require
			valid_page: bt /= Void;
			not_same: not same_as (bt)
		local
			current_page: CONTEXT_CAT_PAGE
		do
			if current_button /= Void then
				current_button.deselect;
			end;
			current_button := bt;
			current_page := bt.catalog_page;
			current_page.show	
		end;

	same_as (bt: like current_button): BOOLEAN is
			-- Is `bt' same as current_button?
		do
			Result := current_button = bt
		end;

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

feature -- Group management

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
			add_group_type (a_context_type);
		end;

	has_group_name (group_name: STRING): BOOLEAN is
			-- Does `group_name' exists?
		require
			valid_group_name: group_name /= Void
		local
			a_name, e_name: STRING
		do
			a_name := clone (group_name);
			a_name.to_upper
			from
				Shared_group_list.start
			until
				Shared_group_list.after or Result
			loop
				e_name := Shared_group_list.item.entity_name;
				Result :=  a_name.is_equal (e_name);
				Shared_group_list.forth;
			end;
		end;

	update_groups is
		local
			a_context_type: CONTEXT_GROUP_TYPE;
			group_c: GROUP_C;
			a_group: GROUP
		do
			group_page.icon_box.unmanage;
			group_page.icon_box.wipe_out;
			from
				Shared_group_list.start
			until
				Shared_group_list.after
			loop
				a_group := Shared_group_list.item;
				!!group_c;
				group_c.set_type (a_group);
				!!a_context_type.make (a_group.entity_name, group_c);
				append_group_type (a_context_type);
				Shared_group_list.forth
			end;
			group_page.icon_box.manage;
		end;

	add_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
		do
			append_group_type (a_context_type);
			Shared_group_list.extend (a_context_type.group);
		end;

	remove_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
		do
			Shared_group_list.start;
			Shared_group_list.search (a_context_type.group);
			Shared_group_list.remove;
			context_group_types.start;
			from 
				context_group_types.start
			until
				context_group_types.after or 
				else (context_group_types.item.group 
						= a_context_type.group)
			loop
				context_group_types.forth
			end
			context_group_types.remove;
			update_groups;
		end;

feature {NONE}

	append_group_type (a_context_group: CONTEXT_GROUP_TYPE) is
		do
			context_group_types.finish;
			context_group_types.put_right (a_context_group);
			group_page.icon_box.extend (a_context_group);
		end;

feature -- Context_editor list

	update_state_name_in_behavior_page (state: STATE) is
			-- Update the state name in behavior page
			-- that displays `state'.
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
				an_editor.update_state_name_in_behavior_page (state);
				editor_list.forth;
			end;
		end;

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
				if an_editor.edited_context = a_context then
					an_editor.update_title;
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
				other_editor.reset_current_form
			end
		end;

	clear is
			-- Clear the group page (of Current) and 
			-- the translation page of the Behaviour editor.
		local
			cont: PERM_WIND_C
		do
			from
				Shared_window_list.start
			until	
				Shared_window_list.after
			loop
				Shared_window_list.item.hide;
				Shared_window_list.forth
			end;
			from
				Shared_window_list.start
			until	
				Shared_window_list.after
			loop
				cont ?= Shared_window_list.item;
				if cont /= Void then
					cont.widget.destroy;
				end;
				Shared_window_list.forth
			end;
			Shared_window_list.wipe_out;
			tree.wipe_out;
			tree.clear;
			group_page.clear;	
			Shared_translation_list.wipe_out;
			Shared_group_list.wipe_out;
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
			beh_form: BEHAVIOR_FORM
		do
			editor_list := window_mgr.context_editors;
			from
				editor_list.start
			until
				editor_list.after 
			loop
				if editor_list.item.behavior_form_shown then
					editor_list.item.update_translation_page;
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
				if editor_list.item.edited_context = a_context then
					editor_list.item.clear
				end;
				editor_list.forth;
			end;
		end;

	realize is
		do	
			main_panel.cont_cat_t.set_toggle_on;
			top_shell_realize;
			primitive_page.hide;
			menu_page.hide;
			group_page.hide;
			set_page.hide;
			scroll_page.hide;
		end;

end
