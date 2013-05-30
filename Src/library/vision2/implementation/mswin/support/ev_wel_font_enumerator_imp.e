note
	description: "[
		Facilities to find supported font for the current system.

		Note: Do not use more than one instance of this class at the same
			time. Nested enumerations are not supported.
		]"
	legal: "See notice at end of class."
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

	is_font_face_supported (a_face_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_font_face' supported on the current system?
		require
			a_face_name_valid:
				a_face_name /= Void and then
				not a_face_name.is_empty
		do
			Result := font_faces.has (a_face_name.as_string_32)
		end

	font_faces: ARRAYED_LIST [STRING_32]
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

	text_metrics: detachable HASH_TABLE [WEL_TEXT_METRIC, STRING_32]
			-- Text metrics found on system, accessible by face name.
			-- Any metrics that share the same face name will not be accessible,
			-- only the first found.
		note
			option: stable
		attribute
		end;

	log_fonts: detachable HASH_TABLE [WEL_LOG_FONT, STRING_32]
			-- Log fonts found on system accessible by face name.
			-- Any metrics that share the same face name will not be accessible,
			-- only the first found.
		note
			option: stable
		attribute
		end;

feature {NONE} -- Basic operations

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER)
			-- Called for each font found.
			-- `elf', `tm' and `font_type' contain informations
			-- about the font.
			-- See class WEL_FONT_TYPE_ENUM_CONSTANTS for
			-- `font_type' values.
		local
			face_found: STRING_32
		do
			face_found := elf.log_font.face_name.twin
			if internal_font_faces = Void then
				check internal_font_faces /= Void end
			elseif not internal_font_faces.has (face_found) then
				internal_font_faces.extend (face_found)
			end
			if text_metrics = Void then
				check text_metrics /= Void end
			else
				text_metrics.put (tm.twin, face_found)
			end
			if log_fonts = Void then
				check log_fonts /= Void end
			else
				log_fonts.put (elf.log_font, face_found)
			end
		end

	internal_font_faces: detachable ARRAYED_LIST [STRING_32]
			-- Font faces found on the current system.
		note
			option: stable
		attribute
		end;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WEL_FONT_ENUMERATOR_IMP












