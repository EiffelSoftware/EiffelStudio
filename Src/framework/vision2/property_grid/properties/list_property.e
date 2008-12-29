note
	description: "Property for an ordered list of strings."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_PROPERTY

inherit
	DIALOG_PROPERTY [LIST [STRING_32]]
		redefine
			displayed_value,
			dialog
		end

create
	make,
	make_with_dialog

feature -- Access

	displayed_value: STRING_32
			-- Convert `data' into a text representation.
		do
			if value /= Void then
				create Result.make_empty
				from
					value.start
				until
					value.after
				loop
					Result.append (value.item.out+";")
					value.forth
				end
				if Result.count > 0 then
					Result.remove_tail (1)
				end
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Implementation

	dialog: LIST_DIALOG
			-- Dialog to change values

end
