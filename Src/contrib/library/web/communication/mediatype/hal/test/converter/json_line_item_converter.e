note
	description: "Summary description for {JSON_LINE_ITEM_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_LINE_ITEM_CONVERTER

inherit
	JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make ("")
		end

feature -- Access

	object: LINE_ITEM

feature -- Conversion

	from_json (j: like to_json): detachable like object
		local
			ll: LINKED_LIST [ITEM]
			i: INTEGER
		do
			if attached {STRING_32} json.object (j.item (name_key), Void) as ucs then
				if attached {JSON_ARRAY} j.item (items_key) as ja then
					create Result.make (ucs)
					from
						i := 1
						create ll.make
					until
						i > ja.count
					loop
						if attached {ITEM} json.object (ja [i], "ITEM") as b then
							ll.force (b)
						end
						i := i + 1
					end
					Result.add_items (ll)
				else
					check
						has_array_items: False
					end
				end
			else
				check
					has_name_key: False
				end
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
				--Result.put (json.value (o.name), name_key)
			Result.put (json.value (o.items), items_key)
		end

feature {NONE} -- Implementation

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	items_key: JSON_STRING
		once
			create Result.make_from_string ("items")
		end

end -- class JSON_LINE_ITEM_CONVERTER
