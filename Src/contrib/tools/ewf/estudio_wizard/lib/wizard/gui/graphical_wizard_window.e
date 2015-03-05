note
	description: "Summary description for {GRAPHICAL_WIZARD_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_WIZARD_WINDOW

inherit
	EV_TITLED_WINDOW
		rename
			data as widget_data
		redefine
			create_interface_objects,
			initialize
		end

	GRAPHICAL_WIZARD_APPLICATION
		rename
			initialize as initialize_wizard
		undefine
			default_create, copy
		end

feature {NONE} -- Initialize

	create_interface_objects
		do
			initialize_wizard
		end

	initialize
		do
			Precursor
			build_interface (Current)
		end

end
