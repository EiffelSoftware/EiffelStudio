indexing
	description:"[
		EiffelVision fontable, mswindows implementation.

		Note: When a heir of this class inherits from a WEL object,
			it needs to rename `font' as `wel_font' and
			`set_font' as `wel_set_font'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	internal_font_height: INTEGER is
			-- Height required to correctly display font of `Current' in pixels.
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			if wel_font = Void then
				screen_dc.select_font ((create {WEL_SHARED_FONTS}).gui_font)
			else
				screen_dc.select_font (wel_font)
			end
			extent := screen_dc.string_size ("X")
			screen_dc.unselect_font
			screen_dc.quick_release
			Result := extent.height
		ensure
			result_non_negative: Result >= 0
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FONTABLE_IMP

