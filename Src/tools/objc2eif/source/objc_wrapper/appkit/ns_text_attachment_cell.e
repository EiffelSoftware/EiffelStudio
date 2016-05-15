note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_ATTACHMENT_CELL

inherit
	NS_CELL
		redefine
			wrapper_objc_class_name
		end

	NS_TEXT_ATTACHMENT_CELL_PROTOCOL
		undefine
			draw_with_frame__in_view_,
			objc_draw_with_frame__in_view_,
			highlight__with_frame__in_view_,
			objc_highlight__with_frame__in_view_,
			track_mouse__in_rect__of_view__until_mouse_up_,
			objc_track_mouse__in_rect__of_view__until_mouse_up_,
			cell_size,
			objc_cell_size
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextAttachmentCell"
		end

end
