indexing
class
	FUNCTION [BASE_TYPE, OPEN_ARGS -> TUPLE, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]

feature
	last_result: RESULT_TYPE

end -- class FUNCTION

