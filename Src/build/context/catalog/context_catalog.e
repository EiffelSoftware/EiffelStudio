indexing
	description: "Widget representing the context catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"


class 

	CONTEXT_CATALOG 

inherit

	CONSTANTS

	FORM
		rename
			init_toolkit as form_init_toolkit
		redefine
			make, realize
 		end

	WINDOWS
		select
			init_toolkit
		end

	SHARED_TRANSLATIONS

	SHARED_CONTEXT

	CLOSEABLE

creation

	make

feature -- Creation

	make (a_name: STRING a_parent: COMPOSITE) is 
		local
			cat_button: CON_CAT_BUTTON
		do
			Precursor (a_name, a_parent)
			!! first_separator.make (Widget_names.Separator, Current)
			!! rc.make (Widget_names.row_column, Current)
			!! scrolled_w.make ("", Current)
			!! window_page.make (scrolled_w, rc)
			!! primitive_page.make (scrolled_w, rc)
			!! scroll_page.make (scrolled_w, rc)
			!! menu_page.make (scrolled_w, rc)
			!! set_page.make (scrolled_w, rc)
			!! group_page.make (scrolled_w, rc)
			!! context_catalog_label.make ("Context catalog", Current)
			set_values
			attach_all
		end

	set_values is
--		local
--			bg_color: COLOR
		do
--			!! bg_color.make
--			bg_color.set_rgb (background_color.red - 65 * 256, background_color.green - 65 * 256, background_color.blue - 65 * 256)	
			scrolled_w.set_background_color (Resources.catalog_background_color)
			scrolled_w.set_foreground_color (Resources.catalog_foreground_color)
			first_separator.set_horizontal (true)
			rc.set_row_layout
			rc.set_same_size
			primitive_page.unmanage
			menu_page.unmanage
			group_page.unmanage
			set_page.unmanage
			scroll_page.unmanage
			window_page.manage
			scrolled_w.set_working_area (window_page)
			current_button := window_page.button
			current_button.set_selected
			current_page := current_button.catalog_page
		end

	attach_all is
		do
			attach_top (rc, 0)	
			attach_top (context_catalog_label, 3)
			attach_left (context_catalog_label, 0)
			attach_left_widget (context_catalog_label, rc, 10)
--			attach_right (rc, 0)
			attach_top_widget (context_catalog_label, first_separator, 0)
			attach_top_widget (rc, first_separator, 0)

			attach_left (first_separator, 0)
			attach_right (first_separator, 0)

			attach_top_widget (first_separator, scrolled_w, 0)
			attach_left (scrolled_w, 0)
			attach_right (scrolled_w, 0)
			attach_bottom (scrolled_w, 0)

		end

feature {NONE}

	current_button: CON_CAT_BUTTON
			-- Current selected button
	
	rc: ROW_COLUMN
			-- Row-column containing the category buttons

	context_catalog_label: LABEL
			-- Label displaying "Context catalog"

feature 

	scrolled_w: SCROLLED_W
			-- Scrolled window in which pages are displayed
	window_page: WINDOW_PAGE
	primitive_page: PRIMITIVE_PAGE
	menu_page: MENU_PAGE
	group_page: GROUP_PAGE
	set_page: SET_PAGE
	scroll_page: SCROLL_PAGE

feature {CONTEXT_CAT_PAGE}

	first_separator: THREE_D_SEPARATOR

feature {NONE}

	attach_page (page: CONTEXT_CAT_PAGE) is
		do
			attach_top_widget (first_separator, page, 0)
			attach_left (page, 0)
			attach_right (page, 0)
			attach_bottom (page, 0)
		end

feature
	
	current_page: CONTEXT_CAT_PAGE

	update_page (bt: like current_button) is
		require
			valid_page: bt /= Void
			not_same: not same_as (bt)
		do
			if current_button /= Void then
				current_button.deselect
			end
			current_button := bt
			current_page := bt.catalog_page
			current_page.manage
			scrolled_w.set_working_area (current_page)
		ensure
			correct_page_shown: current_page.shown
			page_changed: current_page /= old (current_page)
		end

	same_as (bt: like current_button): BOOLEAN is
			-- Is `bt' same as current_button?
		do
			Result := current_button = bt
		end

feature 

	perm_wind_type: CONTEXT_TYPE is
		do
			Result := window_page.perm_wind_type
		end

	temp_wind_type: CONTEXT_TYPE is
		do
			Result := window_page.temp_wind_type
		end

	toggle_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.toggle_b_type
		end

	text_type: CONTEXT_TYPE is
		do
			Result := scroll_page.text_type
		end

	scrollable_list_type: CONTEXT_TYPE is
		do
			Result := scroll_page.scrollable_list_type
		end


	drawing_area_type: CONTEXT_TYPE is
		do
			Result := scroll_page.drawing_area_type
		end

	label_type: CONTEXT_TYPE is
		do
			Result := primitive_page.label_type
		end

	push_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.push_b_type
		end

	text_field_type: CONTEXT_TYPE is
		do
			Result := primitive_page.text_field_type
		end

	menu_entry_type: CONTEXT_TYPE is
		do
			Result := menu_page.menu_entry_type
		end

	submenu_type: CONTEXT_TYPE is
		do
			Result := menu_page.submenu_type
		end

	separator_type: CONTEXT_TYPE is
		do
			Result := primitive_page.separator_type
		end

	scale_type: CONTEXT_TYPE is
		do
			Result := primitive_page.scale_type
		end

	pict_color_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.pict_color_b_type
		end

	arrow_b_type: CONTEXT_TYPE is
		do
			Result := primitive_page.arrow_b_type
		end

	bar_type: CONTEXT_TYPE is
		do
			Result := menu_page.bar_type
		end

	option_btn_type: CONTEXT_TYPE is
		do
			Result := menu_page.option_btn_type
		end

	bulletin_type: CONTEXT_TYPE is
		do
			Result := set_page.bulletin_type
		end

	radio_box_type: CONTEXT_TYPE is
		do
			Result := set_page.radio_box_type
		end

	check_box_type: CONTEXT_TYPE is
		do
			Result := set_page.check_box_type
		end

feature -- Group management

	context_group_types: LINKED_LIST [CONTEXT_GROUP_TYPE] is
		once
			!! Result.make
		end

	add_new_group (a_group: GROUP) is
		local
			a_context_type: CONTEXT_GROUP_TYPE
			group_c: GROUP_C
		do
			!! group_c
			group_c.set_type (a_group)
			!! a_context_type.make (a_group.entity_name, group_c)
			add_group_type (a_context_type)
		ensure
			consistent: context_group_types.count = shared_group_list.count
		end

	has_group_name (group_name: STRING): BOOLEAN is
			-- Does `group_name' exists?
		require
			valid_group_name: group_name /= Void
		local
			a_name, e_name: STRING
		do
			a_name := clone (group_name)
			a_name.to_upper
			from
				Shared_group_list.start
			until
				Shared_group_list.after or Result
			loop
				e_name := Shared_group_list.item.entity_name
				Result :=  a_name.is_equal (e_name)
				Shared_group_list.forth
			end
		end

	update_groups is
		local
			a_context_type: CONTEXT_GROUP_TYPE
			group_c: GROUP_C
			a_group: GROUP
		do
			group_page.icon_box.unmanage
			group_page.icon_box.wipe_out
			from
				Shared_group_list.start
				Context_group_types.wipe_out
			until
				Shared_group_list.after
			loop
				a_group := Shared_group_list.item
				!! group_c
				group_c.set_type (a_group)
				!! a_context_type.make (a_group.entity_name, group_c)
				append_group_type (a_context_type)
				Shared_group_list.forth
			end
			group_page.icon_box.manage
		ensure
			consistent: context_group_types.count = shared_group_list.count
		end

	add_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
		do
			append_group_type (a_context_type)
			Shared_group_list.extend (a_context_type.group)
		ensure
			consistent: context_group_types.count = shared_group_list.count
		end

	remove_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
		do
			Shared_group_list.start
			Shared_group_list.search (a_context_type.group)
			Shared_group_list.remove
			context_group_types.start
			from 
				context_group_types.start
			until
				context_group_types.after or 
				else (context_group_types.item.group 
						= a_context_type.group)
			loop
				context_group_types.forth
			end
			context_group_types.remove
			update_groups
		ensure
			consistent: context_group_types.count = shared_group_list.count
		end

feature {NONE}

	append_group_type (a_context_group: CONTEXT_GROUP_TYPE) is
		do
			context_group_types.finish
			context_group_types.put_right (a_context_group)
			group_page.icon_box.extend (a_context_group)
		end

feature -- Context_editor list

	update_state_name_in_behavior_page (state: BUILD_STATE) is
			-- Update the state name in behavior page
			-- that displays `state'.
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
			an_editor: CONTEXT_EDITOR
		do
			editor_list := window_mgr.context_editors
			from
				editor_list.start
			until
				editor_list.after
			loop
				an_editor := editor_list.item
				an_editor.update_state_name_in_behavior_page (state)
				editor_list.forth
			end
		end

	update_name_in_editors (a_context: CONTEXT) is
			-- Update the icon name of `a_context' that
			-- is being edited.
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
			an_editor: CONTEXT_EDITOR
		do
			editor_list := window_mgr.context_editors
			from
				editor_list.start
			until
				editor_list.after
			loop
				an_editor := editor_list.item
				if an_editor.edited_context = a_context then
					an_editor.update_title
				end
				editor_list.forth
			end
		end

	editor (a_context: CONTEXT a_form_number: INTEGER): CONTEXT_EDITOR is
			-- Editor for `a_context' with current
			-- option `a_form_number'. (Void if this
			-- does not exists).
		local
			ed: CONTEXT_EDITOR
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
		do
			editor_list := window_mgr.context_editors
			editor_list.extend (main_panel.context_editor)
			from
				editor_list.start
			until
				editor_list.after or else
				(Result /= Void)
			loop
				ed := editor_list.item
				if
					((ed.edited_context = a_context) and then
					(ed.current_form_number = a_form_number))
				--! Only one option form open per context
				then
					Result := ed
				end
				editor_list.forth
			end
		end

	update_editors (a_context: CONTEXT a_form_number: INTEGER) is
			-- Update editor for `a_context' with current
			-- option `a_form_number'. (Do nothing if
			-- does not exists).
		local
			other_editor: CONTEXT_EDITOR
		do
			other_editor := editor (a_context, a_form_number)
			if other_editor /= Void then
				other_editor.reset_current_form
			end
		end

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
				Shared_window_list.item.hide
				Shared_window_list.forth
			end
			from
				Shared_window_list.start
			until	
				Shared_window_list.after
			loop
				cont ?= Shared_window_list.item
				if cont /= Void then
					cont.widget.destroy
				end
				Shared_window_list.forth
			end
			Shared_window_list.wipe_out
			tree.wipe_out
			tree.clear
			group_page.clear	
			Shared_translation_list.wipe_out
			Shared_group_list.wipe_out
			update_translation_page
			perm_wind_type.reset
			temp_wind_type.reset
			toggle_b_type.reset
			text_type.reset
			label_type.reset
			push_b_type.reset
			text_field_type.reset
			menu_entry_type.reset
			submenu_type.reset
			separator_type.reset
			scale_type.reset
			pict_color_b_type.reset
			arrow_b_type.reset
			bar_type.reset
			option_btn_type.reset
			bulletin_type.reset
			radio_box_type.reset
			check_box_type.reset
			scrollable_list_type.reset
			drawing_area_type.reset
		end

	update_translation_page is
			-- Display all the translations in the event
			-- catalog. 
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
			beh_form: BEHAVIOR_FORM
		do
			editor_list := window_mgr.context_editors
			from
				editor_list.start
			until
				editor_list.after 
			loop
				if editor_list.item.behavior_form_shown then
					editor_list.item.update_translation_page
				end
				editor_list.forth
			end
		end

	clear_editors (a_context: CONTEXT) is
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
		do
			editor_list := window_mgr.context_editors
			from
				editor_list.start
			until
				editor_list.after
			loop
				if editor_list.item.edited_context = a_context then
					editor_list.item.clear
				end
				editor_list.forth
			end
		end

	realize is
			-- Realize the context catalog. Is called in 
			-- `MAIN_PANEL.realize'. We need to do `show' before
			-- `hide' on Windows plarforms for
 			-- every pages to avoid seing all the widgets of
			-- every pages being redrawn when resizing the
			-- main panel or the split window.			
		do	
			Precursor
			window_page.show
			window_page.hide
			primitive_page.show
			primitive_page.hide
			menu_page.show
			menu_page.hide
			group_page.show
			group_page.hide
			set_page.show
			set_page.hide
			scroll_page.show
			scroll_page.hide
			window_page.show
		end

feature -- CLOSEABLE (useless so far)

	close is
		do
		end

end -- class CONTEXT_CATALOG

