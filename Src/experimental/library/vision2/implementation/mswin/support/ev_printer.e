note
	description: "Facilities for direct drawing to a printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINTER

inherit
	EV_DRAWABLE
		redefine
			implementation
		end

create {EV_PRINT_PROJECTOR_IMP, EV_MODEL_PRINT_PROJECTOR_IMP}
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_dc: WEL_PRINTER_DC)
			-- Set `printer_dc' to `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		do
				-- default_create not being called as initialization relies on `a_dc'.
			create {EV_PRINTER_IMP} implementation.make_with_dc (a_dc)
			implementation.set_state_flag ({EV_ANY_I}.interface_default_create_called_flag, True)
			set_default_colors
			initialize
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			-- Do nothing
		end

feature -- Measurement

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		ensure then
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure then
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end

feature -- Status setting

	start_document
		do
			implementation.start_document
		end

	end_document
		do
			implementation.end_document
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PRINTER_I;
			-- Responsible for interaction with the native graphics toolkit.

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
