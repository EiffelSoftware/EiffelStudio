indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_RESOURCE

feature -- Initialization

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

	is_sender: BOOLEAN is
		-- Can the resource be send.
		deferred
		end

	is_receiver: BOOLEAN is
		-- Can the resource	be received.
		deferred
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
	invariant_clause: -- Your invariant here

end -- class EMAIL_RESOURCE
