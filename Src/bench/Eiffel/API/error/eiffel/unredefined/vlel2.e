-- A feature name of an export clause is not a final name of the parent

class VLEL2 

inherit

	VLEL
	
feature

	feature_name: STRING;
			-- Feature name involved

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

end
