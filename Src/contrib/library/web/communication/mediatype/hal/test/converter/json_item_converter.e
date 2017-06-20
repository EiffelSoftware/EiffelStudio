note
	description: "Summary description for {JSON_ITEM_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ITEM_CONVERTER

inherit
	JSON_SERIALIZER
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ITEM
        local
            l_quantity : NATURAL
            l_price : REAL
        do
        	if attached {JSON_OBJECT} a_json as j then
	            if attached {JSON_STRING} j.item (id_key) as l_id then

		            if attached {JSON_NUMBER} j.item (quantity_key) as l_ucs then
		            	l_quantity := l_ucs.natural_64_item.to_natural_32
		            end
		            if attached {JSON_NUMBER} j.item (price_key) as l_ucs then
		            	l_price := l_ucs.real_64_item.truncated_to_real
					end
	            	create Result.make (l_id.unescaped_string_8, l_quantity, l_price)
	            else
	            	check has_id: False end
	            end
        	end
        end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
        do
        	if attached {ITEM} obj as o then
	            create jo.make
	            jo.put_string (o.id, id_key)
	            jo.put_natural (o.quantity, quantity_key)
	            jo.put_real (o.price, price_key)
				Result := jo
        	else
        		create {JSON_NULL} Result
        	end
        end

feature    {NONE} -- Implementation

    id_key: JSON_STRING
        once
            create Result.make_from_string ("id")
        end

    quantity_key: JSON_STRING
        once
            create Result.make_from_string ("quantity")
        end

    price_key: JSON_STRING
        once
            create Result.make_from_string ("price")
        end


end -- class JSON_ITEM_CONVERTER
