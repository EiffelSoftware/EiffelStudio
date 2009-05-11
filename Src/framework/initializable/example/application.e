indexing
	description : "initializable application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_boolean: INITIALIZABLE_BOOLEAN
		do
			create l_boolean.make_empty

				-- Yields an assertion violation
--			if l_boolean.value then
--				print (l_boolean)
--			end

			l_boolean := False

			if not l_boolean.value then
				print (l_boolean)
			end
		end

end
