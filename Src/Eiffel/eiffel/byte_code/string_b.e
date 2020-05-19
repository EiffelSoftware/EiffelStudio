note
	description: "Byte code for Eiffel string (allocated each time)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STRING_B

inherit
	EXPR_B
		redefine
			enlarged, is_simple_expr, allocates_memory, is_constant_expression
		end

	SHARED_ENCODING_CONVERTER

create {INTERNAL_COMPILER_STRING_EXPORTER}
	make

feature {NONE} -- Initialization

	make (v: STRING; a_str32: BOOLEAN; a_is_immutable: BOOLEAN)
			-- Assign `v' to `value'.
		require
			v_not_void: v /= Void
		do
			value := v
			is_string_32 := a_str32
			is_immutable := a_is_immutable
		ensure
			value_set: value = v
			is_string_32_set: is_string_32 = a_str32
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_string_b (Current)
		end

feature -- Access

	is_dotnet_string: BOOLEAN
			-- Is current a manifest System.String constant?

	is_string_32: BOOLEAN
			-- Is current a STRING_32 manifest string?

	is_immutable: BOOLEAN
			-- Is the IMMUTABLE_ variant of string?

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	value: STRING
			-- Character value in UTF-8

	value_32: STRING_32
			-- Value in UTF-32
		do
			Result := encoding_converter.utf8_to_utf32 (value)
		ensure
			Result_set: Result /= Void
		end

	value_8: STRING_8
			-- UTF-32 (0-255) / ISO-8859-1 stored in STRING_8 instance
		require
			is_string_8: not is_string_32
		do
			Result := value_32.to_string_8
		ensure
			Result_set: Result /= Void
		end

feature -- Properties

	type: CL_TYPE_A
			-- String type
		do
			if is_dotnet_string then
				Result := system_string_type
			elseif not is_string_32 then
				if is_immutable then
					Result := immutable_string_type
				else
					Result := string_type
				end
			else
				if is_immutable then
					Result := immutable_string_32_type
				else
					Result := string_32_type
				end
			end
		end

	enlarged: STRING_BL
			-- Enlarge node
		do
			create Result.make (value, is_string_32, is_immutable)
		end

	used (r: REGISTRABLE): BOOLEAN
			-- Register `r' is not used for string value computation
		do
		end

	is_simple_expr: BOOLEAN = True
			-- A string is a simple expression

	allocates_memory: BOOLEAN = True
			-- Current always allocates memory.

	is_constant_expression: BOOLEAN = True
			-- A string is a constant expression.

feature -- Settings

	set_is_dotnet_string (v: like is_dotnet_string)
			-- Set `is_dotnet_string' with `v'.
		do
			is_dotnet_string := v
		ensure
			is_dotnet_string_set: is_dotnet_string = v
		end

feature {NONE} -- Implementation: types

	string_type: CL_TYPE_A
			-- Type of STRING.
		once
			create Result.make (System.string_8_id)
		ensure
			string_type_not_void: Result /= Void
		end

	string_32_type: CL_TYPE_A
			-- Type of STRING_32.
		once
			create Result.make (System.string_32_id)
		ensure
			string_type_not_void: Result /= Void
		end

	immutable_string_type: CL_TYPE_A
			-- Type of IMMUTABLE_STRING_8.
		once
			create Result.make (System.immutable_string_8_id)
		ensure
			immutable_string_type_not_void: Result /= Void
		end

	immutable_string_32_type: CL_TYPE_A
			-- Type of IMMUTABLE_STRING_32.
		once
			create Result.make (System.immutable_string_32_id)
		ensure
			immutable_string_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_A
			-- Type of SYSTEM_STRING.
		require
			il_generation: System.il_generation
		once
			create Result.make (System.system_string_id)
		ensure
			system_string_type_not_void: Result /= Void
		end

invariant
	value_not_void: value /= Void
	valid_string_8: not is_string_32 implies value_32.is_valid_as_string_8

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

end -- class STRING_B
