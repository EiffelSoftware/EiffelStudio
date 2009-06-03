note
	description: "Eiffel Vision menu item list. Carbon implementation."

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

	EV_ANY_IMP
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_IMP

	MENUS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; pos: INTEGER)
			-- Insert the item v in the current menu
		local
			menu_item: EV_MENU_ITEM_IMP
		do
			menu_item ?= v.implementation
			insert_menu_item(menu_item, pos)
		end

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Generic menu item insertion.
		local
			ptr: POINTER
			ret: INTEGER
			parent_item: EV_MENU_ITEM_IMP
			seq_imp: EV_MENU_SEPARATOR_IMP
			shortcut_key: INTEGER
			i: INTEGER
			text: STRING
			cfstring: EV_CARBON_CF_STRING
		do
			an_item_imp.set_item_parent_imp (Current)
			ptr := an_item_imp.c_object
			parent_item ?= current

			seq_imp ?= an_item_imp
			if seq_imp /= Void then
				-- EV_MENU_SEPARATOR_ITEM
				create cfstring.make_unshared_with_eiffel_string ("")
				ret := insert_menu_item_text_with_cfstring_external (parent_item.c_object, cfstring.item, pos + 1, {MENUS_ANON_ENUMS}.kMenuItemAttrSeparator , an_item_imp.event_id)
				--    kMenuItemAttrSeparator = (1 << 6)
			else
				-- EV_MENU_ITEM
				text := an_item_imp.text
				i := text.substring_index ("&", 1)
				if i /= 0 then
					text := text.substring (1, i - 1) + text.substring (i + 1, text.count)
					shortcut_key := an_item_imp.text.code (i + 1).as_integer_32
				end
				create cfstring.make_unshared_with_eiffel_string (text)
				ret := insert_menu_item_text_with_cfstring_external (parent_item.c_object, cfstring.item, pos + 1, 0, an_item_imp.event_id)
				-- Note: Menu indices start at 1 in Carbon
				ret := set_menu_item_command_id_external (parent_item.c_object, pos + 1, an_item_imp.event_id)
				--print ("insert " + an_item_imp.id.out + " under " + id.out + " with text: " + an_item_imp.text + "%N")
				if i /= 0 then
					ret := set_menu_item_command_key_external (parent_item.c_object, pos, 0, shortcut_key)
					--print ("err: " + ret.out + ", pos: " + pos.out + "%N")
				end
			end
			child_array.go_i_th (pos)
			child_array.put_left (an_item_imp.interface)
		end

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP
			-- Separator before item `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= interface.count
		do
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
		do
			item_imp ?= child_array.i_th (a_position).implementation
			check
				item_imp_not_void: item_imp /= Void
			end
			--{EV_GTK_EXTERNALS}.gtk_container_remove (list_widget, item_imp.c_object)
			child_array.go_i_th (a_position)
			child_array.remove
			item_imp.set_item_parent_imp (Void)

		end

feature -- Implementation

	child_selected (a_id: INTEGER)
			--
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i > count
			loop
				--print(i_th(i).implementation.id) --.select_actions.call ()
				i := i + 1
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_MENU_ITEM_LIST_IMP

