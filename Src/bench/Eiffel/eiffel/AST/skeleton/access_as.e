indexing
	description: "Abstract description of a non-nested call."
	date: "$Date$"
	revision: "$Revision$"

deferred class ACCESS_AS

inherit
	CALL_AS
		redefine
			byte_node
		end

	SHARED_ARG_TYPES

feature -- Properties

	access_name: STRING is
		deferred
		end

feature

	byte_node: ACCESS_B is
			-- Associated byte code
		deferred
		end

feature -- Convenience

	is_argument: BOOLEAN is
			-- Is this an access to an argument?
		do
		end

end -- class ACCESS_AS
