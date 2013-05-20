note
	description: "Summary description for {JSON_ORDER_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ORDER_CONVERTER
inherit
	JSON_CONVERTER
create
	make
feature -- Initialization
	make
		do
			create object.make ("","","")
		end
feature	 -- Access
	 object : ORDER


	 value : detachable JSON_OBJECT
feature -- Conversion

	from_json (j: attached  like value): detachable like object
            -- Convert from JSON value. Returns Void if unable to convert
       local
            s_id, s_location, s_status: detachable STRING_32
            q: INTEGER_8
            o: ORDER
            i : ITEM
            l_array : detachable ARRAYED_LIST [JSON_VALUE]
            is_valid_from_json : BOOLEAN
        do
            is_valid_from_json := True

			if attached {STRING_32} json.object (j.item (id_key), Void) as l_id then
				s_id := s_id
			end
			if attached {STRING_32} json.object (j.item (location_key), Void) as l_location then
				s_location := l_location
			end
			if attached {STRING_32} json.object (j.item (status_key), Void) as l_status then
				s_status := l_status
			end

         	create o.make ("", s_location, s_status)

			if attached {JSON_ARRAY} j.item (items_key) as l_val then
				l_array := l_val.array_representation
				from
					l_array.start
				until
					l_array.after
				loop
					if attached {JSON_OBJECT} l_array.item_for_iteration as jv then
						if attached {INTEGER_8} json.object (jv.item (quantity_key), Void) as l_integer then
							q := l_integer
						else
							q := 0
						end
						if
							attached {STRING_32} json.object (jv.item (name_key), Void) as s_name and then
						  	attached {STRING_32} json.object (jv.item (size_key), Void) as s_key and then
						  	attached {STRING_32} json.object (jv.item (option_key), Void) as s_option
						  then
							if is_valid_item_customization (s_name, s_key, s_option,q) then
								create i.make (s_name, s_key, s_option, q)
								o.add_item (i)
							else
								is_valid_from_json := False
							end
						else
							is_valid_from_json := False
						end
					end

					l_array.forth
				end
			end
			if not is_valid_from_json or o.items.is_empty then
				Result := Void
			else
				Result := o
			end
	    end

    to_json (o: like object): like value
            -- Convert to JSON value
        local
        	ja : JSON_ARRAY
        	i : ITEM
        	jv: JSON_OBJECT
        do
        	create Result.make
--            Result.put (json.value (o.id), id_key)
            Result.put (json.value (o.location), location_key)
			Result.put (json.value (o.status), status_key)
            from
            	create ja.make_array
            	o.items.start
            until
            	o.items.after
            loop
            	i := o.items.item_for_iteration
            	create jv.make
            	jv.put (json.value (i.name), name_key)
            	jv.put (json.value (i.size),size_key)
            	jv.put (json.value (i.quantity), quantity_key)
            	jv.put (json.value (i.option), option_key)
            	ja.add (jv)
            	o.items.forth
            end
            Result.put (ja, items_key)
        end

 feature {NONE} -- Implementation
	id_key: JSON_STRING
        once
            create Result.make_json ("id")
        end

	location_key: JSON_STRING
        once
            create Result.make_json ("location")
        end

   status_key: JSON_STRING
        once
            create Result.make_json ("status")
        end

    items_key : JSON_STRING
	 	once
    		create Result.make_json ("items")
    	end


	name_key : JSON_STRING

    	once
    		create Result.make_json ("name")
    	end

    size_key : JSON_STRING

    	once
    		create Result.make_json ("size")
    	end

	quantity_key : JSON_STRING

    	once
    		create Result.make_json ("quantity")
    	end


    option_key : JSON_STRING

    	once
    		create Result.make_json ("option")
    	end
feature -- Validation

	is_valid_item_customization ( name :  STRING_32; size: STRING_32; option :  STRING_32; quantity :  INTEGER_8  ) : BOOLEAN
		local
			ic : ITEM_CONSTANTS
		do
				create ic
				Result := ic.is_valid_coffee_type (name) and ic.is_valid_milk_type (option) and ic.is_valid_size_option (size) and quantity > 0
		end

note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
