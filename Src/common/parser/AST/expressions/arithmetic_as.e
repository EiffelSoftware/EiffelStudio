indexing
	description: "Binary arithmetic operation. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred
	class ARITHMETIC_AS

inherit
	BINARY_AS
		redefine
			balanced
		end

feature -- Properties

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			Result := True
		end

end -- class ARITHMETIC_AS
