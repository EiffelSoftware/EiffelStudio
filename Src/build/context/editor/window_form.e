indexing
	description: "Page representing the properties of a WINDOW_C."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class WINDOW_FORM

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
			ctxt_cmd: CONTEXT_CMD
			arg: EV_ARGUMENT1 [CONTEXT_EDITOR]
			item_field: EB_ITEM_FIELD
			arg1: EV_ARGUMENT1 [EV_LIST_ITEM]
			frame: EV_FRAME
			vbox: EV_VERTICAL_BOX
		do
			Precursor (par)
			set_spacing (5)
			create arg.make (editor)

			create title.make_with_label (Current, Widget_names.title_name)
			title.label.set_minimum_width (67)
			create {PERM_TITLE_CMD} ctxt_cmd
			title.add_return_command (ctxt_cmd, arg)

			create icon_name.make_with_label (Current, Widget_names.icon_name_name)
			icon_name.label.set_minimum_width (67)
			create {PERM_ICON_NAME_CMD} ctxt_cmd
			icon_name.add_return_command (ctxt_cmd, arg)

			create item_field.make_with_label (Current, Widget_names.icon_pix_name)
			create pixmap_name.make_with_text (item_field, Widget_names.open_pixmap_name)
			create arg1.make (pixmap_name)
			pixmap_name.add_select_command (Current, arg1)

			create modal_mode.make_with_text (Current, Widget_names.modal_mode_name)

			create frame.make_with_text (Current, Widget_names.start_state_name)
			create vbox.make (frame)
			create normal_state.make_with_text (vbox, Widget_names.normal_state_name)
			create iconic_state.make_with_text (vbox, Widget_names.iconic_state_name)
			create {PERM_ICONIC_CMD} ctxt_cmd
			iconic_state.add_toggle_command (ctxt_cmd, arg)
			create maximize_state.make_with_text (vbox, Widget_names.maximize_state_name)

			create set_hidden.make_with_text (Current, Widget_names.set_shown_name)
			create {PERM_SHOWN_CMD} ctxt_cmd
			set_hidden.add_toggle_command (ctxt_cmd, arg)

			create set_default_position_t.make_with_text (Current, Widget_names.set_default_position_name)
			create {WIN_SET_DEFAULT_POS_CMD} ctxt_cmd
			set_default_position_t.add_toggle_command (ctxt_cmd, arg)

			set_border_width (3)
		end

feature {NONE} -- GUI attributes

	title, icon_name: EB_TEXT_FIELD

	pixmap_name: EV_LIST_ITEM

	modal_mode, set_hidden, set_default_position_t: EV_CHECK_BUTTON

	normal_state, iconic_state, maximize_state: EV_RADIO_BUTTON

	context: WINDOW_C is
		do
			Result ?= Precursor
		end

feature {NONE} -- Command

	execute (arg: EV_ARGUMENT1 [EV_LIST_ITEM]; ev_data: EV_EVENT_DATA) is
		local
			file_d: PIXMAP_FILE_BOX
			cmd: PERM_ICON_CMD
			arg1: EV_ARGUMENT1 [CONTEXT_EDITOR]
		do
			create file_d.make (arg.first)
			create cmd
			create arg1.make (editor)
			file_d.add_ok_command (cmd, arg1)
			file_d.show
			arg.first.toggle
		end

	reset is
		do
			if context.title /= Void then
				title.set_text (context.title)
			else
				title.set_text ("")
			end
			if context.icon_name /= Void then
				icon_name.set_text (context.icon_name)
			else
				icon_name.set_text ("")
			end
			if context.icon_pixmap_name /= Void then
				pixmap_name.set_text (context.icon_pixmap_name)
			else
				pixmap_name.set_text ("")
			end
			modal_mode.set_state (False)
			if context.is_iconic_state then
				iconic_state.set_state (True)
			elseif context.is_maximize_state then
				maximize_state.set_state (True)
			else
				normal_state.set_state (True)
			end
			set_hidden.set_state (context.start_hidden)
			set_default_position_t.set_state (context.default_position)
		end


feature -- Basic command

	apply is
		do
			if context.title = Void then
				if not title.text.empty then
					context.set_title (title.text)
				end
			elseif not title.text.is_equal (context.title) then
				context.set_title (title.text)
			end
			if context.icon_name = Void then
				if not icon_name.text.empty then
					context.set_icon_name (icon_name.text)
				end
			elseif not icon_name.text.is_equal (context.icon_name) then
				context.set_icon_name (icon_name.text)
			end
			if context.icon_pixmap_name = Void then
				if not pixmap_name.text.is_equal (Widget_names.open_pixmap_name) then
					context.set_icon_pixmap (pixmap_name.text)
				end
			elseif not pixmap_name.text.is_equal (context.icon_pixmap_name) then
				context.set_icon_pixmap (pixmap_name.text)
			end
			if modal_mode.state /= context.is_modal then
				context.set_modal (modal_mode.state)
			end
			if iconic_state.state /= context.is_iconic_state then
				context.set_iconic_state (iconic_state.state)
			end
			if maximize_state.state /= context.is_maximize_state then
				context.set_maximize_state (maximize_state.state)
			end
			if context.default_position /= set_default_position_t.state then
				context.set_default_position (set_default_position_t.state)
			end
			if set_hidden.state /= context.start_hidden then
				context.set_start_hidden (set_hidden.state)
			end
		end

end -- class WINDOW_FORM

