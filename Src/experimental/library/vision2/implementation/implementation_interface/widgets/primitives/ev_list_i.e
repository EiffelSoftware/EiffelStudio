note
	description: "Eiffel Vision list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_I

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- `Result is all items currently selected in `Current'.
		local
			original_position: INTEGER
		do
			original_position := attached_interface.index
			create Result.make(2)
			from
				attached_interface.start
			until
				attached_interface.off
			loop
				if attached_interface.item.is_selected then
					Result.extend (attached_interface.item)
				end
				attached_interface.forth
			end
			attached_interface.go_i_th (original_position)
		end

feature -- Status report

	ensure_item_visible (an_item: EV_LIST_ITEM)
			-- Ensure item `an_item' is visible in `Current'.
		deferred
		end

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?
		deferred
		end

feature -- Status setting

	enable_multiple_selection
			-- Allow multiple items to be selected.
		deferred
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		deferred
		end

	disable_default_key_processing
			-- Ensure default key processing is not performed.
		do
			default_key_processing_disabled := True
		end

	default_key_processing_disabled: BOOLEAN
		-- Has default key processing been disabled?

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST note option: stable attribute end;

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




end -- class EV_LIST_I









