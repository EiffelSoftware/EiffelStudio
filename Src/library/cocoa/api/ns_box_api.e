note
	description: "Summary description for {NS_BOX_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BOX_API

feature -- Access

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBox new];"
		end

	frozen content_view (a_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBox*)$a_box contentView];"
		end

	frozen set_border_type (a_box: POINTER; a_border_type: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setBorderType: $a_border_type];"
		end

	frozen border_type (a_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBox*)$a_box borderType];"
		end

	frozen set_border_width (a_box: POINTER; a_border_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setBorderWidth: $a_border_width];"
		end

	frozen set_content_view (a_box: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setContentView: $a_view];"
		end

	frozen set_content_view_margins (a_box: POINTER; a_width, a_height: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setContentViewMargins: NSMakeSize($a_width, $a_height)];"
		end

	frozen set_corner_radius (a_box: POINTER; a_corner_radius: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setCornerRadius: $a_corner_radius];"
		end

	frozen set_fill_color (a_box: POINTER; a_fill_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setFillColor: $a_fill_color];"
		end

	frozen set_title (a_box: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setTitle: $a_nsstring];"
		end

	frozen set_title_position (a_box: POINTER; a_position: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setTitlePosition: $a_position];"
		end

	frozen title_position (a_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBox*)$a_box titlePosition];"
		end

	frozen set_box_type (a_box: POINTER; a_box_type: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setBoxType: $a_box_type];"
		end
end
