indexing
	description: "Item of an icon list."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ICON_LIST_ITEM [T -> PND_DATA]

inherit
	EV_MULTI_COLUMN_LIST_ROW
			rename
				set_parent as add_to
			redefine
				make, make_with_text,
				transported_data
			end

	REMOVABLE

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EB_ICON_LIST) is
			-- Create an icon without text.
		do
			Precursor (par)
--XX		create icon.make_from_file (Current, symbol_file)
		end

	make_with_text (par: EB_ICON_LIST; txt: ARRAY [STRING]) is
			-- Create an icon with the given `txt'.
		do
			Precursor (par, txt)
--XX		create icon.make_from_file (Current, symbol_file)
		end

feature -- Status report

	transported_data: T

feature -- Basic action

	remove_yourself is
			-- remove the item from the list.
		do
			destroy
		end

end -- class EB_ICON_LIST_ITEM

