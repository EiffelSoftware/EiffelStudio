-- Abstract description of a non-nested call

deferred class ACCESS_AS

inherit

	CALL_AS
		redefine
			byte_node
		end

feature

	access_name: STRING is
		deferred
		end;

	byte_node: ACCESS_B is
			-- Associated byte code
		do
		ensure then
			False
		end

end
