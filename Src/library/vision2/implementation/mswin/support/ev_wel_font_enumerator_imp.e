indexing
	description: "Facilities to find supported font for the current %
		%system."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested enumerations are not supported."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_FONT_ENUMERATOR_IMP

inherit
	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as process
		export
			{NONE} all
		end

create
	default_create

feature {EV_FONT_IMP} -- Basic operations
	
	is_font_face_supported (a_face_name: STRING): BOOLEAN is
			-- Is `a_font_face' supported on the current system?
		require
			a_face_name_valid: 
				a_face_name /= Void and then
				not a_face_name.is_empty
		local
			search_face: STRING
		do
			search_face := clone (a_face_name)
			search_face.to_lower
			Result := font_faces.has (a_face_name)
		end

	font_faces: ARRAYED_LIST [STRING] is
			-- List of all installed fonts on the system.
		local
			screen_dc: WEL_SCREEN_DC
		do
			if internal_font_faces = Void then
				create internal_font_faces.make (20)
				internal_font_faces.compare_objects
			
					-- Enumerate installed fonts
				create screen_dc
				screen_dc.get
				process (screen_dc, Void)
				screen_dc.release
			end

			Result := internal_font_faces
		end

feature {NONE} -- Basic operations

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER) is
			-- Called for each font found.
			-- `elf', `tm' and `font_type' contain informations
			-- about the font.
			-- See class WEL_FONT_TYPE_ENUM_CONSTANTS for
			-- `font_type' values.
		local
			face_found: STRING
		do
			face_found := clone (elf.log_font.face_name)
			face_found.to_lower
			if not internal_font_faces.has (face_found) then
				internal_font_faces.extend (face_found)
			end
		end

	internal_font_faces: ARRAYED_LIST [STRING]
			-- Font faces found on the current system.

end -- class EV_WEL_FONT_ENUMERATOR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

