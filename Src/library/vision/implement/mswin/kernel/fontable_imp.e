indexing
	description:
		"Implementation of widget with a font"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class FONTABLE_IMP

feature -- Access

	font: FONT is
			-- font of current primitive
		local
			font_windows: FONT_IMP
			default_font: WEL_FONT
		do
			if exists then
				!! Result.make
				font_windows ?= Result.implementation
				check
					font_windows_not_void:
						font_windows /= Void
				end
				font_windows.make_by_wel (wel_font)
			else
				if private_font /= Void then
					Result := private_font	
				else
					!! Result.make
					!WEL_ANSI_VARIABLE_FONT! default_font.make
					font_windows ?= Result.implementation
					font_windows.make_by_wel (default_font)
				end
			end
		end

feature -- Status setting

	set_font (f: FONT) is
			-- Set `font' to `f'.
		local
			local_font_windows: FONT_IMP
		do
			private_font := f;
			if exists then
				local_font_windows ?= private_font.implementation
				check
					valid_font: local_font_windows /= Void
				end;
				wel_set_font (local_font_windows.wel_font)
			end
		end

	private_font: FONT
			-- font used for the implementation

	wel_font: WEL_FONT is
		deferred
		end

	wel_set_font (f:WEL_FONT) is
		deferred
		end

	exists: BOOLEAN is
		deferred
		end

end -- class FONTABLE_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

