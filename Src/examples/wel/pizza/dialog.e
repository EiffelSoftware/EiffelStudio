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

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
		do
			make_by_id (a_parent, Id_dialog_pizza)
			create size.make_by_id (Current,
				Id_size)
			create listbox_items.make_by_id (Current,
				Id_listbox_items)
			create radio_thin.make_by_id (Current,
				Id_rad_thin)
			create radio_thick.make_by_id (Current,
				Id_rad_thick)
			create radio_stuff.make_by_id (Current,
				Id_rad_stuff)
			create radio_for_here.make_by_id (Current,
				Id_rad_for_here)
			create radio_to_go.make_by_id (Current,
				Id_rad_to_go)
			create static_price.make_by_id (Current,
				Id_static_price)
		end

	setup_dialog is
		do
			static_price.set_text ("$0")
			listbox_items.add_string ("Bacon")
			listbox_items.add_string ("Pork")
			listbox_items.add_string ("Beef")
			listbox_items.add_string ("Salami")
			listbox_items.add_string ("Sausage")
			listbox_items.add_string ("Pepperoni")
			listbox_items.add_string ("Olive")
			listbox_items.add_string ("Green olive")
			listbox_items.add_string ("Onions")
			listbox_items.add_string ("Pineapple")
			listbox_items.add_string ("Mushroom")
			listbox_items.add_string ("Red pepper")
			listbox_items.add_string ("Green pepper")
			listbox_items.add_string ("Meat ball")
			listbox_items.add_string ("Fresh tomato")
			listbox_items.add_string ("Cheese")
			listbox_items.add_string ("Ham")
			listbox_items.add_string ("Chorizo")
			listbox_items.add_string ("Canadian bacon")

			size.add_string ("Small")
			size.add_string ("Medium")
			size.add_string ("Large")
			size.select_item (0)

			radio_thin.set_checked
			radio_for_here.set_checked
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
		do
			if control = listbox_items then
				items_selected := listbox_items.count_selected_items
			elseif control = size then
				if size.selected then
					inspect
						size.selected_item
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

	update_price is
		local
			price: REAL
		do
			text_info.wipe_out
			text_info.extend ('$')
			price := 1.5 + items_selected * 0.5 + size_price
			if radio_stuff.checked then
				price := price + 1
			end
			text_info.append_real (price)
			if text_info.has ('.') then
				text_info.extend ('0')
			else
				text_info.append (".00")
			end
			static_price.set_text (text_info)
		end

feature

	on_ok is
		local
			i: INTEGER
			sel_string: ARRAY [STRING]
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			text_info.append ("You ordered a Pizza with ")
			if listbox_items.count_selected_items > 0 then
				text_info.append_integer (items_selected)
				if items_selected > 1 then
					text_info.append (" toppings.%N%N")
					text_info.append ("These toppings are:%N%N")
				else
					text_info.append (" topping.%N%N")
					text_info.append ("This topping is:%N%N")
				end
				sel_string := listbox_items.selected_strings
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

	text_info: STRING is
		once
			create Result.make (200)
		ensure
			result_not_void: Result /= Void
		end

feature -- Access

	items_selected: INTEGER

	size_price: INTEGER

	size: WEL_DROP_DOWN_LIST_COMBO_BOX

	listbox_items: WEL_MULTIPLE_SELECTION_LIST_BOX

	radio_thin, radio_thick, radio_stuff,
	radio_for_here, radio_to_go: WEL_RADIO_BUTTON

	static_price: WEL_STATIC

end -- class DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

