indexing

	description: 
		"AST represenation of a unary `not' operation.";
	date: "$Date$";
	revision: "$Revision $"

class UN_NOT_AS

inherit

	UNARY_AS
		redefine
			operator_is_keyword
		end

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		once
			Result := "_prefix_not";
		end;

	operator_name: STRING is "not";
	
	operator_is_keyword: BOOLEAN is true;

end -- class UN_NOT_AS
