-- Information about an inherited feature

class INHERIT_INFO 

inherit

	COMPARABLE
	
feature 

	a_feature: FEATURE_I;
			-- Inherited feature

	parent: PARENT_C;
			-- Parent from which the feature is inherited

	set_a_feature (f: like a_feature) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	set_parent (p: like parent) is
			-- Assign `p' to `parent'.
		do
			parent:= p;
		end;

	infix "<" (other: INHERIT_INFO): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := a_feature.body_id
						<
						other.a_feature.body_id;
		end;
			
end
			
