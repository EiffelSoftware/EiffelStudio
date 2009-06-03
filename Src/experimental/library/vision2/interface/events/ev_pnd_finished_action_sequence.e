note
	description:
		"Action sequence for a finished pick and drop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "ev_new_item"
	date: "Generated!"
	revision: "Generated!"

class
	EV_PND_FINISHED_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [pick_and_dropable :EV_ABSTRACT_PICK_AND_DROPABLE]]

create
	default_create

create {EV_PND_FINISHED_ACTION_SEQUENCE}
	make_filled

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE])
			-- Extend without type checking.
		do
			extend (agent wrapper (?, action))
		end

	wrapper (a_pick_and_dropable: EV_ABSTRACT_PICK_AND_DROPABLE; action: PROCEDURE [ANY, TUPLE])
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_pick_and_dropable])
		end


feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

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




end -- class EV_PND_FINISHED_ACTION_SEQUENCE

