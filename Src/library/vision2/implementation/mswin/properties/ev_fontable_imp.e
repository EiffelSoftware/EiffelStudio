indexing
	description:"EiffelVision fontable, mswindows implementation."
	note : "When a heir of this class inherits from a WEL object,%
			% it needs to rename `font' as `wel_font' and%
			% `set_font' as `wel_set_font'"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I

feature -- Access

	font: EV_FONT is
			-- Font of `Current'.
		local
			font_imp: EV_FONT_IMP
			private_font_twin: WEL_FONT
		do
			if private_font = Void then
				create Result
				font_imp ?= Result.implementation
				create private_font_twin.make_indirect (private_wel_font.log_font)
				font_imp.set_by_wel_font (private_font_twin)
				private_font_twin := Void
				private_font := Result
				private_wel_font := Void
			else
				create Result.make_with_values (private_font.family, private_font.weight, private_font.shape, private_font.height)
						-- We must be sure to copy `preferred_families'.
					if private_font.preferred_families /= Void and not private_font.preferred_families.is_empty then
						font_imp ?= Result.implementation
						font_imp.preferred_families.append (private_font.preferred_families)
					end
			end
		end
		
	internal_font: EV_FONT is
			-- Font of `Current' for internal queries.
			-- Faster than calling `font' as we do not need to
			-- create a new EV_FONT every time.
		do
			if private_font = Void then
				Result := font
			else
				Result := private_font
			end
		end

feature -- Status setting

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		local
			local_font_windows: EV_FONT_IMP
		do
			private_font := ft
			local_font_windows ?= private_font.implementation
			check
				valid_font: local_font_windows /= Void
			end
			wel_set_font (local_font_windows.wel_font)

				-- We don't need the WEL private font anymore since it is set by user.
			private_wel_font := Void
		end

	set_default_font is
			-- Make system to use default font.
		do
			private_wel_font := wel_default_font
			wel_set_font (wel_default_font)
		end

feature {EV_ANY_I} -- Implementation

	private_font: EV_FONT
			-- font used for implementation

	private_wel_font: WEL_FONT
			-- WEL font used for implementation

feature {NONE} -- Implementation : The wel values, are deferred here, but
			   -- they need to be defined by their heirs.

	wel_default_font: WEL_FONT is
			-- Default font of system.
		once
			Result := (create {WEL_SHARED_FONTS}).gui_font
		end

	wel_font: WEL_FONT is
			-- The wel_font
		deferred
		end

	wel_set_font (a_font: WEL_FONT) is
			-- Make `a_font' the new font of the widget.
		deferred
		end

end -- class EV_FONTABLE_IMP

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

