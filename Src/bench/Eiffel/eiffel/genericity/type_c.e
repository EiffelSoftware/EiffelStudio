deferred class TYPE_C

inherit
	HASHABLE

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
		deferred
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		require
			good_argument: buffer /= Void
		deferred
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		require
			good_argument: buffer /= Void
		deferred
		end

	generate_function_cast (buffer: GENERATION_BUFFER; arg_types: ARRAY [STRING]) is
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		local
			i, nb: INTEGER
		do
			buffer.putstring ("FUNCTION_CAST(")
			buffer.putstring (c_string)
			buffer.putstring (", (")
			from
				i := 1
				nb := arg_types.count
			until
				i > nb
			loop
				if i /= 1 then
					buffer.putstring (", ")
				end
				buffer.putstring (arg_types @ i)
				i := i + 1
			end
			buffer.putstring (")) ")
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		require
			good_argument: buffer /= Void
		deferred
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

	separate_get_macro: STRING is
			-- String generated to access the argument to a separate call
		deferred
		end

	separate_send_macro: STRING is
			-- String generated to return the result of a separate call
		deferred
		end

end
