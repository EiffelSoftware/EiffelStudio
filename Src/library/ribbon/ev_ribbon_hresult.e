note
	description: "Summary description for {EV_RIBBON_HRESULT}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_HRESULT

feature -- Query

	s_ok: NATURAL_32 = 0x00000000
			--
	s_false: NATURAL_32 = 0x00000001

	e_invalidarg: NATURAL_32 = 0x80070057

	e_outofmemory: NATURAL_32 = 0x8007000E

	e_unexpected: NATURAL_32 = 0x8000FFFF

	e_notimpl: NATURAL_32 = 0x80004001

	e_fail: NATURAL_32 = 0x80004005

	e_pointer: NATURAL_32 = 0x80004003

	e_handle: NATURAL_32 = 0x80070006

	e_abort: NATURAL_32 = 0x80004004

	e_accessdenied: NATURAL_32 = 0x80070005

	E_NOINTERFACE: NATURAL_32 = 0x80004002

end
