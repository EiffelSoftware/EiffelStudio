indexing
	description: "Objects that ..."
	author: ""
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
			-- Is `Current' dockable
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
			-- has current
		do
			Result := implementation.real_source
		end
		
	is_external_docking_enabled: BOOLEAN is
			-- Is `Current' able to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_external_docking_enabled
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
			no_parent_container: real_source = Void
		end
		
	enable_external_docking is
			-- Allow `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport.
		require
			not_destroyed: not is_destroyed
			is_dockable: is_dockable
		do
			implementation.enable_external_docking
		ensure
			is_externally_dockable: not is_external_docking_enabled
		end
		
	disable_external_docking is
			-- Forbid `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport.
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
			-- Does `source' recursively contain `Current'.
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

feature {EV_ANY_I} -- Implementation

	implementation: EV_DOCKABLE_SOURCE_I

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_