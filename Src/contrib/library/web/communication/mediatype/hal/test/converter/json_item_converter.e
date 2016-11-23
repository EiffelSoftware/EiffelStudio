note
	description: "Summary description for {JSON_ITEM_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ITEM_CONVERTER
inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        local
            l_id: STRING_32
        do
            create l_id.make_from_string ("")
            create object.make (l_id,0,0.0)
        end

feature -- Access

    object: ITEM

feature -- Conversion

    from_json (j: like to_json): detachable like object
        local
            l_quantity : NATURAL
            l_price : REAL
        do
            if attached {STRING_32} json.object (j.item (id_key), Void) as l_id then

	            if attached {NATURAL} json.object (j.item (quantity_key), Void) as l_ucs then
	            	l_quantity := l_ucs
	            end

	            if attached {REAL} json.object (j.item (quantity_key), Void) as l_ucs then
	            	l_price := l_ucs
				end

            	create Result.make (l_id, l_quantity, l_price)
            else
            	check has_id: False end
            end
        end

    to_json (o: like object): JSON_OBJECT
        do
            create Result.make
            Result.put (json.value (o.id), id_key)
            Result.put (json.value (o.quantity), quantity_key)
            Result.put (json.value (o.price), price_key)
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
