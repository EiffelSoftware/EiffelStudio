indexing
	description: "Other information for a class on a page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_CLASS_PAGE


inherit

	CONSTANTS

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; p: like parent_window) is
			-- Initialize
		local
			v1: EV_VERTICAL_BOX
			h1: EV_HORIZONTAL_BOX
			
			space: EV_LABEL

			class_name_command: ADD_LIST_COM
			extend_command: EXTEND_COM
			remove_command: REMOVE_COM
		do

			notebook := noteb
			parent_window := p

			!! page.make (notebook)

			!! v1.make ( page )

			!! class_list.make (v1)

			!! class_name.make (v1)
			class_name.set_expand (false)
			!! class_name_command.make (caller_window, 2)
			class_name.add_activate_command (class_name_command, Void)

			!! h1.make (v1)
			h1.set_expand (false)
				!! extend_button.make_with_text (h1, widget_names.extend)
				extend_button.set_expand (false)
				!! extend_command.make (caller_window)
				extend_button.add_click_command (extend_command, Void)

				!! space.make (h1)

				!! remove_button.make_with_text (h1, widget_names.remove)
				remove_button.set_expand (false)
				!! remove_command.make (caller_window)
				remove_button.add_click_command (remove_command, Void)
				

			!! restrict_cluster.make_with_text (v1, widget_names.restrict)
			restrict_cluster.set_expand (false)

			notebook.append_page(page, widget_names.classes)

			update
		end	

	
feature -- Access

	reset, do_page is do end

	update is
		do
		end

feature -- Properties

	caller_window: ADVANCED_COLOR_WINDOW

	notebook: EV_NOTEBOOK
	page: EV_VERTICAL_BOX
	parent_window: EV_WINDOW


feature -- Implementation

	class_list: EV_LIST
	class_name: EV_TEXT_FIELD
	extend_button: EV_BUTTON
	remove_button: EV_BUTTON
	restrict_cluster: EV_CHECK_BUTTON


	clear is 
		-- Clear all fields/buttons of Current
		do
		end

	Update_from (ent: ANY) is
			-- Update from 'ent'
		do
		end

end -- class OTHER_CLASS_PAGE
