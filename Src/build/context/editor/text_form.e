indexing
	description: "Page representing the properties of a SCROLLED_T."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEXT_FORM

inherit
	EDITOR_FORM
		redefine
			initialize, context
		end

	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	initialize (par: EV_CONTAINER) is
		local
			cmd: CONTEXT_CMD
			arg: EV_ARGUMENT1 [CONTEXT_EDITOR]
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			tbar: EV_TOOL_BAR
			tb_button: EV_TOOL_BAR_BUTTON
			rcmd: EV_ROUTINE_COMMAND
			arg1: EV_ARGUMENT1 [EV_TEXT_FIELD]
		do
			Precursor (par)
			set_spacing (5)
			create arg.make (editor)

			create hbox.make (Current)
			create label.make_with_text (hbox,
										Widget_names.text_field_text_name)
			create tbar.make (hbox)
			create tb_button.make_with_pixmap (tbar, Pixmaps.open_pixmap)
			create default_text.make (Current)

			create rcmd.make (~select_text)
			create arg1.make (default_text)
			tb_button.add_select_command (rcmd, arg1)
			create {SET_DEFAULT_TEXT_CMD} cmd
			default_text.add_return_command (cmd, arg)

			create read_only.make_with_text (Current,
										Widget_names.read_only_name)
			create {TEXT_READ_CMD} cmd
			read_only.add_toggle_command (cmd, arg)

			create hbox.make (Current)
			create margin_width.make_with_label (hbox,
										Widget_names.margin_width_name)
--			create {TEXT_MARGIN_WIDTH_CMD} cmd
--			margin_width.add_return_command (cmd, arg)

			create margin_height.make_with_label (hbox,
										Widget_names.margin_height_name)
--			create {TEXT_MARGIN_HEIGHT_CMD} cmd
--			margin_height_name.add_toggle_command (cmd, arg)

			create tab_length.make_with_label (Current,
										Widget_names.text_tab_length_name)
--			create {TEXT_TAB_LENGTH_CMD} cmd
--			tab_length.add_toggle_command (cmd, arg)
		end

feature {NONE} -- GUI attributes

	default_text: EV_TEXT_FIELD

	read_only: EV_CHECK_BUTTON

	margin_width: INTEGER_TEXT_FIELD

	margin_height: INTEGER_TEXT_FIELD

	tab_length: INTEGER_TEXT_FIELD

	context: TEXT_C is
		do
			Result ?= editor.edited_context
		end

feature -- Access

	reset is
			-- reset the content of the form
		do
--			maximum_size.set_int_value (context.maximum_size)
--			read_only.set_state (context.is_read_only)
--			enable_word_wrap.set_state (context.is_word_wrap_enable)
--			--enable_width_resize.set_state (context.is_width_resizable)
--			--enable_height_resize.set_state (context.is_height_resizable)
--			width_text_field.set_int_value (context.margin_width)
--			height_text_field.set_int_value (context.margin_height)
		end

	apply is
			-- update the context according to the content of the form
		do
--			if not maximum_size.same_value (context.maximum_size) then
--				context.set_maximum_size (maximum_size.int_value)
--			end
--			if context.is_read_only /= read_only.state then
--				context.set_read_only (read_only.state)
--			end
--			if context.is_word_wrap_enable /= enable_word_wrap.state then
--				context.enable_word_wrap (enable_word_wrap.state)
--			end
--			--if context.is_width_resizable /= enable_width_resize.state then
--			--	context.enable_resize_height (enable_height_resize.state)
--			--end
--			--if context.is_height_resizable /= enable_height_resize.state then
--			--	context.enable_resize_width (enable_width_resize.state)
--			--end
--			if not width_text_field.same_value (context.margin_width) then
--				context.set_margin_width (width_text_field.int_value)
--			end
--			if not height_text_field.same_value (context.margin_height) then
--				context.set_margin_height (height_text_field.int_value)
--			end
		end

feature {TEXT_FORM} -- Command

	select_text (arg: EV_ARGUMENT1 [EV_TEXT_FIELD]; ev_data: EV_EVENT_DATA) is
		local
			file_d: EV_FILE_OPEN_DIALOG
			arg2: EV_ARGUMENT2 [EV_TEXT_FIELD, EV_FILE_OPEN_DIALOG]
			cmd: SET_DEFAULT_TEXT_CMD
			arg1: EV_ARGUMENT1 [CONTEXT_EDITOR]
		do
			create file_d.make (arg.first.parent)
			create arg2.make (arg.first, file_d)
			file_d.add_ok_command (Current, arg2)
			create cmd
			create arg1.make (editor)
			file_d.add_ok_command (cmd, arg)
		end

	execute (arg: EV_ARGUMENT2 [EV_TEXT_FIELD, EV_FILE_OPEN_DIALOG]; ev_data: EV_EVENT_DATA) is
		do
			arg.first.set_text (arg.second.file)
		end

end -- class TEXT_FORM

