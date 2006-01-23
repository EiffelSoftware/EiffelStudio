indexing
	description: "[
		Objects that allow dockable sources to be inserted as part of the
		dockable mechanism. Use `enable_docking' to permit sources to be dropped,
		and `veto_dock_function' to restrict which sources will be accepted. If a source
		is rejected by the veto function, then the parent structure will be explored until
		there are no more parents, or the source being transported is accepted.
		
		`docked_actions' is fired after the source of transport has been parented in `Current'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET
	
inherit
	EV_ANY
		redefine
			implementation
		end
		
	EV_DOCKABLE_TARGET_ACTION_SEQUENCES
		redefine
			implementation
		end
		
	IDENTIFIED
		export
			{EV_ANY_HANDLER} default_create
		undefine
			copy, is_equal, default_create
		end

feature -- Access
		
	veto_dock_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN] is
			-- Function to determine whether current dock is allowed.
			-- If `Result' is `True', dock will be disallowed.
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
		
feature -- Status setting

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

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_DOCKABLE_TARGET_I;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_TARGET

