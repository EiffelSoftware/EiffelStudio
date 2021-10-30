note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_CALL_STACK_ELEMENT

inherit
	CALL_STACK_ELEMENT

	SHARED_ENCODING_CONVERTER

create
	make

feature -- Change

	set_info (a_oa: DBG_ADDRESS; tid: POINTER; a_cn, a_fn: STRING_32; a_bp, a_bp_nested: INTEGER; a_info: READABLE_STRING_32)
		require
			object_address_not_void: a_oa /= Void
			class_name_not_void: a_cn /= Void
			routine_name_not_void: a_fn /= Void
			break_index_positive: a_bp >= 0
		do
			class_name := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_cn)
			routine_name := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_fn)
			routine_name_for_display := a_fn
			break_index := a_bp
			break_nested_index := a_bp_nested
			thread_id := tid
			object_address := a_oa
			info := a_info
		end

feature -- Properties

	info: READABLE_STRING_32

	is_eiffel_call_stack_element: BOOLEAN = False
			-- Is Current an Eiffel Call Stack Element ?

	is_hidden: BOOLEAN = True
			-- Is hidden for debugger?

	object_address: DBG_ADDRESS

feature -- Output

	object_address_to_string: STRING
		do
			if object_address /= Void then
				Result := object_address.output
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
