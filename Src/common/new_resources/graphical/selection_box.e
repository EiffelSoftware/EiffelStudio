indexing
	description: "Class which allows entering a value corresponding to a data."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SELECTION_BOX

inherit
	RESOURCE_OBSERVATION_MANAGER

feature -- Initialization

	make(h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
		require
			box_exists: h /= Void
			caller_exists: new_caller /= Void
		do
			parent := h
			caller := new_caller
			!! frame.make(Void)
		end


feature -- Display

	Hide is
		-- hide Current.
		do
			resource := Void
			frame.set_parent(Void)
		end

	Display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			resource := new_resource
			frame.set_text(resource.name)
			frame.set_parent(parent)
		end
feature -- Implementation

	parent: EV_BOX
		--  Parent of Current

	frame: EV_FRAME
		-- Frame of Current

	resource: RESOURCE
		-- Resource.

	caller: PREFERENCE_WINDOW
		-- Caller

	update_resource is
		do
			if observer_manager.get_data_observer (resource) /= Void then
				observer_manager.update_observer (resource)
			end
		end

invariant
	SELECTION_BOX_parent_exists: parent /= Void
	--SELECTION_BOX_frame_exists: frame /= Void
	--SELECTION_BOX_resource_exists: resource /= Void
	--SELECTION_BOX_resource_exists: caller /= Void
	SELECTION_BOX_hide_consistency: frame.parent=Void implies resource=Void
	SELECTION_BOX_display_consistency: frame.parent/=Void implies resource /= Void 
end -- class SELECTION_BOX
