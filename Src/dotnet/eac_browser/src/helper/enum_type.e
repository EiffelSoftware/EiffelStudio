indexing
	description: "Special features of eiffel enum type."
	author: "Julien"

class
	ENUM_TYPE

feature -- Implementation
	
	from_integer_signature: STRING is "from_integer(System.Int32)"
			-- signature of feature from_integer.

	to_integer_signature: STRING is "to_integer"
			-- signature of feature to_integer.

	or_signature: STRING is "|(System.AttributeTargets)"
			-- signature of feature infix"|".

	
	from_integer_comment: STRING is "from_integer"
			-- Comment for feature from_integer.

	to_integer_comment: STRING is "to_integer"
			-- Comment for feature to_integer.

	or_comment: STRING is "|(System.AttributeTargets"
			-- Comment for feature infix"|".


end -- class ENUM_TYPE

