indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAPABLE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

	PIXMAP_PATH


creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			{ANY_TAB} Precursor (Void)
		
				-- Creates the objects and their commands
				create cmd2.make (~set_pixmap)
				create f1.make (Current, 0, 0, "Set Pixmap", cmd2, cmd2)		
				f1.combo.set_editable (True)
				f1.button.set_text ("Set Pixmap")
				create cmd1.make (~unset_pixmap)
				create b1.make_with_text (Current, "Unset Pixmap")
				b1.set_vertical_resize (False)
				b1.add_click_command (cmd1, Void)
			
				create p1.make_from_file (pixmap_path ("current"))
				create e1.make_with_text (f1.combo, "current")
				e1.set_data (p1)
				create p1.make_from_file (pixmap_path ("class"))
				create e2.make_with_text (f1.combo, "class")
				e2.set_data (p1)
				create p1.make_from_file (pixmap_path ("system"))
				create e3.make_with_text (f1.combo, "system")
				e3.set_data (p1)

				set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Pixmapable"
		end


feature -- Execution feature  
	
	set_pixmap (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets a pixmap
		local
			current_pixmap: EV_PIXMAP
		do
			if f1.combo.selected then
				current_pixmap ?= f1.combo.selected_item.data
				current_widget.set_pixmap(current_pixmap)
			end
		end

	unset_pixmap (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Unsets a pixmap
		do
			if current_widget.pixmap /= Void then
				current_widget.unset_pixmap
			end
		end

feature -- Access

	current_widget: EV_PIXMAPABLE
	f1: COMBO_FEATURE_MODIFIER	
	b1: EV_BUTTON
	p1: EV_PIXMAP
	e1,e2,e3: EV_LIST_ITEM
	--pixmaps: LINKED_LIST[EV_PIXMAP]
end -- class FONTABLE_TAB

 



