indexing
	description: "[
		Objects representing delayed calls to a procedure.
		with some operands possibly still open.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE [BASE_TYPE, OPEN_ARGS ->TUPLE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]

end -- class PROCEDURE

