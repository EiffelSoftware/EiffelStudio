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

--	real_target: EV_DRAGABLE_TARGET is
--			--
--		require
--			not_destroyed: not is_destroyed
--			--has
--		do
--			Result := implementation.real_target
--		ensure
--			bridge_ok: Result = implementation.real_target
--		end
		
	veto_dock_function: FUNCTION [ANY, TUPLE [EV_DOCKABLE_SOURCE], BOOLEAN] is
			-- Function to determine whether the current dock is allowed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.veto_dock_function
		ensure
			bridge_ok: Result = implementation.veto_dock_function
		end
		
	is_dockable: BOOLEAN is
			-- May `Current' be docked to?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_dockable
		ensure
			bridge_ok: Result = implementation.is_dockable
		end
		
		

feature -- Measurement

feature -- Status report

feature -- Status setting

--	set_as_real_target_recursive is
--			--
--		require
--			not_destroyed: not is_destroyed
--		do
--			enable_dockable
--			recursive_set (Current)
--		ensure
--			is_dockable: is_dockable
--			-- all_children_recursively_set: for all children recursively, `real_target' = `Current'.
--		end
		

	enable_dockable is
			--
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_dockable
		ensure
			is_dockable: is_dockable
		end
		
	disable_dockable is
			--
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_dockable
		ensure
			not_dockable: not is_dockable	
		end
		
		
--	set_real_target (a_real_target: EV_DRAGABLE_TARGET) is
--			--
--		require
--			not_destroyed: not is_destroyed
--			real_target_not_void: a_real_target /= Void
--			-- `Current' is contained within `a_real_target'.
--		do
--			implementation.set_real_target (a_real_target)
--		ensure
--			real_target_set: real_target = a_real_target
--		end
--		
--	remove_real_target is
--			--
--		require
--			not_destroyed: not is_destroyed
--		do
--			implementation.remove_real_target
--		ensure
--			real_target_void: real_target = Void
--		end
		
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

feature {NONE} -- Implementation

--	recursive_set (dragable_target: EV_DRAGABLE_TARGET) is
--		require
--			not_destroyed: not is_destroyed
--			dragable_target_not_void: dragable_target /= Void
--		local
--			container: EV_CONTAINER
--			rep: LINEAR [EV_WIDGET]
--			drag_target: EV_DRAGABLE_TARGET
--		do
--			container ?= dragable_target
--			if container /= Void then
--				rep ?= container.linear_representation
--				from
--					rep.start
--				until
--					rep.off
--				loop
--					container ?= rep.item
--					if container /= Void then
--						recursive_set (container)
--					end
--					drag_target ?= rep.item
--					check
--						drag_target /= Void
--					end
--					drag_target.set_real_target (Current)
--					rep.forth
--				end
--			end
--		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DOCKABLE_TARGET_I

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_TARGET
