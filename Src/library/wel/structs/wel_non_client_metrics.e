indexing
	description	: "The NONCLIENTMETRICS structure contains the scalable metrics%
				  %associated with the nonclient area of a nonminimized window.%
				  %This structure is used by the SPI_GETNONCLIENTMETRICS and %
				  %SPI_SETNONCLIENTMETRICS actions of SystemParametersInfo"
	date		: "$Date$"
	revision	: "$Revision$"


class
	WEL_NON_CLIENT_METRICS

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make

feature {NONE} -- Initialization
	
	make is
			-- Create a new structure.
		do
			structure_make
			set_structure_size (structure_size)
		end

feature -- Access

	border_width: INTEGER is
			-- Specifies the thickness, in pixels, of the sizing border. 
		do
			Result := cwel_nonclientmetrics_get_border_width (item)
		ensure
			positive_result: Result >= 0
		end

	scroll_width: INTEGER is
			-- Specifies the width, in pixels, of a standard vertical scroll bar. 
		do
			Result := cwel_nonclientmetrics_get_scroll_width (item)
		ensure
			positive_result: Result >= 0
		end

	scroll_height: INTEGER is
			-- Specifies the height, in pixels, of a standard horizontal scroll bar. 
		do
			Result := cwel_nonclientmetrics_get_scroll_height (item)
		ensure
			positive_result: Result >= 0
		end

	caption_width: INTEGER is
			-- Specifies the width, in pixels, of caption buttons. 
		do
			Result := cwel_nonclientmetrics_get_caption_width (item)
		ensure
			positive_result: Result >= 0
		end

	caption_height: INTEGER is
			-- Specifies the height, in pixels, of caption buttons. 
		do
			Result := cwel_nonclientmetrics_get_caption_height (item)
		ensure
			positive_result: Result >= 0
		end

	caption_font: WEL_LOG_FONT is
			-- Contains information about the caption font. 
		do
			create Result.make_with_pointer (cwel_nonclientmetrics_get_caption_font (item))
		ensure
			valid_result: Result /= Void and then Result.exists
		end

	small_caption_width: INTEGER is
			-- Specifies the width, in pixels, of caption buttons. 
		do
			Result := cwel_nonclientmetrics_get_small_caption_width (item)
		ensure
			positive_result: Result >= 0
		end

	small_caption_height: INTEGER is
			-- Specifies the height, in pixels, of caption buttons. 
		do
			Result := cwel_nonclientmetrics_get_small_caption_height (item)
		ensure
			positive_result: Result >= 0
		end

	small_caption_font: WEL_LOG_FONT is
			-- Contains information about the caption font. 
		do
			create Result.make_with_pointer (cwel_nonclientmetrics_get_small_caption_font (item))
		ensure
			valid_result: Result /= Void and then Result.exists
		end

	menu_width: INTEGER is
			-- Specifies the width, in pixels, of menu-bar buttons. 
		do
			Result := cwel_nonclientmetrics_get_menu_width (item)
		ensure
			positive_result: Result >= 0
		end

	menu_height: INTEGER is
			-- Specifies the height, in pixels, of a menu bar. 
		do
			Result := cwel_nonclientmetrics_get_menu_height (item)
		ensure
			positive_result: Result >= 0
		end

	menu_font: WEL_LOG_FONT is
			-- Contains information about the font used in menu bars. 
		do
			create Result.make_with_pointer (cwel_nonclientmetrics_get_menu_font (item))
		ensure
			valid_result: Result /= Void and then Result.exists
		end

	status_font: WEL_LOG_FONT is
			-- Contains information about the font used in status bars and tooltips. 
		do
			create Result.make_with_pointer (cwel_nonclientmetrics_get_status_font (item))
		ensure
			valid_result: Result /= Void and then Result.exists
		end

	message_font: WEL_LOG_FONT is
			-- Contains information about the font used in message boxes. 
		do
			create Result.make_with_pointer (cwel_nonclientmetrics_get_message_font (item))
		ensure
			valid_result: Result /= Void and then Result.exists
		end

feature -- Element change

	set_structure_size (a_size: INTEGER) is
			-- Set the structure size to `a_size'. 
		do
			cwel_nonclientmetrics_set_structure_size (item, a_size)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nonclientmetrics
		end

feature {NONE} -- Implementation

	c_size_of_nonclientmetrics: INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		alias
			"sizeof (NONCLIENTMETRICS)"
		end

	cwel_nonclientmetrics_set_structure_size (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_border_width (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_scroll_width (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_scroll_height (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_caption_width (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_caption_height (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_caption_font (ptr: POINTER): POINTER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_small_caption_width (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_small_caption_height (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_small_caption_font (ptr: POINTER): POINTER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_menu_width (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_menu_height (ptr: POINTER): INTEGER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_menu_font (ptr: POINTER): POINTER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_status_font (ptr: POINTER): POINTER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

	cwel_nonclientmetrics_get_message_font (ptr: POINTER): POINTER is
		external
			"C [macro <nonclientmetrics.h>]"
		end

end -- class WEL_NON_CLIENT_METRICS
