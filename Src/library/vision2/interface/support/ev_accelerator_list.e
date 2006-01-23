indexing
	description	: "Objects that store a list of unique keyboard accelerators."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "accelerator, shortcut"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_ACCELERATOR_LIST

inherit
	EV_ACTIVE_LIST [EV_ACCELERATOR]
		undefine
			default_create
		end
		
create
	default_create

create {EV_ACCELERATOR_LIST}
	make_filled

feature -- Initialization

	default_create is
			-- Standard creation procedure.
		do
			Precursor {EV_ACTIVE_LIST}
			internal_add_actions.extend (agent enable_item_parented (?))
			internal_remove_actions.extend (agent disable_item_parented (?))
		end

feature {NONE} -- Status Setting

	enable_item_parented (an_item: like item) is
			-- Assign True to `parented' for `an_item'.
		require
			an_item_not_void: an_item /= Void
			key_combination_unique: occurrences (an_item) = 1 and not key_combination_exists (an_item)
		local
			accelerator_imp: EV_ACCELERATOR_IMP
		do
			accelerator_imp ?= an_item.implementation
			accelerator_imp.enable_parented
		end

	disable_item_parented (an_item: like item) is
			-- Assign False to `parented' for `an_item'.
		require
			an_item_not_void: an_item /= Void
		local
			accelerator_imp: EV_ACCELERATOR_IMP
		do
			accelerator_imp ?= an_item.implementation
			accelerator_imp.disable_parented
		end

feature {NONE} -- Contract support

	key_combination_exists (new_accelerator: like item): BOOLEAN is
			-- Does `Current' contain an accelerator with an identical key
			-- combination to `new_accelerator'?
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor
			from
				start
			until
				Result or else off
			loop
				Result := item.is_equal (new_accelerator) and then (item /= new_accelerator)
				forth
			end
			go_to (old_cursor)
		end

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




end -- class EV_ACCELERATOR_LIST

