indexing
	description: "Objects that represent stones carrying a GB_OBJECT representing a clipboard object."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD_OBJECT_STONE

inherit
	GB_OBJECT_STONE
		redefine
			object
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create all_contained_instances.make (10)
		ensure
			components_set: components = a_components
		end

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
			-- Warning this builds new objects, so do not call
			-- from a veto pebble function, only on the drop.
		do
			Result := components.clipboard.object
		end

	object_type: STRING is
			-- EiffelVision2 Type of object represented.
		do
			Result := components.clipboard.object_type
		end

feature {GB_CLIPBOARD} -- Implementation

	set_associated_top_level_object (an_id: INTEGER) is
			-- Assign `an_id' to `associated_top_level_object'.
		require
			an_id_positive: an_id > 0
		do
			associated_top_level_object := an_id
		end

end -- class GB_CLIPBOARD_OBJECT_STONE
