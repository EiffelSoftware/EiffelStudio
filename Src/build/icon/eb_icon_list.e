indexing
	description: "List of Icons."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ICON_LIST

inherit
	EV_MULTI_COLUMN_LIST
		redefine
			make,
			get_item,
			selected_item
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the list of icons.
		do
			make_with_size (par, 2)
			set_single_selection
		end

feature -- Access

	get_item (index: INTEGER): EB_ICON_LIST_ITEM [PND_DATA] is
			-- Give the item at the one-base `index'.
		do
			Result ?= Precursor (index)
		end

	selected_item: EB_ICON_LIST_ITEM [PND_DATA] is
			-- Item currently selected.
		do
			Result ?= Precursor
		end

	set (other: EB_LINKED_LIST [PND_DATA]) is
		local
			elmt: EB_ICON_LIST_ITEM [PND_DATA]
		do
			clear_items
			from
				other.start
			until
				other.after
			loop
				create elmt.make_with_text (Current, <<other.item.label>>)
--				elm.set_pixmap (other.item.symbol)
				elmt.set_data (other.item)
				other.forth
			end
		end

end -- class EB_ICON_LIST

