indexing
	description: "Page to set the geometrical attributes."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class GEOMETRY_FORM

inherit
	EDITOR_FORM
		redefine
			initialize, context
		end

creation
	make

feature {NONE} -- Initialization

	initialize (par: EV_CONTAINER) is
		local
			hbox: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			cmd: CONTEXT_CMD
			arg: EV_ARGUMENT1 [CONTEXT_EDITOR]
		do
			Precursor (par)
			set_spacing (5)
			create arg.make (editor)

			create hbox.make (Current)
			create text_field_x.make_with_label (hbox, Widget_names.X_string_name)
			create text_field_y.make_with_label (hbox, Widget_names.Y_string_name) 
			create {SET_POSITION_CMD} cmd
			text_field_x.add_return_command (cmd, arg)
			text_field_y.add_return_command (cmd, arg)

			create hbox.make (Current)
			create text_field_width.make_with_label (hbox, Widget_names.width_name)
			create text_field_height.make_with_label (hbox, Widget_names.height_name)
			create {SET_SIZE_CMD} cmd
			text_field_width.add_return_command (cmd, arg)
			text_field_height.add_return_command (cmd, arg)
			text_field_x.label.set_minimum_width (text_field_width.label.width)
			text_field_y.label.set_minimum_width (text_field_height.label.height)

			create forbid_resize_b.make_with_text (Current, Widget_names.forbid_resize_name)
			create {WINDOW_RESIZE_CMD} cmd
			forbid_resize_b.add_toggle_command (cmd, arg)

			create hbox.make (Current)
			create minimum_width_field.make_with_label (hbox, Widget_names.minimum_width_name)
			create minimum_height_field.make_with_label (hbox, Widget_names.minimum_height_name)
			create {SET_MINIMUM_SIZE_CMD} cmd
			minimum_width_field.add_return_command (cmd, arg)
			minimum_height_field.add_return_command (cmd, arg)

			create hbox.make (Current)
			create width_resizable_b.make_with_text (hbox, Widget_names.width_resizable_name)
			create {SET_HORIZONTAL_RESIZE_CMD} cmd
			width_resizable_b.add_toggle_command (cmd, arg)

			create height_resizable_b.make_with_text (hbox, Widget_names.height_resizable_name)
			create {SET_VERTICAL_RESIZE_CMD} cmd
			height_resizable_b.add_toggle_command (cmd, arg)

--			create expandable_b.make_with_text (Current, Widget_names.expandable_name)
--			create {SET_EXPAND_CMD} cmd
--			expandable_b.add_toggle_command (cmd, arg)

			create frame.make_with_text (Current, Widget_names.container_name)
			create vbox.make (frame)
			create hbox.make (vbox)
			create spacing_field.make_with_label (hbox, Widget_names.spacing_name)
			create {SET_SPACING_CMD} cmd
			spacing_field.add_return_command (cmd, arg)

			create border_width_field.make_with_label (hbox, Widget_names.border_width_name)
			create {SET_BORDER_WIDTH_CMD} cmd
			border_width_field.add_return_command (cmd, arg)
			create homogeneous_b.make_with_text (vbox, Widget_names.homogeneous_name)
			create {SET_HOMOGENEOUS_CMD} cmd
			homogeneous_b.add_toggle_command (cmd, arg)
		end

feature {NONE} -- GUI attributes

	text_field_x, text_field_y: INTEGER_TEXT_FIELD

	text_field_width, text_field_height: INTEGER_TEXT_FIELD

	forbid_resize_b, homogeneous_b: EV_CHECK_BUTTON

	width_resizable_b, height_resizable_b, expandable_b: EV_CHECK_BUTTON

	minimum_width_field, minimum_height_field,
	spacing_field, border_width_field: INTEGER_TEXT_FIELD

	frame: EV_FRAME

	context: WIDGET_C is
		do
			Result ?= Precursor
		end

feature -- Access

	reset is
		local
			wind_c: WINDOW_C
			inv_cont: INVISIBLE_CONTAINER_C
		do
			if context.managed then
				text_field_x.set_editable (False)
				text_field_y.set_editable (False)
				text_field_width.set_editable (False)
				text_field_height.set_editable (False)
			else
				text_field_x.set_editable (True)
				text_field_y.set_editable (True)
				text_field_width.set_editable (True)
				text_field_height.set_editable (True)
			end
			if context.is_movable then
				text_field_x.set_int_value (context.x)
				text_field_x.show
				text_field_y.set_int_value (context.y)
				text_field_y.show
			else
				text_field_x.hide
				text_field_y.hide
			end
			if context.is_resizable then
				text_field_width.set_int_value (context.width)
				text_field_width.show
				text_field_height.set_int_value (context.height)
				text_field_height.show
			else
				text_field_width.hide
				text_field_height.hide
			end

			if context.is_window then
				wind_c ?= context
				forbid_resize_b.set_state (wind_c.resize_policy_disabled)
				forbid_resize_b.show
			else
				forbid_resize_b.hide
			end

			minimum_width_field.set_int_value (context.minimum_width)
			minimum_height_field.set_int_value (context.minimum_height)

			width_resizable_b.set_state (context.horizontal_resizable)
			height_resizable_b.set_state (context.vertical_resizable)
--			expandable_b.set_state (context.expandable)

			if context.is_invisible_container
			and then not context.is_fixed then
				inv_cont ?= context
				border_width_field.set_int_value (inv_cont.border_width)
				spacing_field.set_int_value (inv_cont.spacing)
				homogeneous_b.set_state (inv_cont.is_homogeneous)
				frame.show
			else
				frame.hide
			end
		end

	apply is
		local
			wind_c: WINDOW_C
			inv_cont: INVISIBLE_CONTAINER_C
		do
			if not text_field_x.same_value (context.x) then
				context.set_x (text_field_x.int_value)
			end
			if not text_field_y.same_value (context.y) then
				context.set_y (text_field_y.int_value)
			end
			if text_field_width.int_value > 0
			and then not text_field_width.same_value (context.width)
			then
				context.set_width (text_field_width.int_value)
			end
			if text_field_height.int_value > 0
			and then not text_field_height.same_value (context.height)
			then
				context.set_height (text_field_height.int_value)
			end
			if context.is_window then
				wind_c ?= context
				if forbid_resize_b.state /= wind_c.resize_policy_disabled then
					wind_c.disable_resize_policy (forbid_resize_b.state)
				end
			end
			if minimum_width_field.int_value >= 0
			and then not minimum_width_field.same_value (context.minimum_width)
			then
				context.set_minimum_width (minimum_width_field.int_value)
			end
			if minimum_height_field.int_value >= 0
			and then not minimum_height_field.same_value (context.minimum_height)
			then
				context.set_minimum_height (minimum_height_field.int_value)
			end
			if width_resizable_b.state /= context.horizontal_resizable then
				context.set_horizontal_resize (width_resizable_b.state)
			end
			if height_resizable_b.state /= context.vertical_resizable then
				context.set_vertical_resize (height_resizable_b.state)
			end
--			if expandable_b.state /= context.expandable then
--				context.set_expand (expandable_b.state)
--			end

			if context.is_invisible_container then
				inv_cont ?= context
				if border_width_field.int_value >= 0
				and then not border_width_field.same_value (border_width_field.int_value)
				then
					inv_cont.set_border_width (border_width_field.int_value)
				end
				if spacing_field.int_value >= 0
				and then not spacing_field.same_value (inv_cont.spacing)
				then
					inv_cont.set_spacing (spacing_field.int_value)
				end
				if homogeneous_b.state /= inv_cont.is_homogeneous then
					inv_cont.set_homogeneous (homogeneous_b.state)
				end
			end
		end

end -- class GEOMETRY_FORM

