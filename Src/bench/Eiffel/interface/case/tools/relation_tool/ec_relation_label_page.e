indexing
	description: "Page on which is displayed the EiffelCode of a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_RELATION_LABEL_PAGE

inherit
	EDITOR_WINDOW_PAGE
		rename
			entity as entity_editor_window_page,
			make as make_editor_window_page
		end

	GRAPHICAL_COMPONENT [CLASS_DATA]
		rename
			make as make_graphical_component
		redefine 
			update,
			caller_window
		end

	CONSTANTS

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
			-- Initialize
		local
			label_box: EV_VERTICAL_BOX
			edit_label_box: EV_HORIZONTAL_BOX
			change_side_box: EV_HORIZONTAL_BOX

			change_side_space: EV_LABEL

			label_command: SET_RELATION_LABEL_COM
			change_side_command: SET_LABEL_LEFT_POSITION2
			hide_label_command: SHOW_LABEL
		do
			make_editor_window_page ( noteb, ent)
			notebook.append_page(page, widget_names.label)

			!! label_box.make (page)

			!! edit_label_box.make (label_box)
			edit_label_box.set_expand (false)

				!! label.make_with_text (edit_label_box, widget_names.label)
				label.set_expand (false)
				!! text_label.make (edit_label_box)
				!! label_command.make (Current)
				text_label.add_activate_command (label_command, Void)
	
			!! change_side_box.make (label_box)
			change_side_box.set_expand (false)

				!! change_side.make_with_text (change_side_box, widget_names.change_side)
				change_side.set_expand (false)
				!! change_side_command.make (caller_window)
				change_side.add_click_command (change_side_command, Void)
				!! change_side_space.make (change_side_box)

			!! hide_label.make_with_text (label_box, widget_names.hide_label)
			hide_label.set_expand (false)
			!! hide_label_command.make (caller_window)
			hide_label.add_toggle_command (hide_label_command, Void)

			update
		end

feature -- Properties

	caller_window: EC_RELATION_WINDOW

feature -- Access

	reset, do_page is do end

	update is
		local
		--	generate_code_class: GENERATE_CODE_CLASS
		do
		--	if entity /= Void then
		--	end
		end

	clear is 
		-- Clear all fields/buttons of Current
		do
		end

	Update_from (ent: ANY) is
			-- Update from 'ent'
		do
		end

feature -- Implementation

	label: EV_LABEL
	text_label: EV_TEXT_FIELD

	change_side: EV_BUTTON
	hide_label: EV_CHECK_BUTTON

end -- class CLASS_CODE_PAGE
