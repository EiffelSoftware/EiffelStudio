indexing
	description: "[
		Representation of a parameter generic derivation. Meta because
		expanded generic parameter gets their own type, but all references gets
		a REFERENCE_I instance.
		]"
	date: "$Date$"
	revision: "$Revision: "

class
	META_GENERIC

inherit
	ARRAY [TYPE_I]
		rename
			make as array_make
		end

	SHARED_CODE_FILES
		undefine
			copy, is_equal
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
		require
			n_valid: n >= 0
		do
			array_make (1, n)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		require
			other_not_void: other /= Void
		local
			i, nb: INTEGER
		do
			nb := count
			Result := nb = other.count
			from
				i := 1
			until
				i > nb or else not Result
			loop
				Result := item (i).same_as (other.item (i))
				i := i + 1
			end
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Are all the types valid ?
		local
			i, nb: INTEGER
		do
			from
				nb := count
				i := 1
				Result := True
			until
				i > nb or else not Result
			loop
				Result := item (i).is_valid
				i := i + 1
			end
		end

feature -- C code generation

	generate_cecil_values (buffer: GENERATION_BUFFER) is
			-- Generate Cecil meta-types
		require
			buffer_not_void: buffer /= Void
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				item (i).generate_cecil_value (buffer)
				buffer.putstring (",%N")
				i := i + 1
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for cecil values
		require
			ba_not_void: ba /= Void
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				ba.append_int32_integer (item (i).cecil_value)
				i := i + 1
			end
		end

end
