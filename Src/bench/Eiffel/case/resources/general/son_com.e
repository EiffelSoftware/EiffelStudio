indexing

	description: 
		"Command that has associated attribute.";
	date: "$Date$";
	revision: "$Revision$"

deferred class SON_COM

inherit

	EV_COMMAND

feature -- Initialization

	make (an_object: like parent_object) is
			-- Make the command and set `parent_object' to `an_object'.
		require
			has_parent: an_object /= void
		do
			parent_object := an_object
		ensure
			correctly_set: parent_object = an_object
		end -- make

feature {NONE} -- Implementation

	parent_object: ANY
			-- Parent

invariant

	has_parent: parent_object /= void

end -- class SON_COM
