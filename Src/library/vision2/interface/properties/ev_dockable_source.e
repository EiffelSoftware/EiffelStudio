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

	is_dragable: BOOLEAN is		
			-- Is `Current' dragable
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_dragable
		ensure
			bridge_ok: Result = implementation.is_dragable
		end
		
	real_source: EV_DOCKABLE_SOURCE is
			-- `Result' is EV_CONTAINER which should be
			-- dragged when a drag starts on `Current'.
		require
			not_destroyed: not is_destroyed
			-- has current
		do
			Result := implementation.real_source
		end
		
	is_externally_dockable: BOOLEAN is
			-- Is `Current' able to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_externally_dockable
		end

feature -- Status setting

	enable_drag is
			-- Allow `Current' to be dragable.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_drag
		ensure
			is_dragable: is_dragable
		end
		
	disable_drag is
			-- Ensure `Current' is not dragable.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_drag
		ensure
			not_is_dragable: not is_dragable
		end

	set_real_source (dockable_source: EV_DOCKABLE_SOURCE) is
			-- Set `dockable_source' to be the widget moved when a
			-- drag begins on `Current'.
		require
			not_destroyed: not is_destroyed
			is_dragable: is_dragable
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
			is_dragable: is_dragable
		do
			implementation.remove_real_source
		ensure
			no_parent_container: real_source = Void
		end
		
	enable_externally_dockable is
			-- Allow `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			not_destroyed: not is_destroyed
			is_dragable: is_dragable
		do
			implementation.enable_externally_dockable
		ensure
			is_externally_dockable: not is_externally_dockable
		end
		
	disable_externally_dockable is
			-- Forbid `Current' to be docked into an EV_DOCKABLE_DIALOG
			-- When there is no valid EV_DRAGABLE_TARGET upon completion
			-- of the transport?
		require
			not_destroyed: not is_destroyed
			is_dragable: is_dragable
		do
			implementation.disable_externally_dockable
		ensure
			not_externally_dockable: not is_externally_dockable
		end

feature -- Contract support

	source_has_current_recursive (source: EV_DOCKABLE_SOURCE): BOOLEAN is
			-- Does `source' recursively contain `Current'.
		require
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