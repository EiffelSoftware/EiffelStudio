indexing

	description:
		"Abstract description of a non-nested call. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ACCESS_AS_B

inherit

	ACCESS_AS;

	CALL_AS_B
		redefine
			byte_node
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

end -- class ACCESS_AS_B
