note
	description:
		"Action sequence for general notify events with no parameters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "ev_notify"
	date: "Generated!"
	revision: "Generated!"

class
	EV_NOTIFY_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE]
		export
			{EV_APPLICATION_I} kamikazes_internal
		end

create
	default_create

create {EV_NOTIFY_ACTION_SEQUENCE}
	make_filled

feature -- Basic operations

	wrapper (action: PROCEDURE)
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		obsolete
			"Use `action' directly. [2017-05-31]"
		do
			action.call (Void)
		end

feature -- Element change

	force_extend (action: PROCEDURE)
			-- Extend without type checking.
		obsolete
			"Use `extend' instead and provide the right type of agent. [2017-05-31]"
		do
			extend (agent wrapper (action))
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		obsolete "Use explicit creation instead. See also explanations for `duplicate`. [2018-11-30]"
		do
			create Result.make_filled (n)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
