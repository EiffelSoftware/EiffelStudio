note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_CONFIG

inherit
	XI_CONFIG
		redefine
			make_empty
		end

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create name.make_empty
			create port.make_empty
			create is_interactive.make_empty
		ensure then
			name_attached: name /= Void
			port_attached: port /= Void
			is_interactive_attached: is_interactive /= Void
		end

feature -- Access

	name: SETTABLE_STRING assign set_name

	port: SETTABLE_INTEGER assign set_port

	is_interactive: SETTABLE_BOOLEAN assign set_is_interactive

feature -- Status report

feature -- Status setting

	set_name (a_name: like name)
			-- Sets name
		require
			a_name_attached: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_port  (a_port: like port)
			-- Sets port
		require
			a_port_attached: a_port /= Void
		do
			port  := a_port
		ensure
			port_set: port  = port
		end

	set_is_interactive (a_is_interactive: like is_interactive)
			-- Sets is_interactive
		require
			a_is_interactive_attached: a_is_interactive /= Void
		do
			is_interactive  := a_is_interactive
		ensure
			is_interactive_set: is_interactive  = a_is_interactive
		end
invariant
		name_attached: name /= Void
		port_attached: port /= Void
		is_interactive_attached: is_interactive /= Void
end

