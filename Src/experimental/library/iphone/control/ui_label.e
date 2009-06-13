note
	description: "Label"
	date: "$Date$"
	revision: "$Revision$"

class
	UI_LABEL

inherit
	UI_VIEW

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make (a_rect: CG_RECT)
			-- New instance of label located at `a_rect' coordinates.
		do
			allocate_object
			init_with_frame (a_rect)
		end

	make_with_text (a_text: STRING_32; a_rect: CG_RECT)
			-- New instance of label located at `a_rect' coordinates with `a_text' content.
		do
			make (a_rect)
			set_text (a_text)
		end

feature -- Settings

	set_text (a_text: STRING_32)
			-- Set `text' of Current with `a_text'.
		require
			exists: exists
		local
			l_str: NS_STRING
		do
			create l_str.make_with_string (a_text)
			c_set_text (item, l_str.item)
		ensure
			text_set: -- text ~ a_text
		end

	set_background_color (a_color: UI_COLOR)
			-- Set `background_color' of Current with `a_color'.
		require
			exists: exists
			color_exists: a_color.exists
		do
			c_set_background_color (item, a_color.item)
		ensure
			background_color_set: -- background_color ~ a_color
		end

	set_foreground_color (a_color: UI_COLOR)
			-- Set `foreground_color' of Current with `a_color'.
		require
			exists: exists
			color_exists: a_color.exists
		do
			c_set_foreground_color (item, a_color.item)
		ensure
			background_color_set: -- foreground_color ~ a_color
		end

	align_text_left
			-- Set alignment of current to the left.
		require
			exists: exists
		do
			c_set_alignment (item, 1)
		end

	align_text_center
			-- Set alignment of current to the center.
		require
			exists: exists
		do
			c_set_alignment (item, 2)
		end

	align_text_right
			-- Set alignment of current to the right.
		require
			exists: exists
		do
			c_set_alignment (item, 3)
		end

feature {NONE} -- Implementation

	iphone_class_name: IMMUTABLE_STRING_8
		once
			create Result.make_from_string ("UILabel")
		end

feature {NONE} -- C externals

	c_new_label (a_rect_ptr: POINTER): POINTER
		require
			a_rect_ptr_not_null: a_rect_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [[UILabel alloc] initWithFrame:*(CGRect *) $a_rect_ptr];"
		end

	c_set_text (a_label_ptr, a_text_ptr: POINTER)
		require
			a_label_ptr_not_null: a_label_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UILabel *) $a_label_ptr).text = (NSString *) $a_text_ptr;"
		end

	c_set_background_color (a_label_ptr, a_color_ptr: POINTER)
		require
			a_label_ptr_not_null: a_label_ptr /= default_pointer
			a_color_ptr_not_null: a_color_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UILabel *) $a_label_ptr).backgroundColor = (UIColor *) $a_color_ptr;"
		end

	c_set_foreground_color (a_label_ptr, a_color_ptr: POINTER)
		require
			a_label_ptr_not_null: a_label_ptr /= default_pointer
			a_color_ptr_not_null: a_color_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UILabel *) $a_label_ptr).textColor = (UIColor *) $a_color_ptr;"
		end

	c_set_alignment (a_label_ptr: POINTER; a_alignment_kind: INTEGER)
		require
			a_label_ptr_not_null: a_label_ptr /= default_pointer
			proper_alignment_kind: a_alignment_kind >= 1 and a_alignment_kind <= 3
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[
			switch ($a_alignment_kind) {
				case 1: ((UILabel *) $a_label_ptr).textAlignment = UITextAlignmentLeft; break;
				case 2: ((UILabel *) $a_label_ptr).textAlignment = UITextAlignmentCenter; break;
				case 3: ((UILabel *) $a_label_ptr).textAlignment = UITextAlignmentRight; break;
				default:
					;
			}
			]"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
