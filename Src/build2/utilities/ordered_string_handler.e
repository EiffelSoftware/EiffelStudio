indexing
	description: "Objects that allow a certain number of events represented as%
		%STRINGS in an EV_LIST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDERED_STRING_HANDLER

create
	make_with_textable
	
feature {NONE} -- Initialization

	make_with_textable (a_text: EV_TEXT) is
			-- Create current with `a_text' assigned
			-- to `text'.
		do
			text := a_text
			create items.make (10)
			items.start
		end

feature -- Status setting

	record_string (new_string: STRING) is
			-- Add `new_string' to strings held by
			-- `Current'. If new_string does not end in "%N"
			-- then append "%N"
		require
			new_string_not_void: new_string /= Void
		do
			if new_string.item (new_string.count) /= '%N' then
				new_string.append_character ('%N')
			end
			text.append_text (new_string)
			update_internal_record (new_string)
		end

feature {NONE} -- Implementation

	update_internal_record (new_string: STRING) is
			--
		local
			string_to_remove: STRING
		do
			if not items.full then
				items.extend (new_string)
				io.putstring (items.count.out)
			else
				items.start
				items.forth
				items.set_start
				items.back
				string_to_remove := items.item
				text.set_text (text.text.substring (string_to_remove.count + 1, text.text.count))
				items.replace (new_string)
			end
		end
		

	items: ARRAYED_CIRCULAR [STRING]

	text: EV_TEXT

invariant
	items_not_void: items /= Void

end -- class ORDERED_STRING_HANDLER
