deferred class TYPE_C

inherit
	HASHABLE
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature

	level: INTEGER is
			-- Internal code for generation
		deferred
		end

	same_class_type (other: TYPE_C): BOOLEAN is
			-- Is `other' the same C type as Current ?
		require
			valid_argument: other /= Void
		do
			Result := other.level = level
		end

	is_pointer: BOOLEAN is
			-- Is C type a reference type
		do
			-- Do nothing
		end

	is_bit: BOOLEAN is
			-- Is C type a a bit type (Conveniencee)
		do
			-- Do nothing
		end

	is_boolean: BOOLEAN is
			-- Is C type a boolean type ?
		deferred
		end

	is_void: BOOLEAN is
			-- Is C type a void type
		do
			-- Do nothing
		end

	trace is
			-- Debug purpose
		deferred
		end

	description: ATTR_DESC is
		deferred
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_string (C_string)
			buffer.put_character (' ')
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_character ('(')
			buffer.put_string (C_string)
			buffer.put_character (')')
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		require
			good_argument: buffer /= Void
			not_void_type: not is_void
		do
			buffer.put_character ('(')
			buffer.put_string (C_string)
			buffer.put_character (' ')
			buffer.put_character ('*')
			buffer.put_character (')')
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		require
			good_argument: buffer /= Void
		do
			buffer.put_string (Sizeof)
			buffer.put_string (C_string)
			buffer.put_character (')')
		end

	generate_function_cast (buffer: GENERATION_BUFFER; arg_types: ARRAY [STRING]) is
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		do
			generate_function_cast_type (buffer, Void, arg_types)
		end

	generate_function_cast_type (buffer: GENERATION_BUFFER; call_type: STRING; arg_types: ARRAY [STRING]) is
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		local
			i, nb: INTEGER
			sep: STRING
		do
			if call_type /= Void then
				buffer.put_string ("FUNCTION_CAST_TYPE(")
				buffer.put_string (c_string)
				buffer.put_character (',')
				buffer.put_string (call_type)
			else
				buffer.put_string ("FUNCTION_CAST(")
				buffer.put_string (c_string)
			end
			buffer.put_string (", (")
			from
				i := 1
				nb := arg_types.count
				sep := ", "
			until
				i > nb
			loop
				if i /= 1 then
					buffer.put_string (sep)
				end
				buffer.put_string (arg_types @ i)
				i := i + 1
			end
			buffer.put_string (")) ")
		end

	generate_union (buffer: GENERATION_BUFFER) is
			-- Generate discriminant of C structure "item" associated
			-- to the current C type in `buffer'.
		require
			good_argument: buffer /= Void
		deferred
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		require
			good_argument: buffer /= Void
		deferred
		end

	c_string: STRING is
			-- String generated for the type.
		deferred
		end
		
	union_tag: STRING is
			-- Union tag name for type in EIF_ARG_UNIONs.
		deferred
		end

feature {NONE} -- Constants

	Sizeof: STRING is "sizeof("
			-- Used for generation.

end
