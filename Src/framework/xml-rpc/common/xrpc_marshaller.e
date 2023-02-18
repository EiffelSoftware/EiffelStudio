note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_MARSHALLER

inherit
	ANY

	XRPC_TYPE_IDS
		export
			{NONE} all
			{ANY} is_array_conform_from,
			      is_array_conform_to,
			      is_boolean,
			      is_double,
			      is_integer,
			      is_string,
			      is_struct
		end

feature -- Status report

	is_marshallable_type (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Determines if a type can be marshalled.
			-- Note: This is typically used for XML-RPC method argument type validation. For method result
			--       types use `is_marshallable_result_type'.
			--
			-- `a_type': A type identifier of a method argument type.
			-- `Result': True if the type is marshallable; False otherwise.
		do
			Result := is_boolean (a_type) or else
				is_double (a_type) or else
				is_integer (a_type) or else
				is_string (a_type) or else
				is_array_conform_from (a_type) or else
				is_array_conform_to (a_type) or else
				is_struct (a_type)
		end

	is_marshallable_result_type (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Determines if a function result type can be marshalled.
			-- Note: This is typically used for XML-RPC method result type validation. For method arguments
			--       types use `is_marshallable_type'.
			--
			-- `a_type': A type identifier of a method result type.
			-- `Result': True if the type is marshallable; False otherwise.
		do
			Result := is_marshallable_type (a_type) or else a_type = xrpc_response_type
		ensure
			is_marshallable_type: Result implies
				(is_marshallable_type (a_type) or else a_type = xrpc_response_type)
		end

	is_marshallable_routine (a_routine: ROUTINE): BOOLEAN
			-- Determines if a routine is able to be marshalled.
			-- This check ensures any arguments and a result type are marshallable.
			--
			-- `a_routine': A procedure/function agent to validate for marshalling.
			-- `Result': True if the routine is marshallable; False otherwise.
		require
			a_routine_attached: a_routine /= Void
		local
			l_tuple: TYPE [detachable ANY]
			l_type: TYPE [detachable ANY]
			i, i_count: INTEGER
		do
				-- Routines cannot have an open target because custom Eiffel objects cannot be marshalled.
			Result := a_routine.target /= Void
			if Result then
				if a_routine.open_count > 0 then
						-- Check argument tuple types
					l_tuple := a_routine.generating_type.generic_parameter_type (2)
					i_count := l_tuple.generic_parameter_count
					from i := 1 until i > i_count or not Result loop
						l_type := l_tuple.generic_parameter_type (i)
						Result := is_marshallable_type (l_type)
						i := i + 1
					end
				end

				if Result and then attached {FUNCTION [ANY]} a_routine as l_function then
						-- Check result type
					l_type := l_function.generating_type.generic_parameter_type (3)
					Result := is_marshallable_result_type (l_type)
				end
			end
		ensure
			a_routine_target_attached: Result implies a_routine.target /= Void
		end

	is_marshallable_object (a_object: ANY): BOOLEAN
			-- Determines if an object is able to be marshalled.
			--
			-- `a_routine': An object to validate for marshalling.
			-- `Result': True if the object is marshallable; False otherwise.
		require
			a_object_attached: a_object /= Void
		local
			t: TYPE [detachable ANY]
		do
			t := a_object.generating_type
			Result := is_array_conform_from (t) or else
				--is_array_conform_to (t) or else
				is_boolean (t) or else
				is_double (t) or else
				is_integer (t) or else
				is_string (t) or else
				is_struct (t)
		end

feature -- Basic operations: To Eiffel

	marshal_to (a_type: TYPE [detachable ANY]; a_value: XRPC_VALUE): detachable ANY
			-- Marshals an XML-RPC value object into an object of the supplied type.
			-- If any incompatibilities are found and exception of {XRPC_MARSHAL_EXCEPTION} will be rasied.
			--
			-- `a_type': The type to marshal to.
			-- `a_value': A XML-RPC value object.
			-- `Result': A marshalled value or Void if nothing could be marshalled.
		require
			a_type_is_marshallable_type: is_marshallable_type (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		local
			l_exception: detachable XRPC_MARSHAL_TYPE_EXCEPTION
		do
			inspect a_value.type.item
			when {XRPC_TYPE}.array then
				if is_array_conform_to (a_type) and then attached {XRPC_ARRAY} a_value as l_value then
					Result := marshal_to_array (a_type, l_value)
				else
						-- Error: Incompatible type.
					create l_exception.make (xrpc_array_type, a_type)
				end
			when {XRPC_TYPE}.boolean then
				if is_boolean (a_type) and then attached {XRPC_BOOLEAN} a_value as l_value then
					Result := marshal_to_boolean (a_type, l_value)
				else
						-- Error: Incompatible type.
					create l_exception.make (xrpc_boolean_type, a_type)
				end
			when {XRPC_TYPE}.double then
				if is_double (a_type) and then attached {XRPC_DOUBLE} a_value as l_value then
					Result := marshal_to_double (a_type, l_value)
				else
						-- Error: Incompatible type.
					create l_exception.make (xrpc_double_type, a_type)
				end
			when {XRPC_TYPE}.integer then
				if is_integer (a_type) and then attached {XRPC_INTEGER} a_value as l_value then
					Result := marshal_to_integer (a_type, l_value)
				else
						-- Error: Incompatible type.
					create l_exception.make (xrpc_integer_type, a_type)
				end
			when {XRPC_TYPE}.string then
				if is_string (a_type) and then attached {XRPC_STRING} a_value as l_value then
					Result := marshal_to_string (a_type, l_value)
				else
						-- Error: Incompatible type.
					create l_exception.make (xrpc_string_type, a_type)
				end
			when {XRPC_TYPE}.struct then
				if is_struct (a_type) and then attached {XRPC_STRUCT} a_value as l_value then
					Result := marshal_to_struct (a_type, l_value)
				else
						-- Error: Incompatible type.
					create l_exception.make (xrpc_struct_type, a_type)
				end
			else
				if a_value.generating_type = a_type then
					Result := a_value
				else
						-- Error: Incompatbile type.
					create l_exception.make (a_value.generating_type, a_type)
				end
			end

			if l_exception /= Void then
					-- There was a problem, raise an exception.
				l_exception.raise
			end
		end

	marshal_to_array (a_type: TYPE [detachable ANY]; a_value: XRPC_ARRAY): detachable ANY
			-- Marshals an XML-RPC value to an array object.
			-- If any incompatibilities are found and exception of {XRPC_MARSHAL_EXCEPTION} will be rasied.
			--
			-- `a_type': The array type to marshal to.
			-- `a_value': A XML-RPC array object.
			-- `Result': A marshalled array or Void if nothing could be marshalled.
		require
			a_type_is_array: is_array_conform_to (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		local
			l_generic_type: TYPE [detachable ANY]
			l_value: XRPC_VALUE
			l_value_type: TYPE [detachable ANY]
			l_array: detachable ARRAY [detachable ANY]
			l_default: detachable ANY
			i, i_count: NATURAL
			l_exception: XRPC_MARSHAL_TYPE_EXCEPTION
		do
			if xrpc_array_type.conforms_to (a_type) then
					-- No marshalling needed.
				Result := a_value
			elseif a_type.generic_parameter_count = 1 then
					-- Determine the array generic parameter
				l_generic_type := a_type.generic_parameter_type (1)
				if is_marshallable_type (l_generic_type) then
					if a_type.has_default then
						Result := a_type.default
					else
						Result := a_type.default_detachable_value
					end

					if attached {ARRAY [ANY]} Result as l_result  then
						l_array := l_result
					end
					check l_array_attached: l_array /= Void end
					if l_generic_type.has_default then
						l_default := l_generic_type.default
					else
						l_default := l_generic_type.default_detachable_value
					end

					i := 1
					i_count := a_value.count
					l_array.make_filled (l_default, i.as_integer_32, i_count.as_integer_32)
					from until i > i_count loop
							-- Marshalling will raise an exception if the types to not conform.
						l_value_type := l_generic_type
						l_value := a_value[i]
						if l_value_type = any_type then
								-- ARRAY [ANY] was used, but we need to marshal to a known type.
								-- Use the type of the XML-RPC value object to determine the best type.
							inspect l_value.type.item
							when {XRPC_TYPE}.array then
								l_value_type := array_any_type
							when {XRPC_TYPE}.boolean then
								l_value_type := boolean_type
							when {XRPC_TYPE}.double then
								l_value_type := real_64_type
							when {XRPC_TYPE}.integer then
								l_value_type := integer_32_type
							when {XRPC_TYPE}.string then
								l_value_type := string_8_type
							else
								check unsupported_type: False end
							end
						end
						l_array.put (marshal_to (l_value_type, l_value), i.as_integer_32)
						i := i + 1
					end
				else
						-- Error: Incompatbile type.
					create l_exception.make (xrpc_array_type, a_type)
					l_exception.raise
				end
			end
		end

	marshal_to_boolean (a_type: TYPE [detachable ANY]; a_value: XRPC_BOOLEAN): BOOLEAN
			-- Marshals an XML-RPC value to an boolean object.
			-- If any incompatibilities are found and exception of {XRPC_MARSHAL_EXCEPTION} will be rasied.
			--
			-- `a_type': The boolean type to marshal to.
			-- `a_value': A XML-RPC boolean object.
			-- `Result': A marshalled boolean.
		require
			a_type_is_boolean: is_boolean (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		do
			if a_type = xrpc_boolean_type then
					-- No marshalling needed.
				Result := a_value
			else
				Result := a_value.value
			end
		ensure
			result_set: Result = a_value.value
		end

	marshal_to_double (a_type: TYPE [detachable ANY]; a_value: XRPC_DOUBLE): ANY
			-- Marshals an XML-RPC value to an double object.
			-- If any incompatibilities are found and exception of {XRPC_MARSHAL_EXCEPTION} will be rasied.
			--
			-- `a_type': The double type to marshal to.
			-- `a_value': A XML-RPC double object.
			-- `Result': A marshalled double.
		require
			a_type_is_double: is_double (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		local
			l_double: REAL_64
		do
			if a_type = xrpc_double_type then
					-- No marshalling needed.
				Result := a_value
			else
				l_double := a_value.value
				if a_type = real_32_type then
					Result := l_double.truncated_to_real
				else
					Result := l_double
				end
			end
		ensure
			result_attached: Result /= Void
		end

	marshal_to_integer (a_type: TYPE [detachable ANY]; a_value: XRPC_INTEGER): ANY
			-- Marshals an XML-RPC value to an integer object.
			-- If any incompatibilities are found and exception of {XRPC_MARSHAL_EXCEPTION} will be rasied.
			--
			-- `a_type': The integer type to marshal to.
			-- `a_value': A XML-RPC integer object.
			-- `Result': A marshalled integer.
		require
			a_type_is_integer: is_integer (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		local
			l_integer: INTEGER_32
			l_exception: detachable XRPC_MARSHAL_EXCEPTION
		do
			if a_type = xrpc_integer_type then
					-- No marshalling needed.
				Result := a_value
			else
				l_integer := a_value.value
				if a_type = integer_32_type then
					Result := l_integer
				elseif a_type = integer_16_type then
					if l_integer <= {INTEGER_16}.max_value then
						Result := l_integer.as_integer_16
					else
							-- Overflow.
						create {XRPC_OVERFLOW_EXCEPTION} l_exception.make ({INTEGER_16}.max_value.out)
						Result := {INTEGER_16}0
					end
				elseif a_type = integer_8_type then
					if l_integer <= {INTEGER_8}.max_value then
						Result := l_integer.as_integer_8
					else
							-- Overflow.
						create {XRPC_OVERFLOW_EXCEPTION} l_exception.make ({INTEGER_8}.max_value.out)
						Result := {INTEGER_8}0
					end
				else
					if l_integer >= 0 then
						if a_type = natural_32_type then
							Result := l_integer.as_natural_32
						elseif a_type = natural_16_type then
							if l_integer <= {NATURAL_16}.max_value then
								Result := l_integer.as_natural_16
							else
									-- Overflow.
								create {XRPC_OVERFLOW_EXCEPTION} l_exception.make ({NATURAL_16}.max_value.out)
								Result := {NATURAL_16}0
							end
						elseif a_type = natural_8_type then
							if l_integer <= {NATURAL_8}.max_value then
								Result := l_integer.as_natural_8
							else
									-- Overflow.
								create {XRPC_OVERFLOW_EXCEPTION} l_exception.make ({NATURAL_8}.max_value.out)
								Result := {NATURAL_8}0
							end
						else
								-- Overflow
							create {XRPC_OVERFLOW_EXCEPTION} l_exception.make ({NATURAL_32}.max_value.out)
							Result := {NATURAL_8}0
						end
					else
							-- Underflow.
						create {XRPC_UNDERFLOW_EXCEPTION} l_exception.make ({NATURAL_8}.min_value.out)
						Result := {NATURAL_8}0
					end
				end

				if l_exception /= Void then
						-- There was a problem, raise an exception.
					l_exception.raise
				end
			end
		ensure
			result_attached: Result /= Void
		end

	marshal_to_string (a_type: TYPE [detachable ANY]; a_value: XRPC_STRING): ANY
			-- Marshals an XML-RPC value to an string object.
			--
			-- `a_type': The string type to marshal to.
			-- `a_value': A XML-RPC string object.
			-- `Result': A marshalled string.
		require
			a_type_is_string: is_string (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		local
			l_string: STRING_32
		do
			if a_type = xrpc_string_type then
					-- No marshalling needed.
				Result := a_value
			else
				l_string := a_value.value
				if
					a_type = string_8_type or
					a_type = readable_string_8_type or
					a_type = readable_string_general_type
				then
					Result := l_string
				elseif
					a_type = string_32_type or
					a_type = readable_string_32_type
				then
					Result := l_string.as_string_32
				elseif a_type = immutable_string_8_type then
					create {IMMUTABLE_STRING_8} Result.make_from_string
						({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_string))
				elseif a_type = immutable_string_8_type then
					create {IMMUTABLE_STRING_32} Result.make_from_string (l_string)
				else
						-- Unknown string
					check should_never_happen: False end
					Result := ""
				end
			end
		ensure
			result_attached: Result /= Void
		end

	marshal_to_struct (a_type: TYPE [detachable ANY]; a_value: XRPC_STRUCT): ANY
			-- Marshals an XML-RPC value to an string object.
			--
			-- `a_type': The struct type to marshal to.
			-- `a_value': A XML-RPC struct object.
			-- `Result': A marshalled struct.
		require
			a_type_is_struct: is_struct (a_type)
			a_value_attached: a_value /= Void
			a_value_is_valid: a_value.is_valid
		do
			if a_type = xrpc_string_type then
					-- No marshalling needed.
				Result := a_value
			else
					-- Unknown string
				check should_never_happen: False end
				create {XRPC_STRUCT}Result.make
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations: From Eiffel

	marshal_from (a_value: ANY): XRPC_VALUE
			-- Marshals an XML-RPC value object into an object of the supplied type.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		local
			l_type: TYPE [detachable ANY]
		do
			if attached {XRPC_VALUE} a_value as l_result then
					-- No marshalling needed
				Result := l_result
			else
				l_type := a_value.generating_type
				if is_array_conform_from (l_type) then
					Result := marshal_from_array (a_value)
				elseif is_boolean (l_type) then
					Result := marshal_from_boolean (a_value)
				elseif is_double (l_type) then
					Result := marshal_from_double (a_value)
				elseif is_integer (l_type) then
					Result := marshal_from_integer (a_value)
				elseif is_string (l_type) then
					Result := marshal_from_string (a_value)
				elseif is_struct (l_type) then
					Result := marshal_from_struct (a_value)
				else
						-- Unknown XML-RPC type
					check should_never_happen: False end
					create {XRPC_DEFAULT_VALUE} Result
				end
			end
		end

	marshal_from_array (a_value: ANY): XRPC_ARRAY
			-- Marshals an Eiffel array to a XML-RPC array object.
			--
			-- `a_value': A array to marshal.
			-- `Result': A marshaled XML-RPC array object.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		local
			l_mutable_array: XRPC_MUTABLE_ARRAY
			i, i_upper: INTEGER
			l_exception: XRPC_MARSHAL_TYPE_EXCEPTION
		do
			check a_value_is_array: is_array_conform_from (a_value.generating_type) end

			if a_value.generating_type = xrpc_array_type and then attached {XRPC_ARRAY} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				create l_mutable_array.make_empty
				if attached {ARRAY [ANY]} a_value as l_array then
					from
						i := l_array.lower
						i_upper := l_array.upper
					until
						i > i_upper
					loop
						if attached l_array[i] as l_item and then is_marshallable_object (l_item) then
							l_mutable_array.extend (marshal_from (l_item))
						else
							create l_exception.make (l_array[i].generating_type, Void)
							l_exception.raise
						end
						i := i + 1
					end
					check same_count: l_array.count.as_natural_32  = l_mutable_array.count end
				else
					check should_never_happen: False end
				end
				Result := l_mutable_array
			end
		ensure
			result_attached: Result /= Void
			result_is_valid: Result.is_valid
			result_is_array: is_array_conform_from (Result.generating_type)
		end

	marshal_from_boolean (a_value: ANY): XRPC_BOOLEAN
			-- Marshals an Eiffel Boolean value to a XML-RPC Boolean object.
			--
			-- `a_value': A Boolean value to marshal.
			-- `Result': A marshaled XML-RPC Boolean object.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_boolean: is_boolean (a_value.generating_type) end

			if a_value.generating_type = xrpc_boolean_type and then attached {XRPC_BOOLEAN} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if attached {BOOLEAN_REF} a_value as l_bool then
					create Result.make (l_bool.item)
				else
					check should_never_happen: False end
					create Result.make (False)
				end
			end
		ensure
			result_attached: Result /= Void
			result_is_valid: Result.is_valid
			result_is_boolean: is_boolean (Result.generating_type)
		end

	marshal_from_double (a_value: ANY): XRPC_DOUBLE
			-- Marshals an Eiffel real value to a XML-RPC double object.
			--
			-- `a_value': A real value to marshal.
			-- `Result': A marshaled XML-RPC double object.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_double: is_double (a_value.generating_type) end

			if a_value.generating_type = xrpc_double_type and then attached {XRPC_DOUBLE} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if attached {REAL_64_REF} a_value as l_real then
					create Result.make (l_real.item)
				elseif attached {REAL_32_REF} a_value as l_real then
					create Result.make (l_real.item)
				else
					check should_never_happen: False end
					create Result.make (0.0)
				end
			end
		ensure
			result_attached: Result /= Void
			result_is_valid: Result.is_valid
			result_is_boolean: is_boolean (Result.generating_type)
		end

	marshal_from_integer (a_value: ANY): XRPC_INTEGER
			-- Marshals an Eiffel integer value to a XML-RPC integer object.
			--
			-- `a_value': An integer or nautral value to marshal.
			-- `Result': A marshaled XML-RPC integer object.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		local
			l_type: TYPE [detachable ANY]
			l_exception: detachable XRPC_MARSHAL_EXCEPTION
		do
			check a_value_is_integer: is_integer (a_value.generating_type) end

			l_type := a_value.generating_type
			if l_type = xrpc_integer_type and then attached {XRPC_INTEGER} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if l_type = integer_64_type then
					if attached {INTEGER_64_REF} a_value as l_int then
						if l_int.item <= {INTEGER_32}.max_value then
							if l_int.item >= {INTEGER_32}.min_value then
								create Result.make (l_int.item.as_integer_32)
							else
									-- Underflow
								create {XRPC_UNDERFLOW_EXCEPTION} l_exception.make ({INTEGER_32}.min_value.out)
								create Result.make (0)
							end
						else
								-- Overflow
							create {XRPC_UNDERFLOW_EXCEPTION} l_exception.make ({INTEGER_32}.max_value.out)
							create Result.make (0)
						end
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = integer_32_type then
					if attached {INTEGER_32_REF} a_value as l_int then
						create Result.make (l_int.item)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = integer_16_type then
					if attached {INTEGER_16_REF} a_value as l_int then
						create Result.make (l_int.item)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = integer_8_type then
					if attached {INTEGER_8_REF} a_value as l_int then
						create Result.make (l_int.item)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_64_type then
					if attached {NATURAL_64_REF} a_value as l_natural then
						if l_natural.item <= {INTEGER_32}.max_value.as_natural_64 then
							create Result.make (l_natural.item.as_integer_32)
						else
								-- Overflow
							create {XRPC_UNDERFLOW_EXCEPTION} l_exception.make ({INTEGER_32}.max_value.out)
							create Result.make (0)
						end
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_32_type then
					if attached {NATURAL_32_REF} a_value as l_natural then
						if l_natural.item <= {INTEGER_32}.max_value.as_natural_32 then
							create Result.make (l_natural.item.as_integer_32)
						else
								-- Overflow
							create {XRPC_UNDERFLOW_EXCEPTION} l_exception.make ({INTEGER_32}.max_value.out)
							create Result.make (0)
						end
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_16_type then
					if attached {NATURAL_16_REF} a_value as l_natural then
						create Result.make (l_natural.item.as_integer_32)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_8_type then
					if attached {NATURAL_8_REF} a_value as l_natural then
						create Result.make (l_natural.item.as_integer_32)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				else
					check should_never_happen: False end
					create Result.make (0)
				end
			end
		ensure
			result_attached: Result /= Void
			result_is_valid: Result.is_valid
			result_is_integer: is_integer (Result.generating_type)
		end

	marshal_from_string (a_value: ANY): XRPC_STRING
			-- Marshals an Eiffel string value to a XML-RPC string object.
			--
			-- `a_value': A string value to marshal.
			-- `Result': A marshaled XML-RPC string object.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_string: is_string (a_value.generating_type) end

			if a_value.generating_type = xrpc_string_type and then attached {XRPC_STRING} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if attached {READABLE_STRING_8} a_value as l_string then
					create Result.make (l_string)
				elseif attached {READABLE_STRING_32} a_value as l_string and then l_string.is_string_8 then
					create Result.make (l_string.to_string_8)
				else
					check should_never_happen: False end
					create Result.make ("")
				end
			end
		ensure
			result_attached: Result /= Void
			result_is_valid: Result.is_valid
			result_is_string: is_string (Result.generating_type)
		end

	marshal_from_struct (a_value: ANY): XRPC_STRUCT
			-- Marshals an Eiffel struct value to a XML-RPC string object.
			--
			-- `a_value': A struct value to marshal.
			-- `Result': A marshaled XML-RPC struct object.
		require
			a_value_attached: a_value /= Void
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_struct: is_struct (a_value.generating_type) end

			if a_value.generating_type = xrpc_struct_type and then attached {XRPC_STRUCT} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				check should_never_happen: False end
				create Result.make
			end
		ensure
			result_attached: Result /= Void
			result_is_valid: Result.is_valid
			result_is_struct: is_struct (Result.generating_type)
		end

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
