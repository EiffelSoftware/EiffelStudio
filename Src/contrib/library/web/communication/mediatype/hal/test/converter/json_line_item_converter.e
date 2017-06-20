note
	description: "Summary description for {JSON_LINE_ITEM_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_LINE_ITEM_CONVERTER

inherit
	JSON_SERIALIZER
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable LINE_ITEM
		local
			ll: LINKED_LIST [ITEM]
			i: INTEGER
		do
			if
				attached {JSON_OBJECT} a_json as j and then
				attached {JSON_STRING} j.item (name_key) as ucs
			then
				if attached {JSON_ARRAY} j.item (items_key) as ja then
					create Result.make (ucs.unescaped_string_32)
					from
						i := 1
						create ll.make
					until
						i > ja.count
					loop
						if attached {ITEM} ctx.value_from_json (ja[i], {ITEM}) as b then
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

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
			ja: JSON_ARRAY
		do
			if attached {LINE_ITEM} obj as o then
				create jo.make
				jo.put_string (o.name, name_key)
				create ja.make_empty
				across
					o.items as ic
				loop
					if attached ctx.to_json (ic.item, Void) as ji then
						ja.add (ji)
					end
				end
				jo.put (ja, items_key)
				Result := jo
			else
				create {JSON_NULL} Result
			end
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
