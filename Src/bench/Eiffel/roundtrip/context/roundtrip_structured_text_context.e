indexing
	description: "Object that stores formatted Eiffel code in structured text"

class
	ROUNDTRIP_STRUCTURED_TEXT_CONTEXT

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
			ctxt.add_string (s)
			byte_count := byte_count + s.count
		end

	clear is
		do
			create ctxt.make
			byte_count := 0
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
					Result.append (ctxt.item.image)
					ctxt.forth
				end
			end
		end

	count: INTEGER is
		do
			Result := byte_count
		end

feature{NONE} -- Implementation

	ctxt: STRUCTURED_TEXT
			-- Structured text used to store content

	byte_count: INTEGER
			-- Number in byte of length of content

invariant
	ctxt_not_void: ctxt /= VOid

end
