indexing
	description: "Objects that is a base class for all Eiffel Studio models."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_ITEM
	
feature -- Status report

	is_needed_on_diagram: BOOLEAN
			-- Is `Current' needed on diagram.
			-- False when the item was inserted and then
			-- removed with the undo command. The undo
			-- insert command (EIFFEL_WORLD) does not
			-- remove the item from the graph, but hide it
			-- in the world. A new view should not show
			-- this item.
			
feature -- Access

	needed_on_diagram_changed_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Called when `is_needed_on_diagram' changed.
		do
			if internal_needed_on_diagram_changed = Void then
				create internal_needed_on_diagram_changed
				internal_needed_on_diagram_changed.compare_objects
			end
			Result := internal_needed_on_diagram_changed
		end
			
feature -- Status settings.

	enable_needed_on_diagram is
			-- Set `is_needed_on_diagram' to True.
		do
			if not is_needed_on_diagram then
				is_needed_on_diagram := True
				needed_on_diagram_changed_actions.call (Void)
			end
		ensure
			set: is_needed_on_diagram
		end
		
	disable_needed_on_diagram is
			-- Set `is_needed_on_diagram' to False.
		do
			if is_needed_on_diagram then
				is_needed_on_diagram := False
				needed_on_diagram_changed_actions.call (Void)
			end
		ensure
			set: not is_needed_on_diagram
		end
		
feature -- Element change
		
	synchronize is
			-- Some properties may have changed due to recompilation.
		deferred
		end
		
feature {NONE} -- Implementation

	internal_needed_on_diagram_changed: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation for `needed_on_diagram_changed'.
			
invariant
	needed_on_diagram_changed_actions_not_void: needed_on_diagram_changed_actions /= Void

end -- class ES_ITEM
