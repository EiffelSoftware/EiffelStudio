note
	description: "[
					Enumeration for COM HRESULT
																	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COM_HRESULT

feature -- Query

	s_ok: NATURAL_32 = 0x00000000

	s_false: NATURAL_32 = 0x00000001

	e_invalid_arg: NATURAL_32 = 0x80070057

	e_out_of_memory: NATURAL_32 = 0x8007000E

	e_unexpected: NATURAL_32 = 0x8000FFFF

	e_not_impl: NATURAL_32 = 0x80004001

	e_fail: NATURAL_32 = 0x80004005

	e_pointer: NATURAL_32 = 0x80004003

	e_handle: NATURAL_32 = 0x80070006

	e_abort: NATURAL_32 = 0x80004004

	e_access_denied: NATURAL_32 = 0x80070005

	e_no_interface: NATURAL_32 = 0x80004002

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
