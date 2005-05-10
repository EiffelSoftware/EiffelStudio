indexing
	description: "Objects that contain action sequences for EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ROW_ACTION_SEQUENCES_I

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is selected.
		do
			if select_actions_internal = Void then
				create select_actions_internal
			end
			Result := select_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is deselected.
		do
			if deselect_actions_internal = Void then
				create deselect_actions_internal
			end
			Result := deselect_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	expand_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is expanded.
		do
			if expand_actions_internal = Void then
				create expand_actions_internal
			end
			Result := expand_actions_internal
		ensure
			result_not_void: Result /= Void
		end
	
	collapse_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is collapsed.
		do
			if collapse_actions_internal = Void then
				create collapse_actions_internal
			end
			Result := collapse_actions_internal
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	select_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.

	deselect_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `deselect_actions'.

	expand_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `expand_actions_internal'.
			
	collapse_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `collapse_actions_internal'.

end
