indexing 
	description:
		"Facilities for direct drawing to a printer."
	status: "See notice at end of class"
	keywords: "printer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINTER

inherit
	EV_DRAWABLE
		redefine
			implementation,
			create_implementation
		end

create {EV_PRINT_PROJECTOR_IMP}
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_dc: WEL_PRINTER_DC) is
			-- Set `printer_dc' to `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		do
			-- default_create not being called as initialization relies on `a_dc'.
			default_create_called := True
			create_implementation
			implementation.set_printer_dc (a_dc)
			implementation.initialize
			initialize
		end

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PRINTER_IMP} implementation.make (Current)
		end

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		ensure then
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure then
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end

feature -- Status setting

	start_document is
		do
			implementation.start_document
		end

	end_document is
		do
			implementation.end_document
		end
	
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PRINTER_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_PRINTER

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

