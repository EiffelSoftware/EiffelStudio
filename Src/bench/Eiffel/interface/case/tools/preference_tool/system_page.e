indexing
	description: "Other information for a class on a page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_PAGE


inherit
	--EDITOR_WINDOW_PAGE
	--	rename
	--		entity as entity_editor_window_page,
	--		make as make_editor_window_page
	--	end

	GRAPHICAL_COMPONENT [CLASS_DATA]
		rename
			make as make_graphical_component
		redefine 
			update
		end
	
	CONSTANTS

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; p: like parent_window) is
			-- Initialize
		local
			v1: EV_VERTICAL_BOX
			h1: EV_HORIZONTAL_BOX
		do

			notebook := noteb
			parent_window := p

			!! page.make (notebook)

			!! v1.make ( page )

			!! h1.make (v1)
			h1.set_expand (false)

			!! print_label.make_with_text (h1, widget_names.print_command)
			print_label.set_expand (false)

			!! print_command.make (h1)

			notebook.append_page(page, widget_names.system)

			update
		end	

	
feature -- Access

	reset, do_page is do end

	update is
		do
		end

feature -- Properties

	notebook: EV_NOTEBOOK
	page: EV_VERTICAL_BOX
	parent_window: EV_WINDOW


feature -- Implementation

	saving_delay: EV_HORIZONTAL_SCALE
	print_label: EV_LABEL
	print_command: EV_TEXT_FIELD


	clear is 
		-- Clear all fields/buttons of Current
		do
		end

	Update_from (ent: ANY) is
			-- Update from 'ent'
		do
		end

end -- class OTHER_CLASS_PAGE
