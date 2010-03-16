note
	description: "[
		Objects providing byte code support for testing facilities.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EXTERNALS

feature -- Basic operations

	frozen eif_override_byte_code_of_body (a_body_id: INTEGER; a_pattern_id: INTEGER; a_byte_code: POINTER; a_length: INTEGER)
			-- Store `a_byte_code' of `a_length' byte long for feature with `a_body_id'.
		require
			a_body_id_not_negative: a_body_id >= 0
			a_byte_code_attached: a_byte_code /= default_pointer
			a_length_positive: a_length > 0
		external
			"C inline use %"eif_interp.h%""
		alias
			"[
#ifdef WORKBENCH
			eif_override_byte_code_of_body ((int) $a_body_id, (int) $a_pattern_id, (unsigned char *) $a_byte_code, (int) $a_length);
#endif
			]"
		end

	pointer_for_byte_code (a_byte_code_string: STRING): POINTER
			-- pointer representation for `a_byte_code_string'
		require
			a_byte_code_string_attached: a_byte_code_string /= Void
		local
			l_managed_ptr: MANAGED_POINTER
			l_count: INTEGER
			i: INTEGER
		do
			l_count := a_byte_code_string.count
			create l_managed_ptr.make (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_managed_ptr.put_character (a_byte_code_string.item (i), i - 1)
				i := i + 1
			end
			Result := l_managed_ptr.item
		ensure
			result_attached: Result /= default_pointer
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
