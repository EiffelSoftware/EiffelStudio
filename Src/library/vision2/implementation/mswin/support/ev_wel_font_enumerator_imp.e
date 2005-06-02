indexing
	description: "[
		Facilities to find supported font for the current system.

		Note: Do not use more than one instance of this class at the same
			time. Nested enumerations are not supported.
		]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_FONT_ENUMERATOR_IMP

inherit
	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as process
		end

create
	default_create

feature {EV_FONT_IMP, EV_ENVIRONMENT_IMP} -- Basic operations
	
	is_font_face_supported (a_face_name: STRING): BOOLEAN is
			-- Is `a_font_face' supported on the current system?
		require
			a_face_name_valid: 
				a_face_name /= Void and then
				not a_face_name.is_empty
		local
			search_face: STRING
		do
			search_face := a_face_name.twin
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
				create text_metrics.make (20)
				create log_fonts.make (20)
				internal_font_faces.compare_objects
			
					-- Enumerate installed fonts
				create screen_dc
				screen_dc.get
				process (screen_dc, Void)
				screen_dc.release
			end

			Result := internal_font_faces
		end
		
	text_metrics: HASH_TABLE [WEL_TEXT_METRIC, STRING]
			-- Text metrics found on system, accessible by face name.
			-- Any metrics that share the same face name will not be accessible,
			-- only the first found.
			
	log_fonts: HASH_TABLE [WEL_LOG_FONT, STRING]
			-- Log fonts found on system accessible by face name.
			-- Any metrics that share the same face name will not be accessible,
			-- only the first found.

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
			face_found := elf.log_font.face_name.twin
			if not internal_font_faces.has (face_found) then
				internal_font_faces.extend (face_found)
			end
			text_metrics.put (tm.twin, face_found)
			log_fonts.put (elf.log_font, face_found)
		end

	internal_font_faces: ARRAYED_LIST [STRING]
			-- Font faces found on the current system.		

end -- class EV_WEL_FONT_ENUMERATOR_IMP

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

