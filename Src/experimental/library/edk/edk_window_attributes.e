note
	description: "Used for registering EDK_WINDOW meta-types"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_WINDOW_ATTRIBUTES

create
	make

feature {NONE} -- Initialization

	make (a_property_setter: like property_setter; a_property_getter: like property_getter; a_subwindow_compositor: like subwindow_compositor)
			-- Create Window Attributes for type `a_type_name'.
		do
			property_setter := a_property_setter
			property_getter := a_property_getter
			subwindow_compositor := a_subwindow_compositor
		end

feature -- Access

	property_setter: detachable PROCEDURE [ANY, TUPLE [NATURAL_8]]
		-- Agent used for setting properties for instantiated windows of `type_name'.
		-- If detached the a generic setter is used.

	property_getter: detachable FUNCTION [ANY, TUPLE [NATURAL_8], ANY]
		-- Agent used for getting properties for instiantiated windows of `type_name'.
		-- If detached the a generic getter is used.

	subwindow_compositor: detachable PROCEDURE [ANY, TUPLE [LINEAR [NATIVE_WINDOW]]];
		-- Agent used for positioning subwindows if present
		-- If detached then a default fair share compositor will be used.

end
