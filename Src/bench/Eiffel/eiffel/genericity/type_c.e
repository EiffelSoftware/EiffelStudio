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
			buffer.putstring (C_string)
			buffer.putchar (' ')
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.putchar ('(')
			buffer.putstring (C_string)
			buffer.putchar (')')
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		require
			good_argument: buffer /= Void
			not_void_type: not is_void
		do
			buffer.putchar ('(')
			buffer.putstring (C_string)
			buffer.putchar (' ')
			buffer.putchar ('*')
			buffer.putchar (')')
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		require
			good_argument: buffer /= Void
		do
			buffer.putstring (Sizeof)
			buffer.putstring (C_string)
			buffer.putchar (')')
		end

	generate_function_cast (buffer: GENERATION_BUFFER; arg_types: ARRAY [STRING]) is
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		local
			i, nb: INTEGER
			sep: STRING
		do
			buffer.putstring ("FUNCTION_CAST(")
			buffer.putstring (c_string)
			buffer.putstring (", (")
			from
				i := 1
				sep := ", "
				nb := arg_types.count
			until
				i > nb
			loop
				if i /= 1 then
					buffer.putstring (sep)
				end
				buffer.putstring (arg_types @ i)
				i := i + 1
			end
			buffer.putstring (")) ")
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
			buffer.putstring ("FUNCTION_CAST_TYPE(")
			buffer.putstring (c_string)
			buffer.putchar (',')
			buffer.putstring (call_type)
			buffer.putstring (", (")
			from
				i := 1
				nb := arg_types.count
				sep := ", "
			until
				i > nb
			loop
				if i /= 1 then
					buffer.putstring (sep)
				end
				buffer.putstring (arg_types @ i)
				i := i + 1
			end
			buffer.putstring (")) ")
		end

	generate_external_function_cast (buffer: GENERATION_BUFFER; extension: EXTERNAL_EXT_I) is
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and extension /= Void
		do
			buffer.putstring ("FUNCTION_CAST(")
			buffer.putstring (c_string)
			buffer.putstring (", (")
			extension.generate_parameter_signature_list
			buffer.putstring (")) ")
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

	c_string_id: INTEGER is
			-- String ID generated for the type.
		deferred
		end
		
	union_tag: STRING is
			-- Union tag name for type in EIF_ARG_UNIONs.
		deferred
		end

	separate_get_macro: STRING is
			-- String generated to access the argument to a separate call
		deferred
		end

	separate_send_macro: STRING is
			-- String generated to return the result of a separate call
		deferred
		end

feature {NONE} -- Constants

	Sizeof: STRING is "sizeof("
			-- Used for generation.

end
