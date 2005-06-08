indexing
	description	: "Abstaction for a widget representing a particular resource.%
		%Used for reading and writing resource values.  Actual interface is `change_item_widget'. To%
		%create an custom interface redefine this."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	PREFERENCE_WIDGET

feature {NONE} -- Initialization

	make is
			-- Create			
		do
			create change_actions.make
		end		

	make_with_resource (a_resource: PREFERENCE) is
			-- Make with values from `a_resource'.
		require
			resource_not_void: a_resource /= Void
		do
			set_resource (a_resource)
			make
		ensure
			has_resource: resource /= Void
		end		

feature -- Access

	change_item_widget: EV_GRID_ITEM
			-- Widget to change the item.

	caller: PREFERENCE_VIEW
			-- Caller view to which this resource widget currently belongs.

	resource: PREFERENCE
			-- Actual resource associated to the widget.

	graphical_type: STRING is
			-- Graphical type identifier.
		deferred
		end		

feature -- Basic operations

	set_resource (new_resource: like resource) is
			-- Set the resource.
		require
			resource_not_void: new_resource /= Void
		do
			resource := new_resource
			
			if change_item_widget = Void then
				build_change_item_widget
			end
		ensure
			resource_set: resource = new_resource
		end
		
	set_caller (a_caller: like caller) is
			-- Set the view this widget belongs to.
		require
			caller_not_void: a_caller /= Void
		do
			caller := a_caller
		ensure
			caller_set: caller = a_caller
		end		
			
	destroy is
			-- Destroy all graphical objects.
		do
			if change_item_widget /= Void then
				change_item_widget.destroy
			end
		end
		
	update_changes is
			-- Update the changes made in `change_item_widget' to `resource'.
		do
			change_actions.call ([resource])
		end		
		
	update_resource is
			-- Update the changes made in `change_item_widget' to `resource'.
		deferred
		end		
		
	reset is
			-- Reset resource to default value if any
		do			
			if resource.has_default_value then
				reset
			end
		end		
		
feature -- Actions

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `resource' changes, after call to `update_changes'.		
		
feature {NONE} -- Implementation

	build_change_item_widget is
				-- Create and setup `change_item_widget'.
		deferred
		ensure
			widget_created: change_item_widget /= Void
		end

invariant
	has_widget: change_item_widget /= Void

end -- class PREFERENCE_WIDGET
