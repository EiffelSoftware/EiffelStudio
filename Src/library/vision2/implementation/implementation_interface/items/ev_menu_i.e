indexing
	description: "Eiffel Vision menu. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_I
	
inherit
	EV_MENU_ITEM_I
		redefine
			interface,
			parent
		end

	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

feature -- Access

	parent: EV_MENU_ITEM_LIST is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			end
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		deferred
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		deferred
		end
		
feature {EV_MENU} -- Contract support

	one_radio_item_selected_per_separator: BOOLEAN is
			-- Is there at most one selected radio item between
			-- consecutive separators?
		local
			separator: EV_MENU_SEPARATOR
			checked_radio_items: INTEGER
			radio_item: EV_RADIO_MENU_ITEM
			a_cursor: CURSOR
		do
			a_cursor := interface.cursor
			Result := True
			from
				interface.start
			until
				interface.off or not Result
			loop
				separator ?= item
				if separator /= Void then
					checked_radio_items := 0
				end
				radio_item ?= item
				if radio_item /= Void and then radio_item.is_selected then
					checked_radio_items := checked_radio_items + 1
					if checked_radio_items > 1 then
						Result := False
					end
				end
				interface.forth
			end
			interface.go_to (a_cursor)
		ensure
			index_not_changed: index = old index
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU	

end -- class EV_MENU_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

