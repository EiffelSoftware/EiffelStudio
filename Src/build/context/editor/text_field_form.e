indexing
	description: "Page representing the properties of a TEXT_FIELD."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEXT_FIELD_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature {NONE}

	maximum_size: INTEGER_TEXT_FIELD

	context: TEXT_FIELD_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.text_field_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	text_field_cmd: TEXT_F_CMD is
		once
			!! Result
		end

feature

	make_visible (a_parent: COMPOSITE) is
		local
			size_l: LABEL
		do
			initialize (Widget_names.text_field_form_name, a_parent)

			!! maximum_size.make (Widget_names.maximum_size_name, 
					Current, Text_field_cmd, editor)
			!! size_l.make (Widget_names.maximum_size_name, Current)
			maximum_size.set_width (50)

			attach_left (size_l, 10)
			attach_right_widget (maximum_size, size_l, 5)
			attach_right (maximum_size, 10)

			attach_top (size_l, 15)
			attach_top (maximum_size, 10)
--			attach_bottom (maximum_size, 0)
--			attach_bottom (size_l, 0)
			show_current
		end

	reset is
			-- reset the content of the form
		do
			maximum_size.set_int_value (context.maximum_size)
		end

	apply is
			-- update the context according to the content of the form
		do
			context.set_maximum_size (maximum_size.int_value)
		end

end
