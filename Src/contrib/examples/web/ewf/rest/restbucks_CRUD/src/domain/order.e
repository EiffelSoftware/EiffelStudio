note
	description: "Summary description for {ORDER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER

create
	make,
	make_empty

feature -- Initialization

	make_empty
		do
			create {ARRAYED_LIST [ORDER_ITEM]} items.make (10)
			revision := 0
			set_id ("")
			status := {RESTBUCKS_API}.status_unset
		end

	make (a_id: READABLE_STRING_8; a_status: detachable READABLE_STRING_GENERAL)
		do
			make_empty
			set_id (a_id)
			if a_status /= Void then
				set_status (a_status)
			else
				check status.same_string_general ({RESTBUCKS_API}.status_unset) end
			end
		end

feature -- Access

 	id: IMMUTABLE_STRING_8

 	location: detachable STRING_32

	status: STRING_32
			-- Status of the order, see {RESTBUCKS_API}.Order_states

	revision: INTEGER

 	items: LIST [ORDER_ITEM]

feature -- Status report

	has_id: BOOLEAN
			-- Has valid identifier `id`?
		do
			Result := not id.is_whitespace and not id.is_case_insensitive_equal ("0")
		end

	is_submitted: BOOLEAN
		do
			Result := status.is_case_insensitive_equal_general ({RESTBUCKS_API}.status_submitted)
		end

feature -- element change

	set_id (a_id: READABLE_STRING_8)
		do
			if attached {IMMUTABLE_STRING_8} a_id as l_id then
				id := l_id
			else
				create id.make_from_string (a_id)
			end
		ensure
			id_assigned : a_id.same_string (id)
		end

	set_location (a_location: detachable READABLE_STRING_GENERAL)
		do
			if a_location = Void then
				location := Void
			else
				create location.make_from_string_general (a_location)
			end
		ensure
			location_assigned: (a_location = Void implies location = Void)
						or (a_location /= Void implies attached location as loc and then a_location.same_string (loc))
		end

	mark_submitted
		do
			status := {RESTBUCKS_API}.status_submitted
		end

	set_status (a_status: READABLE_STRING_GENERAL)
		do
			create status.make_from_string_general (a_status)
		ensure
			status_assigned : a_status.same_string (status)
		end

	add_item (a_item: ORDER_ITEM)
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
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
