indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_TARGET_I
	
inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

feature -- Measurement

feature -- Status report

	real_target: EV_DOCKABLE_TARGET
	
	veto_dock_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN]
		--
		
	is_dockable: BOOLEAN

feature -- Status setting

	enable_dockable is
			--
		do
			is_dockable := True
			(create {EV_ENVIRONMENT}).application.implementation.dragable_targets.extend (interface.object_id)
		ensure
			is_dockable: is_dockable
			id_stored_in_application: (create {EV_ENVIRONMENT}).application.implementation.dragable_targets.has (interface.object_id)
		end
		
	disable_dockable is
			--
		do
			is_dockable := False
			(create {EV_ENVIRONMENT}).application.implementation.dragable_targets.prune (interface.object_id)
		ensure
			not_dockable: not is_dockable
			id_not_stored_in_application: not (create {EV_ENVIRONMENT}).application.implementation.dragable_targets.has (interface.object_id)
		end
		
		
	set_real_target (a_real_target: EV_DOCKABLE_TARGET) is
			--
		require
			real_target_not_void: a_real_target /= Void
		do
			real_target := a_real_target
		ensure
			real_target_set: real_target = a_real_target
		end

	remove_real_target is
			--
		do
			real_target := Void
		ensure
			real_target_void: real_target = Void
		end
		
	set_veto_dock_function (a_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN]) is
			--
		require
			a_function_not_void: a_function /= Void
		do
			veto_dock_function := a_function
		ensure
			veto_function_set: veto_dock_function = a_function
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DOCKABLE_TARGET

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_TARGET_I
