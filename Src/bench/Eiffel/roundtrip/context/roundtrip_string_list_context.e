indexing
	description: "Object that stores formatted Eiffel code in linked list"

class
	ROUNDTRIP_STRING_LIST_CONTEXT

inherit
	ROUNDTRIP_CONTEXT

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create ctxt.make
		end

feature -- Operation

	add_string (s: STRING) is
		do
			ctxt.extend (s)
			byte_count := byte_count + s.count
			ctxt.finish
		ensure then
			string_added: ctxt.count = old ctxt.count + 1
		end

	clear is
		do
			from

			until
				ctxt.is_empty
			loop
				ctxt.start
				ctxt.remove
			end
			byte_count := 0
		ensure then
			ctxt_is_empty: ctxt.is_empty
		end

	string_representation: STRING is
		do
			if byte_count > 0 then
				from
					ctxt.start
					create Result.make (byte_count)
				until
					ctxt.after
				loop
					Result.append (ctxt.item)
					ctxt.forth
				end
			else
				Result := ""
			end
		end

	count: INTEGER is
		do
			Result := byte_count
		end

feature{NONE} -- Implementation

	ctxt: LINKED_LIST [STRING]
			-- Internal linked list to store formatted code

	initial_list_capacity: INTEGER is 2000
			-- Initial capacity of `ctxt'.

	byte_count: INTEGER
			-- Length (in bytes) of formatted code stored in `ctxt'.

invariant
	ctxt_not_void: ctxt /= Void

end
