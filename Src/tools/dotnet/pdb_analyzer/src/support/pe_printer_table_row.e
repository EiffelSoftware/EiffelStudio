note
	description: "Summary description for {PE_PRINTER_TABLE_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PRINTER_TABLE_ROW

create
	make

feature -- Initialization	

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	items: ARRAYED_LIST [READABLE_STRING_GENERAL]

	item alias "[]" (i: INTEGER): READABLE_STRING_GENERAL assign set_item
		do
			if items.valid_index (i) then
				Result := items.i_th (i)
			else
				Result := ""
			end
		end

	set_item (v: READABLE_STRING_GENERAL; i: INTEGER)
		do
			items.put_i_th (v, i)
		end

feature -- Element change

	put_string (s: READABLE_STRING_GENERAL)
		do
			items.force (s)
		end

	put_string_array (arr: ITERABLE [READABLE_STRING_GENERAL])
		do
			across
				arr as ic
			loop
				put_string (ic.item)
			end
		end

end
