indexing
	description: "[
		Objects that allow multiple strings to be displayed
		in an EV_LIST.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDERED_STRING_HANDLER

create
	make_with_textable
	
feature {NONE} -- Initialization

	make_with_textable (a_list: EV_LIST) is
			-- Create current with `a_text' assigned
			-- to `text'.
		do
			internal_list := a_list
		end

feature -- Status setting

	record_string (new_string: STRING) is
			-- Add `new_string' to strings held by
			-- `Current'. If new_string does not end in "%N"
			-- then append "%N"
		require
			new_string_not_void: new_string /= Void
		local
			list_item: EV_LIST_ITEM
		do
			new_string.prune_all ('%N')
			create list_item.make_with_text ("<" + (internal_list.count + 1).out + "> " + new_string)
			internal_list.extend (list_item)
			internal_list.ensure_item_visible (internal_list.i_th (internal_list.count))
		ensure
			internal_count_increased: internal_list.count = old internal_list.count + 1
		end
		
	reset is
			-- Reset `Current'.
		do
			internal_list.wipe_out
		ensure
			internal_list.is_empty
		end
		

feature {NONE} -- Implementation

	internal_list: EV_LIST

invariant
	internal_list_not_void: internal_list /= Void

end -- class ORDERED_STRING_HANDLER
