indexing
	description: "Typed pointer. To be used for better interfacing with externals: C, C++, .NET."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPED_POINTER [G]
	
create {NONE}

convert
	to_pointer: {POINTER}

feature -- Conversion

	frozen to_pointer: POINTER is
			-- Convert current to POINTER.
		do
			-- Built-in
		end
		
feature -- Access

	frozen item: G is
			-- Content of pointer.
		do
			-- Built-in
		end

feature -- Settings

	frozen put (v: G) is
			-- Replace content of pointer by `v'.
		do
			-- Built-in
		ensure
			set: item = v
		end

end -- class TYPED_POINTER
