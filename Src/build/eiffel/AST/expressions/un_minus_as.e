class UN_MINUS_AS

inherit

	UNARY_AS

feature 

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		once
			Result := "_prefix_minus";
		end;

	operator_name: STRING is "-";

end
