indexing
	description: "Page on which is displayed the EiffelCode of a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RELATION_HANDLES_PAGE

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
			handle_box: EV_VERTICAL_BOX

			left_handle_box: EV_HORIZONTAL_BOX
			right_handle_box: EV_HORIZONTAL_BOX
			remove_handle_box: EV_HORIZONTAL_BOX

			left_handle_label: EV_LABEL
			right_handle_label: EV_LABEL
			remove_handle_label: EV_LABEL

			left_handle_command: ADV_LEFT
			right_handle_command: ADV_RIGHT
			remove_handle_command: REMOVE_HANDLES
		do
			make_editor_window_page ( noteb, ent)
			notebook.append_page(page, widget_names.handles)

			!! handle_box.make (page)
			handle_box.set_expand (false)

			!! left_handle_box.make (handle_box)
				!! left_handle_button.make (left_handle_box)
				left_handle_button.set_pixmap (pixmaps.left_handle)
				left_handle_button.set_expand (false)
				!! left_handle_command.make (caller_window)
				left_handle_button.add_click_command (left_handle_command, Void)

				!! left_handle_label.make_with_text (left_handle_box, widget_names.left_handle)

			!! right_handle_box.make (handle_box)
				!! right_handle_button.make (right_handle_box)
				right_handle_button.set_pixmap (pixmaps.right_handle)
				right_handle_button.set_expand (false)
				!! right_handle_command.make (caller_window)
				right_handle_button.add_click_command (right_handle_command, Void)

				!! right_handle_label.make_with_text (right_handle_box, widget_names.right_handle)

			!! remove_handle_box.make (handle_box)
				!! remove_handle_button.make (remove_handle_box)
				remove_handle_button.set_pixmap (pixmaps.remove_handles_pixmap)
				remove_handle_button.set_expand (false)
				!! remove_handle_command.make (caller_window)
				remove_handle_button.add_click_command (remove_handle_command, Void)

				!! remove_handle_label.make_with_text (remove_handle_box, widget_names.remove_handle)

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

	left_handle_button: EV_BUTTON
	right_handle_button: EV_BUTTON
	remove_handle_button: EV_BUTTON

end -- class CLASS_CODE_PAGE
