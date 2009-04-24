note
	description: "Summary description for {XS_WEBAPP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_port: INTEGER)
			-- Initialization for `Current'.
		do
			name := a_name
			port := a_port
			is_running := False
		ensure
			name_set: name = a_name
			port_set: port = a_port
		end

feature -- Access

	name: STRING
	port: INTEGER
	is_running: BOOLEAN


feature -- Measurement

feature -- Status report

feature -- Status setting

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
