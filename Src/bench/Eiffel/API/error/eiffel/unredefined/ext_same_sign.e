-- Error for specifying an external feature with a different signature
-- (wrong number of argument/result)

class EXT_SAME_SIGN 

inherit

	FEATURE_ERROR

feature 

	code: STRING is "EXT_SAME_SIGN";
			-- Error code

end
