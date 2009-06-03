note
	description: "Eiffel Vision menu item list. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_LIST_IMP

inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]
		redefine
			insert_i_th,
			interface,
			remove_i_th
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {EV_MENU_ITEM_IMP} -- implementation

	list_widget: POINTER
			-- GtkMenuItem container for `Current'.
		do
			Result := c_object
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; pos: INTEGER)
		local
			an_item_imp: EV_MENU_ITEM_IMP
			an_index: INTEGER
			sep_imp: EV_MENU_SEPARATOR_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			chk_imp: EV_CHECK_MENU_ITEM_IMP
			radio_item_pointer, l_null: POINTER
		do
			an_item_imp ?= v.implementation
			an_index := index
			insert_menu_item (an_item_imp, pos)
			sep_imp ?= an_item_imp
			if sep_imp /= Void then
				check
					sep_imp_radio_group_void: sep_imp.radio_group = default_pointer
				end
				from
					go_i_th (pos + 1)
				until
					(index = count + 1) or else is_menu_separator_imp (i_th (index).implementation)
				loop
					radio_imp ?= i_th (index)
					if radio_imp /= Void then
						radio_imp.set_radio_group (sep_imp.radio_group)
						if sep_imp.radio_group /= l_null then
							{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (radio_imp.c_object, False)
						end
						sep_imp.set_radio_group (radio_imp.radio_group)
					end
					forth
				end
			else
				radio_imp ?= an_item_imp
				if radio_imp /= Void then
					sep_imp := separator_imp_by_index (pos)
					if sep_imp /= Void then
						radio_imp.set_radio_group (sep_imp.radio_group)
						if sep_imp.radio_group /= default_pointer then
							{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (radio_imp.c_object, False)
						end
						sep_imp.set_radio_group (radio_imp.radio_group)
					else
						radio_imp.set_radio_group (radio_group)
						radio_item_pointer := radio_imp.radio_group
						if radio_group /= default_pointer then
							{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (radio_imp.c_object, False)
						end
						set_radio_group (radio_imp.radio_group)
					end
				end
			end

			if not is_menu_separator_imp (an_item_imp) then
				--if not menu_item_imp.is_sensitive then
				--	menu_item_imp.disable_sensitive
				--end
				chk_imp ?= an_item_imp
				if chk_imp /= Void then
					if chk_imp.is_selected then
						chk_imp.enable_select
					end
				end
			end
			interface.go_i_th (an_index)
		end

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Generic menu item insertion.
		do
			{EV_GTK_EXTERNALS}.gtk_menu_shell_insert (list_widget, an_item_imp.menu_item, pos - 1)
			child_array.go_i_th (pos)
			child_array.put_left (an_item_imp.interface)
			an_item_imp.set_item_parent_imp (Current)
		end

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP
			-- Separator before item `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= interface.count
		local
			cur: CURSOR
			cur_item: INTEGER
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			cur := cursor
			from
				start
				cur_item := 1
			until
				(index = count + 1) or else an_index = cur_item
			loop
				sep_imp ?= i_th (index).implementation
				if sep_imp /= Void then
					Result := sep_imp
				end
				forth
				cur_item := cur_item + 1
			end
			go_to (cur)
		end

	is_menu_separator_imp (an_item_imp: EV_ITEM_I): BOOLEAN
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			sep_imp ?= an_item_imp
			Result := sep_imp /= Void
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item at `a_position'
		local
			item_imp: EV_ITEM_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			sep_imp: EV_MENU_SEPARATOR_IMP
			an_index: INTEGER
			has_radio_item: BOOLEAN
			temp_item_pointer, l_null: POINTER
		do
			item_imp ?= child_array.i_th (a_position).implementation
			check
				item_imp_not_void: item_imp /= Void
			end
			{EV_GTK_EXTERNALS}.gtk_container_remove (list_widget, item_imp.c_object)
			child_array.go_i_th (a_position)
			child_array.remove
			item_imp.set_item_parent_imp (Void)

			radio_imp ?= item_imp
			if radio_imp /= Void then
				if radio_imp.is_selected then
					-- Select the first item in the radio group
					if {EV_GTK_EXTERNALS}.g_slist_length (radio_imp.radio_group) > 1 then
						temp_item_pointer := {EV_GTK_EXTERNALS}.g_slist_nth_data (radio_imp.radio_group, 0)
						if temp_item_pointer = radio_imp.c_object then
							temp_item_pointer := {EV_GTK_EXTERNALS}.g_slist_nth_data (radio_imp.radio_group, 1)
						end
						radio_imp ?= eif_object_from_c (temp_item_pointer)
						if radio_imp /= Void then
							radio_imp.enable_select
						end
					end
				end
				{EV_GTK_EXTERNALS}.gtk_radio_menu_item_set_group (radio_imp.c_object, l_null)
			else
				sep_imp ?= item_imp
				if sep_imp /= Void and then a_position <= interface.count then
						-- We merge subsequent radio menu items with previous ones.
					sep_imp := separator_imp_by_index (a_position)
					from
						an_index := interface.index
						interface.go_i_th (a_position)
					until
						interface.after or else is_menu_separator_imp (interface.item.implementation)
					loop
						radio_imp ?= interface.item.implementation
						if radio_imp /= Void then
							has_radio_item := True
							if sep_imp /= Void then
								radio_imp.set_radio_group (sep_imp.radio_group)
								sep_imp.set_radio_group (radio_imp.radio_group)
							else
								radio_imp.set_radio_group (radio_group)
								set_radio_group (radio_imp.radio_group)
							end
							radio_imp.disable_select
						end
						interface.forth
					end
					if not has_radio_item and then sep_imp = Void then
						set_radio_group (l_null)
					end
					interface.go_i_th (an_index)
				end
			end
		end

feature -- Access

	radio_group_ref: POINTER_REF
		do
			--| FIXME IEK Use opo syntax when available in compiler.
			--| Same applies to access of action sequences.
			if radio_group_ref_internal = Void then
				create radio_group_ref_internal
			end
			Result := radio_group_ref_internal
		end

	set_radio_group (p: POINTER)
			-- Assign `p' to `radio_group'.
		do
			radio_group_ref.set_item (p)
		end

	radio_group: POINTER
			-- GSList with all radio items of this container.
		do
			Result := radio_group_ref.item
		end

feature {NONE} -- Implementation

	radio_group_ref_internal: POINTER_REF

feature {EV_ANY_I} -- Implementation

	eif_object_from_c (a_c_object: POINTER): EV_ANY_IMP
		deferred
		end

	c_object: POINTER
		deferred
		end

	interface: EV_MENU_ITEM_LIST;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_ITEM_LIST_IMP

