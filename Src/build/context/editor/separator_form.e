indexing
	description: "Page representing the properties of a SEPARATOR."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SEPARATOR_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature {NONE}

	is_vertical: EB_TOGGLE_B

	b_no_line, b_single_line, b_double_line: EB_TOGGLE_B
	b_single_dashed_line, b_double_dashed_line: EB_TOGGLE_B

	context: SEPARATOR_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.separator_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	sep_dir_cmd: SEP_DIR_CMD is
		once
			!!Result
		end

	sep_line_cmd: SEP_LINE_CMD is
		once
			!!Result
		end

feature

	make_visible (a_parent: COMPOSITE) is
		local
			line_style: LABEL
			radio_b: RADIO_BOX
		do
			initialize (Widget_names.separator_form_name, a_parent)

			!!is_vertical.make (Widget_names.vertical_name, 
					Current, Sep_dir_cmd, editor)
			!!line_style.make (Widget_names.line_style_name, Current)
			!!radio_b.make (Widget_names.row_column, Current)
			!!b_single_line.make (Widget_names.single_name, 
					radio_b, Sep_line_cmd, editor)
			!!b_single_dashed_line.make (Widget_names.single_dashed_name, 
					radio_b, Sep_line_cmd, editor)
			!!b_double_line.make (Widget_names.double_name, radio_b, 
					Sep_line_cmd, editor)
			!!b_double_dashed_line.make (Widget_names.double_dashed_name, 
					radio_b, Sep_line_cmd, editor)
			!!b_no_line.make (Widget_names.no_line_name, radio_b, 
					Sep_line_cmd, editor)

			radio_b.set_always_one (True)

			attach_left (is_vertical, 10)
			attach_left (line_style, 10)
--			attach_left (radio_b, 100)
			attach_right_widget (radio_b, line_style, 15)
			attach_right (radio_b, 10)

			attach_top (is_vertical, 10)
			attach_top_widget (is_vertical, line_style, 10)
			attach_top_widget (is_vertical, radio_b, 10)
			attach_bottom (line_style, 0)
			attach_bottom (radio_b, 0)
--			attach_bottom (radio_b, 50)
			show_current
		end

	
feature {NONE}

	reset is
		local
			l_mode: INTEGER
		do
			is_vertical.set_state (context.is_vertical)
			l_mode := context.line_mode
			b_no_line.set_toggle_off
			b_double_line.set_toggle_off
			b_single_dashed_line.set_toggle_off
			b_double_dashed_line.set_toggle_off
			b_single_line.set_toggle_off
			if l_mode = Context_const.no_line then
				b_no_line.set_toggle_on
			elseif l_mode = Context_const.double_line then
				b_double_line.set_toggle_on
			elseif l_mode = Context_const.single_dashed_line  then
				b_single_dashed_line.set_toggle_on
			elseif l_mode = Context_const.double_dashed_line then
				b_double_dashed_line.set_toggle_on
			else
				b_single_line.set_toggle_on
			end
		end

	
feature 

	apply is
		do
			if context.is_vertical /= is_vertical.state then
				context.set_size (context.height, context.width)
				context.set_vertical (is_vertical.state)
			end
			if new_mode /= context.line_mode then
				context.set_line (new_mode)
			end
		end

	
feature {NONE}

	new_mode: INTEGER is
		do
			if b_no_line.state then
				Result := Context_const.no_line
			elseif b_single_line.state then
				Result := Context_const.single_line
			elseif b_double_line.state then
				Result := Context_const.double_line
			elseif b_single_dashed_line.state then
				Result := Context_const.single_dashed_line
			else
				Result := Context_const.double_dashed_line
			end
		end

end
