indexing
	description: "Control window."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROL_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			class_name as wel_class_name,
			exists as wel_exists,
			font as wel_font,
			has_capture as wel_has_capture,
			has_heavy_capture as wel_has_heavy_capture,
			invalidate_rect as wel_invalidate_rect,
			item as wel_item,
			release_capture as wel_release_capture,
			set_capture as wel_set_capture,
			set_focus as wel_set_focus,
			set_font as wel_set_font,
			set_item as wel_set_item,
			scroll as wel_scroll
		undefine
			on_wm_paint,
			on_paint
		end
	
	WEL_UNIT_CONVERSION
		export
			{NONE} all
		end
	
	DVASPECT_ENUM
		export
			{NONE} all
		end

	OLEIVERB_ENUM
		export
			{NONE} all
		end

feature {NONE} -- Implementation
		
	m_position: TAG_RECT_RECORD
			-- Client rectangle.

end -- class CONTROL_WINDOW
