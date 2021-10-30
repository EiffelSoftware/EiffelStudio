note
	description: "Representation of an eiffel constant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class E_CONSTANT

inherit

	E_FEATURE
		redefine
			assigner_name,
			is_constant,
			type
		end

create

	make,
	make_with_aliases

feature -- Properties

	is_constant: BOOLEAN = True
			-- Is current a function

	type: TYPE_A
			-- Return type

	value_32: STRING_32
			-- String representation of the constant.
		do
			if attached value as l_v then
				Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_v)
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	value: STRING
			-- String representation of the constant

	assigner_name: STRING
			-- Name of the assigner procedure (if any)

feature -- Setting

	set_type (t: like type; a: like assigner_name)
			-- Set `type' to `t' and `assigner_name' to `a'.
		require
			valid_t: t /= Void
		do
			type := t
			assigner_name := a
		ensure
			type_set: type = t
			assigner_name_set: assigner_name = a
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Setting

	set_value (v: like value)
			-- Set `value' to `v'.
		require
			valid_v: v /= Void
		do
			value := v
		ensure
			set: value = v
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end
