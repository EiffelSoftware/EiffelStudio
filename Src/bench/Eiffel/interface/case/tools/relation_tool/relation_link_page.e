indexing
	description: "Page on which is displayed the EiffelCode of a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RELATION_LINK_PAGE

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

	make (noteb: EV_NOTEBOOK; ent: ANY;caller: EC_RELATION_WINDOW) is
			-- Initialize
		local
			link_box: EV_VERTICAL_BOX
			multiplicity_box: EV_HORIZONTAL_BOX

			hide_link_command: SHOW_IMPLEMENTATION_COM
			double_link_command: REMOVE_REVERSE_LINK
			shared_link_command: ADD_REMOVE_SHARED
			multiplicity_command: ADD_REMOVE_MULTIPLICITY
			multiplicity_scale_command: CHANGE_MULTIPLICITY
		do
			caller_window := caller
			make_editor_window_page ( noteb, ent)
			notebook.append_page(page, widget_names.link)

			!! link_box.make (page)

			!! hide_link.make_with_text (link_box, widget_names.hide_link)
			!! hide_link_command
			hide_link.add_toggle_command (hide_link_command, Void)

			!! double_link.make_with_text (link_box, widget_names.double_link)
			!! double_link_command.make (caller_window)

			double_link.add_toggle_command (double_link_command, Void)

			!! shared_link.make_with_text (link_box, widget_names.shared)
			!! shared_link_command
			shared_link.add_toggle_command (shared_link_command, Void)

			!! multiplicity_box.make (link_box)
				!! multiplicity.make_with_text (multiplicity_box, widget_names.multiplicity)				
				!! multiplicity_command
				multiplicity.add_toggle_command (multiplicity_command, Void)

			--	!! multiplicity_scale.make (multiplicity_box)
			--	!! multiplicity_scale_command
			--	multiplicity_scale.add_toggle_command (multiplicity_scale_command, Void)

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

	hide_link: EV_CHECK_BUTTON
	double_link: EV_CHECK_BUTTON
	shared_link: EV_CHECK_BUTTON
	multiplicity: EV_CHECK_BUTTON
	multiplicity_scale: EV_HORIZONTAL_SCALE
	
	reverse_link: EV_BUTTON
	
end -- class CLASS_CODE_PAGE
