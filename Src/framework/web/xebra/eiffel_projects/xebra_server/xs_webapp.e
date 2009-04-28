note
	description: "Summary description for {XS_WEBAPP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

create
	make, make_empty

feature {NONE} -- Initialization


	make_empty
			-- Initialization for `Current'.
		do
			name := ""
			port := 1
			is_running := False
			is_compiled := False
		end


	make (a_name: STRING; a_port: INTEGER)
			-- Initialization for `Current'.
		require
			a_port_pos: a_port >= 0
		do
			name := a_name
			port := a_port
			is_running := False
			is_compiled := False
		ensure
			name_set: name = a_name
			port_set: port = a_port
		end

feature -- Access

	name: STRING assign set_name
	port: INTEGER assign set_port
	is_running: BOOLEAN
	is_compiled: BOOLEAN


feature -- Measurement

feature -- Status report

feature -- Status setting

	set_name (a_name: STRING)
			-- Setter
		do
			name := a_name
		end

	set_port (a_port: INTEGER)
			-- Setter
		require
			a_port_pos: a_port >= 0
		do
			port := a_port
		end


feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
