indexing
	description: "Other information for a class on a page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_PAGE


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
			
			space: EV_LABEL
		do

			notebook := noteb
			parent_window := p

			!! page.make (notebook)

			!! v1.make ( page )

			!! color_name.make (v1)
			color_name.set_expand (false)

			!! override_color.make_with_text (v1, widget_names.restrict)
			override_color.set_expand (false)

			notebook.append_page(page, widget_names.color)

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

	color_name: EV_TEXT_FIELD
	override_color: EV_CHECK_BUTTON


	clear is 
		-- Clear all fields/buttons of Current
		do
		end

	Update_from (ent: ANY) is
			-- Update from 'ent'
		do
		end

end -- class OTHER_CLASS_PAGE
