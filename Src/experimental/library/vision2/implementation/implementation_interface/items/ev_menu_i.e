note
	description: "Eiffel Vision menu. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	parent: detachable EV_MENU_ITEM_LIST
			-- Item list containing `Current'.
		do
			if attached parent_imp as l_parent_imp then
				Result ?= l_parent_imp.interface
			end
		end

feature -- Basic operations

	show
			-- Pop up on the current pointer position.
		deferred
		end

	show_at (a_widget: detachable EV_WIDGET; a_x, a_y: INTEGER)
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		deferred
		end

feature {EV_MENU} -- Contract support

	one_radio_item_selected_per_separator: BOOLEAN
			-- Is there at most one selected radio item between
			-- consecutive separators?
		local
			separator: detachable EV_MENU_SEPARATOR
			checked_radio_items: INTEGER
			radio_item: detachable EV_RADIO_MENU_ITEM
			a_cursor: CURSOR
		do
			a_cursor := cursor
			Result := True
			from
				start
			until
				index = count + 1 or not Result
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
				forth
			end
			go_to (a_cursor)
		ensure
			index_not_changed: index = old index
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_MENU note option: stable attribute end;

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




end -- class EV_MENU_I











