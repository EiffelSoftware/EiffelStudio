indexing
	description: "Widget representing the context catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 

	CONTEXT_CATALOG 

inherit
	EV_NOTEBOOK
		redefine
			make
		end

	CONSTANTS

	WINDOWS

	SHARED_CONTEXT

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is 
		do
			{EV_NOTEBOOK} Precursor (par)
			create container_page.make (Current)
			create menu_page.make (Current)
			create toolbar_page.make (Current)
			create primitive_page.make (Current)
			create text_page.make (Current)
			create group_page.make (Current)
			set_values
		end

	set_values is
		do
			set_minimum_height (65)
			set_expand (False)
		end

feature 

	container_page: CONTAINER_PAGE
	toolbar_page: TOOLBAR_PAGE
	primitive_page: PRIMITIVE_PAGE
	text_page: TEXT_PAGE
	menu_page: MENU_PAGE
	group_page: GROUP_PAGE

feature -- Group management

--	context_group_types: LINKED_LIST [CONTEXT_GROUP_TYPE] is
--		once
--			!! Result.make
--		end

--	add_new_group (a_group: GROUP) is
--		local
--			a_context_type: CONTEXT_GROUP_TYPE
--			group_c: GROUP_C
--		do
--			!! group_c
--			group_c.set_type (a_group)
--			!! a_context_type.make (a_group.entity_name, group_c)
--			add_group_type (a_context_type)
--		ensure
--			consistent: context_group_types.count = shared_group_list.count
--		end

--	has_group_name (group_name: STRING): BOOLEAN is
--			-- Does `group_name' exists?
--		require
--			valid_group_name: group_name /= Void
--		local
--			a_name, e_name: STRING
--		do
--			a_name := clone (group_name)
--			a_name.to_upper
--			from
--				Shared_group_list.start
--			until
--				Shared_group_list.after or Result
--			loop
--				e_name := Shared_group_list.item.entity_name
--				Result :=  a_name.is_equal (e_name)
--				Shared_group_list.forth
--			end
--		end

--	update_groups is
--		local
--			a_context_type: CONTEXT_GROUP_TYPE
--			group_c: GROUP_C
--			a_group: GROUP
--		do
--			group_page.icon_box.unmanage
--			group_page.icon_box.wipe_out
--			from
--				Shared_group_list.start
--				Context_group_types.wipe_out
--			until
--				Shared_group_list.after
--			loop
--				a_group := Shared_group_list.item
--				!! group_c
--				group_c.set_type (a_group)
--				!! a_context_type.make (a_group.entity_name, group_c)
--				append_group_type (a_context_type)
--				Shared_group_list.forth
--			end
--			group_page.icon_box.manage
--		ensure
--			consistent: context_group_types.count = shared_group_list.count
--		end

--	add_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
--		do
--			append_group_type (a_context_type)
--			Shared_group_list.extend (a_context_type.group)
--		ensure
--			consistent: context_group_types.count = shared_group_list.count
--		end

--	remove_group_type (a_context_type: CONTEXT_GROUP_TYPE) is
--		do
--			Shared_group_list.start
--			Shared_group_list.search (a_context_type.group)
--			Shared_group_list.remove
--			context_group_types.start
--			from 
--				context_group_types.start
--			until
--				context_group_types.after or 
--				else (context_group_types.item.group 
--						= a_context_type.group)
--			loop
--				context_group_types.forth
--			end
--			context_group_types.remove
--			update_groups
--		ensure
--			consistent: context_group_types.count = shared_group_list.count
--		end

feature {NONE}

--	append_group_type (a_context_group: CONTEXT_GROUP_TYPE) is
--		do
--			context_group_types.finish
--			context_group_types.put_right (a_context_group)
--			group_page.icon_box.extend (a_context_group)
--		end

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

	editor (ctxt: CONTEXT): CONTEXT_EDITOR is
			-- Editor for `ctxt'
			-- (Void if this does not exists).
		local
			editor_list: LINKED_LIST [CONTEXT_EDITOR]
			ed: CONTEXT_EDITOR
		do
			editor_list := window_mgr.context_editors
			editor_list.extend (main_window.context_editor)
			from
				editor_list.start
			until
				editor_list.after or else Result /= Void
			loop
				ed := editor_list.item
				if ed.edited_context = ctxt then
					Result := ed
				end
				editor_list.forth
			end
		end

	update_editors (ctxt: CONTEXT; form_nb: INTEGER) is
			-- Update editor for `ctxt' with current
			-- option `form_nb'.
			-- (Do nothing if does not exists).
		local
			other_editor: CONTEXT_EDITOR
		do
			other_editor := editor (ctxt)
			if other_editor /= Void then
				other_editor.reset_form (form_nb)
			end
		end

	clear is
			-- Clear the group page (of Current).
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
					cont.gui_object.destroy
				end
				Shared_window_list.forth
			end
			Shared_window_list.wipe_out
--			main_window.context_tree.clear
			group_page.clear	
--			Shared_group_list.wipe_out
			container_page.perm_wind_type.reset
			container_page.temp_wind_type.reset
--			toggle_b_type.reset
--			text_type.reset
--			label_type.reset
--			push_b_type.reset
--			text_field_type.reset
--			menu_entry_type.reset
--			submenu_type.reset
--			separator_type.reset
--			scale_type.reset
--			pict_color_b_type.reset
--			arrow_b_type.reset
--			bar_type.reset
--			option_btn_type.reset
--			bulletin_type.reset
--			radio_box_type.reset
--			check_box_type.reset
--			scrollable_list_type.reset
--			drawing_area_type.reset
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

end -- class CONTEXT_CATALOG

