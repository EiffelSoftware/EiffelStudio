note
	description: "Summary description for {EDK_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_WINDOW_TOPLEVEL

inherit
	EDK_WINDOW
		redefine
			set_property,
			get_property,
			message_handler,
			register_properties
		end

feature -- Events

	message_handler (a_event: EDK_MESSAGE)
			-- Message handler for `Current'
		do
			Precursor (a_event)
		end

feature -- Properties

	get_property (a_property_data: EDK_PROPERTY_DATA)
			-- Get the property associated with `a_property_data'
		do
			Precursor (a_property_data)
		end

	set_property (a_property_data: EDK_PROPERTY_DATA)
			-- Set the property data associated with `a_property_data'
		do
			Precursor (a_property_data)
		end

	register_properties (type_registration: EDK_TYPE_REGISTRATION)
		do
			type_registration.register_property_data (title, {STRING_32}, {NONE}, True)
			type_registration.register_property_data (mouse_position_x, {INTEGER_16}, {NONE}, False)
			type_registration.register_property_data (mouse_position_y, {INTEGER_16}, {NONE}, False)
			type_registration.register_property_data (window_frame_x, {INTEGER_16}, {NONE}, False)
			type_registration.register_property_data (window_frame_y, {INTEGER_16}, {NONE}, False)
			type_registration.register_property_data (mouse_proximity, {INTEGER_16}, {NONE}, False)
		end

feature {NONE}	-- Default top-level Window Property Type Strings

	title: STRING_8 = "title"
	mouse_position_x: STRING_8 = "mouse_position_x"
	mouse_position_y: STRING_8 = "mouse_position_y"
	window_frame_x: STRING_8 = "window_frame_x"
	window_frame_y: STRING_8 = "window_frame_y"
	mouse_proximity: STRING_8 = "mouse_proximity"

end
