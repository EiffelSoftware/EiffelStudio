indexing
	description: "[
		Objects that represent source of a dockable transport. The dockable
		mechanism allows a component to be dragged by a user to an EV_DOCKABLE_TARGET
		that has been enabled to receive transport.
		
		`drop_started_actions' are fired immediately after a transport begins from `Current'.
		It is not possible to override the transport from within these actions.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE
	
inherit
	EV_ANY
		redefine
			implementation
		end
		
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCES
		redefine
			implementation
		end

feature -- Status report

	is_dockable: BOOLEAN is		
			-- Is `Current' dockable?
			-- If `True', then `Current' may be dragged
			-- from its current parent. 
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_dockable
		ensure
			bridge_ok: Result = implementation.is_dockable
		end
		
	real_source: EV_DOCKABLE_SOURCE is
			-- `Result' is source to be dragged
			--  when a docking drag occurs on `Current'.
			-- If `Void', `Current' is dragged.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.real_source
		ensure
			bridge_ok: Result = implementation.real_source
		end
		
	is_external_docking_enabled: BOOLEAN is
			-- Is `Current' able to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of transport?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_external_docking_enabled
		ensure
			bridge_ok: Result = implementation.is_external_docking_enabled
		end

feature -- Status setting

	enable_dockable is
			-- Ensure `Current' is dockable.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_dockable
		ensure
			is_dockable: is_dockable
		end
		
	disable_dockable is
			-- Ensure `Current' is not dockable.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_dockable
		ensure
			not_is_dockable: not is_dockable
		end

	set_real_source (dockable_source: EV_DOCKABLE_SOURCE) is
			-- Assign `dockable_source' to `real_source'.
		require
			not_destroyed: not is_destroyed
			is_dockable: is_dockable
			dockable_source_not_void: dockable_source /= Void
			dockable_source_is_parent_recursive: source_has_current_recursive (dockable_source)
		do
			implementation.set_real_source (dockable_source)
		ensure
			real_source_assigned: real_source = dockable_source
		end
		
	remove_real_source is
			-- Ensure `real_source' is `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_real_source
		ensure
			real_source_void: real_source = Void
		end
		
	enable_external_docking is
			-- Assign `True' to `is_external_docking_enabled'.
			-- Allows `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of transport.
		require
			not_destroyed: not is_destroyed
			is_dockable: is_dockable
		do
			implementation.enable_external_docking
		ensure
			is_externally_dockable: not is_external_docking_enabled
		end
		
	disable_external_docking is
			-- Assign `False' to `is_external_docking_enabled'.
			-- Forbid `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of transport.
		require
			not_destroyed: not is_destroyed
			is_dockable: is_dockable
		do
			implementation.disable_external_docking
		ensure
			not_externally_dockable: not is_external_docking_enabled
		end

feature -- Contract support

	source_has_current_recursive (source: EV_DOCKABLE_SOURCE): BOOLEAN is
			-- Does `source' recursively contain `Current'?
			-- As seen by parenting structure.
		require
			not_destroyed: not is_destroyed
			source_not_void: source /= Void
		local
			widget: EV_WIDGET
			tool_bar_button: EV_TOOL_BAR_BUTTON
			container: EV_CONTAINER
		do
			widget ?= Current
			if widget = Void then
				tool_bar_button ?= Current
				widget := tool_bar_button.parent
			end
			if widget /= Void then
				container ?= source
				check
					source_is_a_container: container /= Void
				end
				Result := container.has_recursive (widget)
			end
		end
		
	parent_of_source_allows_docking: BOOLEAN is
			-- Does parent of source to be transported
			-- allow current to be dragged out? (See `real_source')
			-- Not all Vision2 containers are currently supported by this
			-- mechanism, only descendents of EV_DOCKABLE_TARGET
			-- are supported.
		local
			widget: EV_WIDGET
			dockable_target: EV_DOCKABLE_TARGET
		do
			if real_source /= Void then
				widget ?= real_source
			else
				widget ?= Current
			end
			if widget /= Void and then widget.parent /= Void then
				dockable_target ?= widget.parent
				if dockable_target /= Void then
					Result := True
				end
			else
				Result := True
			end
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DOCKABLE_SOURCE_I
	
invariant
	parent_permits_docking: is_dockable implies parent_of_source_allows_docking

end -- class EV_DOCKABLE_SOURCE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------