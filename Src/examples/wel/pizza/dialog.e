note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok,
			setup_dialog,
			notify
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW)
		do
			make_by_id (a_parent, Id_dialog_pizza)
			create size.make_by_id (Current, Id_size)
			create listbox_items.make_by_id (Current, Id_listbox_items)
			create radio_thin.make_by_id (Current, Id_rad_thin)
			create radio_thick.make_by_id (Current, Id_rad_thick)
			create radio_stuff.make_by_id (Current, Id_rad_stuff)
			create radio_for_here.make_by_id (Current, Id_rad_for_here)
			create radio_to_go.make_by_id (Current, Id_rad_to_go)
			create static_price.make_by_id (Current, Id_static_price)
		end

	setup_dialog
		local
			l_static_price: like static_price
			l_size: like size
			l_radio_thin: like radio_thin
			l_radio_for_here: like radio_for_here
			l_listbox_items: like listbox_items
		do
			l_static_price := static_price
			l_size := size
			l_radio_thin := radio_thin
			l_radio_for_here := radio_for_here
			l_listbox_items := listbox_items
				-- Per invariant
			check
				l_static_price_attached: l_static_price /= Void
				l_size_attached: l_size /= Void
				l_radio_thin_attached: l_radio_thin /= Void
				l_radio_for_here_attached: l_radio_for_here /= Void
				l_listbox_items_attached: l_listbox_items /= Void
			end
			l_static_price.set_text ("$0")
			l_listbox_items.add_string ("Bacon")
			l_listbox_items.add_string ("Pork")
			l_listbox_items.add_string ("Beef")
			l_listbox_items.add_string ("Salami")
			l_listbox_items.add_string ("Sausage")
			l_listbox_items.add_string ("Pepperoni")
			l_listbox_items.add_string ("Olive")
			l_listbox_items.add_string ("Green olive")
			l_listbox_items.add_string ("Onions")
			l_listbox_items.add_string ("Pineapple")
			l_listbox_items.add_string ("Mushroom")
			l_listbox_items.add_string ("Red pepper")
			l_listbox_items.add_string ("Green pepper")
			l_listbox_items.add_string ("Meat ball")
			l_listbox_items.add_string ("Fresh tomato")
			l_listbox_items.add_string ("Cheese")
			l_listbox_items.add_string ("Ham")
			l_listbox_items.add_string ("Chorizo")
			l_listbox_items.add_string ("Canadian bacon")

			l_size.add_string ("Small")
			l_size.add_string ("Medium")
			l_size.add_string ("Large")
			l_size.select_item (0)

			l_radio_thin.set_checked
			l_radio_for_here.set_checked
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER)
		do
			if control = listbox_items and then attached listbox_items as l_listbox_items then
				items_selected := l_listbox_items.count_selected_items
			elseif control = size then
				if attached size as l_size and then l_size.selected then
					inspect
						l_size.selected_item
					when 0 then
						size_price := 0
					when 1 then
						size_price := 1
					when 2 then
						size_price := 2
					end
				end
			end
			update_price
		end

feature {NONE} -- Implementation

	update_price
		local
			price: REAL
			l_static_price: like static_price
			l_radio_stuff: like radio_stuff
		do
			l_static_price := static_price
			l_radio_stuff := radio_stuff
				-- Per invariant
			check
				l_static_price_attached: l_static_price /= Void
				l_radio_stuff_attached: l_radio_stuff /= Void
			end

			text_info.wipe_out
			text_info.extend ('$')
			price := 1.5 + items_selected * 0.5 + size_price
			if l_radio_stuff.checked then
				price := price + 1
			end
			text_info.append_real (price)
			if text_info.has ('.') then
				text_info.extend ('0')
			else
				text_info.append (".00")
			end
			l_static_price.set_text (text_info)
		end

feature

	on_ok
		local
			i: INTEGER
			sel_string: ARRAY [STRING_32]
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			text_info.append ("You ordered a Pizza with ")
			if
				attached listbox_items as l_listbox_items and then
				l_listbox_items.count_selected_items > 0
			then
				text_info.append_integer (items_selected)
				if items_selected > 1 then
					text_info.append (" toppings.%N%N")
					text_info.append ("These toppings are:%N%N")
				else
					text_info.append (" topping.%N%N")
					text_info.append ("This topping is:%N%N")
				end
				sel_string := l_listbox_items.selected_strings
				from
					i := sel_string.lower
				until
					i = sel_string.count
				loop
					text_info.append (sel_string.item (i))
					text_info.append ("%N")
					i := i + 1
				end
			else
				text_info.append ("no toppings.%N")
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Pizza Order")
			terminate (Idok)
		end

	text_info: STRING
		once
			create Result.make (200)
		ensure
			result_not_void: Result /= Void
		end

feature -- Access

	items_selected: INTEGER

	size_price: INTEGER

	size: detachable WEL_DROP_DOWN_LIST_COMBO_BOX

	listbox_items: detachable WEL_MULTIPLE_SELECTION_LIST_BOX

	radio_thin, radio_thick, radio_stuff,
	radio_for_here, radio_to_go: detachable WEL_RADIO_BUTTON

	static_price: detachable WEL_STATIC;

invariant
	static_price_attached: static_price /= Void
	size_attached: size /= Void
	radio_thin_attached: radio_thin /= Void
	radio_for_here_attached: radio_for_here /= Void
	radio_stuff_attached: radio_stuff /= Void
	listbox_items_attached: listbox_items /= Void

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

end
