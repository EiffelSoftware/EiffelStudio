indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET
	
inherit
	EV_ANY
		redefine
			implementation
		end
		
	IDENTIFIED
		undefine
			copy, is_equal, default_create
		end

feature -- Access
		
	veto_dock_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN] is
			-- Function to determine whether the current dock is allowed.
			-- If `Result' is `True', the dock will be disallowed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.veto_dock_function
		ensure
			bridge_ok: Result = implementation.veto_dock_function
		end
		
	is_docking_enabled: BOOLEAN is
			-- May `Current' be docked to?
			-- If True, `Current' will accept docking
			-- from a compatible EV_DOCKABLE_SOURCE.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_docking_enabled
		ensure
			bridge_ok: Result = implementation.is_docking_enabled
		end

	enable_docking is
			-- Ensure `is_docking_enabled' is True.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_docking
		ensure
			is_dockable: is_docking_enabled
		end
		
	disable_docking is
			-- Ensure `is_docking_enabled' is False.
			-- `Current' will not accept docking.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_docking
		ensure
			not_dockable: not is_docking_enabled	
		end
		
	set_veto_dock_function (a_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN]) is
			-- Assign `a_function' to `veto_dock_function'.
		require
			not_destroyed: not is_destroyed
			a_function_not_void: a_function /= Void
		do
			implementation.set_veto_dock_function (a_function)
		ensure
			veto_function_set: veto_dock_function = a_function
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DOCKABLE_TARGET_I

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_TARGET
