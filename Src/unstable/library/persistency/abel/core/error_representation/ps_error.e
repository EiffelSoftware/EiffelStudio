note
	description: "This class is the ancestor to all objects representing an error that might occur during execution."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_ERROR

inherit

	DEVELOPER_EXCEPTION
		redefine
			tag
		end

feature

	tag: IMMUTABLE_STRING_32
			-- A short description of the current exception.
			-- TODO: Redefine in a meaningful way.
		do
			if attached description as desc then
				Result := desc.as_string_32
			else
				create Result.make_from_string ("An error occurred. No description is available.")

			end


		end

--	description: STRING
			-- A detailed description of the current exception.
--		deferred
--		end

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		deferred
		end

end
