indexing
	description: "Binary arithmetic operation. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred
	class ARITHMETIC_AS

inherit
	BINARY_AS
		redefine
			operator_is_keyword, balanced_result,
			balanced, operator_is_special
		end

feature -- Properties

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			Result := True
		end

	balanced_result: BOOLEAN is True
			-- is the result of the infix operation subject to the
			-- balancing rule ?

	operator_is_special: BOOLEAN is True

	operator_is_keyword: BOOLEAN is False

end -- class ARITHMETIC_AS
