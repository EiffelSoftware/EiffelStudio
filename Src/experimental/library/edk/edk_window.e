note
	description: "Summary description for {EDK_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_WINDOW

inherit
	EDK_OBJECT_I
		redefine
			default_create
		end

feature -- Initialization

	frozen default_create
			-- Create and initialize `Current'
		do
				-- Use generating type which will be TYPE [like Current] for registration of `Current'
			(create {EDK_TYPE_MANAGER}).register_window (Current)
				-- Fire off EDK_CREATE_WINDOW message
		end

feature -- Properties

	get_property (a_property_data: EDK_PROPERTY_DATA)
			-- Get the property associated with `a_property_data'
		do

		end

	set_property (a_property_data: EDK_PROPERTY_DATA)
			-- Set the property data associated with `a_property_data'
		do

		end

feature -- Events

	message_handler (a_event: EDK_MESSAGE)
			-- Message handler for `Current'
		do

		end

feature {EDK_TYPE_MANAGER} -- Registration

	register_messages (type_registration: EDK_TYPE_MANAGER)
			-- Register events of `Current'
		require
			window_type_unregistered: True
		do
			type_registration.register_message_data (window_create, {STRING_8}, {STRING_8})
				-- Passes weak reference to event manager or display
			type_registration.register_message_data (property_set, {STRING_8}, {NATURAL_8})
				-- Passes property data to set multiple values properties such as 'child'.
			type_registration.register_message_data (property_get, {STRING_8}, {NATURAL_8})
				-- Passes property data to query multiple values properties such as 'child'.
			type_registration.register_message_data (property_listen, {STRING_8}, {detachable ANY})
			type_registration.register_message_data (timer, {NATURAL_16}, {detachable ANY})
			type_registration.register_message_data (child_add, {NATURAL_16}, {detachable ANY})
			type_registration.register_message_data (child_remove, {NATURAL_16}, {detachable ANY})
		end

	register_properties (type_registration: EDK_TYPE_MANAGER)
			-- Register properties of `Current'.
		do
			type_registration.register_property_data (default_namespace, {STRING_8}, {NONE}, False)
			type_registration.register_property_data (full_namespace, {STRING_8}, {NONE}, False)
			type_registration.register_property_data (width, {NATURAL_16}, {NONE}, True)
			type_registration.register_property_data (height, {NATURAL_16}, {NONE}, True)
			type_registration.register_property_data (x_position, {INTEGER_16}, {NONE}, True)
			type_registration.register_property_data (y_position, {INTEGER_16}, {NONE}, True)
			type_registration.register_property_data (alpha, {NATURAL_8}, {NONE}, True)
			type_registration.register_property_data (focus, {BOOLEAN}, {NONE}, True)
			type_registration.register_property_data (sensitivity, {BOOLEAN}, {NONE}, True)
			type_registration.register_property_data (preferred_width, {NATURAL_16}, {NONE}, False)
			type_registration.register_property_data (preferred_height, {NATURAL_16}, {NONE}, False)
			type_registration.register_property_data (child, {NATURAL_16}, {NATURAL_16}, False)
			type_registration.register_property_data (child_count, {NATURAL_16}, {NONE}, False)
		end

feature {NONE} -- Default Event Strings

	window_create: STRING_8 = "window_create"
	property_set: STRING_8 = "property_set"
	property_get: STRING_8 = "property_get"
	property_listen: STRING_8 = "property_listen"
	timer: STRING_8 = "timer"
	child_add: STRING_8 = "child_add"
	child_remove: STRING_8 = "child_remove"

feature {NONE} -- Default Property Strings

	default_namespace: STRING_8 = "default_namespace"
	full_namespace: STRING_8 = "full_namespace"
	width: STRING_8 = "width"
	height: STRING_8 = "height"
	x_position: STRING_8 = "x_position"
	y_position: STRING_8 = "y_position"
	alpha: STRING_8 = "alpha"
	focus: STRING_8 = "focus"
	sensitivity: STRING_8 = "sensitivity"
	preferred_width: STRING_8 = "preferred_width"
	preferred_height: STRING_8 = "preferred_height"
	child: STRING_8 = "child"
	child_count: STRING_8 = "child_count"

end
