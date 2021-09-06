note
	description: "Objects that store a list of unique keyboard accelerators."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "accelerator, shortcut"
	date: "$Date$"
	revision: "$Revision$"

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

	default_create
			-- Standard creation procedure.
		do
			Precursor {EV_ACTIVE_LIST}
			internal_add_actions.extend (agent enable_item_parented (?))
			internal_remove_actions.extend (agent disable_item_parented (?))
		end

feature {NONE} -- Status Setting

	enable_item_parented (an_item: like item)
			-- Assign True to `parented' for `an_item'.
		require
			key_combination_unique: an_item /= Void implies
				(occurrences (an_item) = 1 and not key_combination_exists (an_item))
		do
			if an_item /= Void then
				check attached {EV_ACCELERATOR_IMP} an_item.implementation as accelerator_imp then
					accelerator_imp.enable_parented
				end
			end
		end

	disable_item_parented (an_item: like item)
			-- Assign False to `parented' for `an_item'.
		do
			if an_item /= Void then
				check attached {EV_ACCELERATOR_IMP} an_item.implementation as accelerator_imp then
					accelerator_imp.disable_parented
				end
			end
		end

feature {NONE} -- Contract support

	key_combination_exists (new_accelerator: like item): BOOLEAN
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

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_ACCELERATOR_LIST












