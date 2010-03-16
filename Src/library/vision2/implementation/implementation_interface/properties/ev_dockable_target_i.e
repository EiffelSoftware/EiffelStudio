note
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

	veto_dock_function: detachable FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN]
		-- Function used to veto transport.

	is_docking_enabled: BOOLEAN
		-- May `Current' be docked to?

feature -- Status setting

	enable_docking
			-- Ensure `is_docking_enabled' is True.
			-- `Current' will accept docking from a
			-- compatible EV_DOCKABLE_SOURCE.
		require
			application_exists: attached (create {EV_ENVIRONMENT}).application
		do
			is_docking_enabled := True
			if attached (create {EV_ENVIRONMENT}).application as l_application then
				l_application.implementation.dockable_targets.extend (attached_interface.object_id)
			end
		ensure
			is_dockable: is_docking_enabled
			id_stored_in_application: attached (create {EV_ENVIRONMENT}).application as l_application and then l_application.implementation.dockable_targets.has (attached_interface.object_id)
		end

	disable_docking
			-- Ensure `is_docking_enabled' is False.
			-- `Current' will not accept docking.
		require
			application_exists: attached (create {EV_ENVIRONMENT}).application
		do
			is_docking_enabled := False
			if attached (create {EV_ENVIRONMENT}).application as l_application then
				l_application.implementation.dockable_targets.prune_all (attached_interface.object_id)
			end
		ensure
			not_dockable: not is_docking_enabled
			id_not_stored_in_application:  attached (create {EV_ENVIRONMENT}).application as l_application and then not l_application.implementation.dockable_targets.has (attached_interface.object_id)
		end

	set_veto_dock_function (a_function: detachable FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN])
			-- Assign `a_function' to `veto_dock_function'.
		require
			a_function_not_void: a_function /= Void
		do
			veto_dock_function := a_function
		ensure
			veto_function_set: veto_dock_function = a_function
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DOCKABLE_TARGET note option: stable attribute end;

note
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









