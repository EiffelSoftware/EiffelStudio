indexing
	description: "Objects that represent stones carrying a GB_OBJECT representing a component."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_OBJECT_STONE
	
inherit
	GB_OBJECT_STONE
		redefine
			object
		end

create
	make_with_component
	
feature {NONE} -- Initialization

	make_with_component (a_component: GB_COMPONENT) is
			-- Create `Curent' and assign `a_component' to `component'.
		require
			a_component_not_void: a_component /= Void
		do
			component ?= a_component
		ensure
			component_set: component = a_component
		end

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
			-- Warning this builds new objects, so do not call
			-- from a veto pebble function, only on the drop.
		do
			Result := component.object
		end
		
	object_type: STRING is
			-- EiffelVision2 Type of object represented.
		do
			Result := component.root_element_type
		end
		
	component: GB_COMPONENT
		-- Component represented by `Current'.

end -- class GB_STANDARD_OBJECT_STONE
