note
	description: "Summary description for {ORDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER
create
	make
feature -- Initialization

	make ( an_id : detachable STRING_32; a_location: detachable STRING_32; a_status: detachable STRING_32)
		do
			create {ARRAYED_LIST [ITEM]} items.make (10)
			if an_id /= Void then
				set_id (an_id)
			else
				set_id ("")
			end
			if a_location /= Void then
				set_location (a_location)
			else
				set_location ("")
			end
			if a_status /= Void then
				set_status (a_status)
			else
				set_status ("")
			end
			revision := 0
		end

feature -- Access

 	id :  STRING_32
 	location : STRING_32
 	items: LIST[ITEM]
	status :  STRING_32
	revision : INTEGER

feature -- element change

	set_id (an_id : STRING_32)
		do
			id := an_id
		ensure
			id_assigned : id.same_string (an_id)
		end

	set_location (a_location : STRING_32)
		do
			location := a_location
		ensure
			location_assigned : location.same_string (a_location)
		end

	set_status (a_status : STRING_32)
		do
			status := a_status
		ensure
			status_asigned : status.same_string (a_status)
		end

	add_item (a_item : ITEM)
		require
			valid_item:  a_item /= Void
		do
			items.force (a_item)
		ensure
			has_item : items.has (a_item)
		end

	add_revision
		do
			revision := revision + 1
		ensure
			revision_incremented : old revision + 1 = revision
		end

feature -- Etag

	etag : STRING_32
			-- Etag generation for Order objects
		do
			Result := hash_code.out + revision.out
		end


feature -- Output

feature -- Report

	hash_code: INTEGER_32
            -- Hash code value
        do
            from
                items.start
                Result := items.item.hash_code
            until
                items.off
            loop
                Result:= ((Result \\ 8388593) |<< 8) + items.item.hash_code
                items.forth
            end
            if items.count > 1  then
            	Result := Result \\ items.count
            end
        end

note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
