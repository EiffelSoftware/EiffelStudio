indexing
	description: "Page representing the properties of a SCROLLABLE_LIST."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SCROLL_L_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature {NONE}

	visible_item_count: INTEGER_TEXT_FIELD
	
	context: SCROLLABLE_LIST_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.scroll_l_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	List_count_cmd: LIST_COUNT_CMD is
		once
			!! Result
		end

feature

	make_visible (a_parent: COMPOSITE) is
		local
			visible_label: LABEL
		do
			initialize (Widget_names.scroll_list_form_name, a_parent)

			!! visible_label.make (Widget_names.visible_items_name, Current)
			!! visible_item_count.make (Widget_names.textfield, 
					Current, List_count_cmd, editor)

			visible_item_count.set_width (50)

			attach_left (visible_label, 10)
			attach_right_widget (visible_item_count, visible_label, 5)
			attach_right (visible_item_count, 10)

			attach_top (visible_label, 15)
			attach_top (visible_item_count, 10)
			show_current
		end

feature {NONE}

	reset is
		do
			visible_item_count.set_int_value (context.visible_item_count)
		end

feature 

	apply is
		do
			if not visible_item_count.same_value 
					(context.visible_item_count) 
			then
				if visible_item_count.int_value > 0 then
					context.set_visible_item_count (visible_item_count.int_value)
				else
					reset
				end
			end
		end

end
