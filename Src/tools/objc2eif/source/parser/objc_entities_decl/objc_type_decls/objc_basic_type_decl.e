note
	description: "Basic Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_BASIC_TYPE_DECL

inherit
	OBJC_TYPE_DECL
		redefine
			debug_output
		end

create
	make

feature -- Queries

	is_char: BOOLEAN
			-- Is the type represented by Current a char?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('c') --and
					  --(name.is_equal ("char") or name.is_equal ("signed char"))
		end

	is_int: BOOLEAN
			-- Is the type represented by Current an int?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('i') --and
					  --(name.is_equal ("int") or name.is_equal ("signed int"))
		end

	is_short: BOOLEAN
			-- Is the type represented by Current a short?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('s') --and
					  --(name.is_equal ("short") or name.is_equal ("signed short"))
		end

	is_long_long: BOOLEAN
			-- Is the type represented by Current a long long?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('q') --and
					  --(name.is_equal ("long long") or name.is_equal ("signed long long") or
					   --name.is_equal ("long") or name.is_equal ("signed long"))
		end

	is_unsigned_char: BOOLEAN
			-- Is the type represented by Current an unsigned char?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('C') --and
					  --name.is_equal ("unsigned char")
		end

	is_unsigned_int: BOOLEAN
			-- Is the type represented by Current an unsigned int?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('I') --and
					  --name.is_equal ("unsigned int")
		end

	is_unsigned_short: BOOLEAN
			-- Is the type represented by Current an unsigned short?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('S') --and
					  --name.is_equal ("unsigned short")
		end

	is_unsigned_long_long: BOOLEAN
			-- Is the type represented by Current an unsigned long long?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('Q') --and
					  --(name.is_equal ("unsigned long long") or name.is_equal ("unsigned long"))
		end

	is_float: BOOLEAN
			-- Is the type represented by Current a float?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('f') --and
					  --name.is_equal ("float")
		end

	is_double: BOOLEAN
			-- Is the type represented by Current a double?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('d') --and
					  --name.is_equal ("double")
		end

	is_void: BOOLEAN
			-- Is the type represented by Current void?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('v') --and
					  --name.is_equal ("void")
		end

	is_objc_bool: BOOLEAN
			-- Is the type represented by Current a BOOL?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('c') and
					  name.is_equal ("BOOL")
		end

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			if attached encoding as attached_encoding then
				Result.append (encoding)
			else
				check encoding_not_void: False end
			end
		end

end
