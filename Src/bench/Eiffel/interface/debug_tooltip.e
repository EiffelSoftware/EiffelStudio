indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_TOOLTIP

feature

	popup: BOOLEAN

	set_popup is
		do
			popup := True
		end

	set_popdown is
		do
			popup := False
		end

	text_field: TEXT_FIELD_FOCUS_CONTROL

	position: INTEGER

	imp: TEXT_FIELD_IMP

	restore_cursor_position is
			-- restore the cursor position after a tooltip popup
		do
			io.putstring ("restore cursor position%N")
			if text_field /= Void and then text_field.has_focus then
				io.putstring ("actual postion of the cursor: ")
				io.putint (imp.xm_text_get_insertion_position (imp.screen_object))
				io.putstring ("%Ngoing to position: ")
				io.putint (position)
				io.putstring ("%N")
				--imp.xm_text_set_insertion_position (imp.screen_object, 3)
				io.putstring ("effectively done and position := ")
				io.putint (position)
				io.putstring ("%N")
			end
		end

	set_text_field (tf: TEXT_FIELD_FOCUS_CONTROL) is
		do
			io.putstring ("set text field of debug_tooltip%N")
			text_field := tf
			imp ?= tf.implementation
		end


	set_position (i: INTEGER) is
		do
			io.putstring ("set position of debug_tooltip%N")
				position := i
			io.putstring ("new position := ")
			io.putint (i)
			io.putstring ("%N")
		end
	
end -- class DEBUG_TOOLTIP
