indexing

	description: 
		"AST representation of a non-nested call."
	date: "$Date$"
	revision: "$Revision$"

deferred class ACCESS_AS

inherit

	CALL_AS

feature -- Properties

	access_name: STRING is
		deferred
		end

end -- class ACCESS_AS
