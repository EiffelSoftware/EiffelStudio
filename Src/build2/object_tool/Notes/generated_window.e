indexing
	description: " Generated command used to change %
				% the queries of a EV_TITLED_WINDOW object."
	visual_name: "set_ev_titled_window_object_cmd"

class

	GENERATED_CLASS

inherit

	EV_TITLED_WINDOW

creation

	make

feature

	execute is
		require else
			target_set: target_set
		do
			message_displayed := False
			if argument1.is_selected then
				target.enable_user_resize
			else
				target.disable_user_resize
			end
			if argument2.selected_item.text.is_equal ("Yes") then
			target.show
			else
				target.hide
			end
		end

	display_error_message(message: STRING; a_parent: EV_CONTAINER) is
		local
			error_dialog: EV_ERROR_DIALOG
		do
			if not message_displayed then
				create error_dialog.make_with_text (message)
				error_dialog.show_modal_to_window (Current)
				message_displayed := True
			end
		end
	make is
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			list_item: EV_LIST_ITEM
		do
			default_create
			create vertical_box
			create horizontal_box
			create label.make_with_text ("user_can_resize")
			horizontal_box.extend (label)
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create argument1
			horizontal_box.extend (argument1)
			create horizontal_box
			create label.make_with_text ("is_show_requested")
			horizontal_box.extend (label)
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create argument2
			horizontal_box.extend (argument2)
			create list_item.make_with_text ("Yes")
			argument2.extend (list_item)
			create list_item.make_with_text ("No")
			argument2.extend (list_item)
			extend (vertical_box)
			create button.make_with_text ("Build")
			vertical_box.extend (button)
			button.select_actions.extend (agent execute)
		end

feature -- Access

	target: EV_TITLED_WINDOW

	set_target (a_target: EV_TITLED_WINDOW) is
		require
			a_target /= Void
		do
			target := a_target
		end

	target_set: BOOLEAN is
		do
			Result := target /= Void
		end

feature -- Implementation

	button: EV_BUTTON

	message_displayed: BOOLEAN

	argument1: EV_CHECK_BUTTON

	argument2: EV_COMBO_BOX

end -- class MY_TEST
