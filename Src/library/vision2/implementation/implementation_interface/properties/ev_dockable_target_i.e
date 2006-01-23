indexing
	description: "Implementation interface for dockable target."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET_I
	
inherit
	EV_ANY_I
		redefine
			interface
		end
		
	EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I

feature -- Status report

	veto_dock_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN]
		-- Function used to veto transport.
		
	is_docking_enabled: BOOLEAN
		-- May `Current' be docked to?

feature -- Status setting

	enable_docking is
			-- Ensure `is_docking_enabled' is True.
			-- `Current' will accept docking from a
			-- compatible EV_DOCKABLE_SOURCE.
		do
			is_docking_enabled := True
			(create {EV_ENVIRONMENT}).application.implementation.dockable_targets.extend (interface.object_id)
		ensure
			is_dockable: is_docking_enabled
			id_stored_in_application: (create {EV_ENVIRONMENT}).application.implementation.dockable_targets.has (interface.object_id)
		end
		
	disable_docking is
			-- Ensure `is_docking_enabled' is False.
			-- `Current' will not accept docking.
		do
			is_docking_enabled := False
			(create {EV_ENVIRONMENT}).application.implementation.dockable_targets.prune_all (interface.object_id)
		ensure
			not_dockable: not is_docking_enabled
			id_not_stored_in_application: not (create {EV_ENVIRONMENT}).application.implementation.dockable_targets.has (interface.object_id)
		end
		
	set_veto_dock_function (a_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN]) is
			-- Assign `a_function' to `veto_dock_function'.
		require
			a_function_not_void: a_function /= Void
		do
			veto_dock_function := a_function
		ensure
			veto_function_set: veto_dock_function = a_function
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DOCKABLE_TARGET;

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




end -- class EV_DOCKABLE_TARGET_I

