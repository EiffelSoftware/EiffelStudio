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

	inherited_assertion: BOOLEAN is
			-- (For merging)
		local
			i: INTEGER;
			assert_set: ASSERT_ID_SET
		do
			assert_set := a_feature.assert_id_set;
			if assert_set /= Void then
				from
					i := 1;
				until
					i > assert_set.count or else Result
				loop
					Result := (assert_set.item (i).has_assertion);
					i := i + 1;
				end
			end;
		end;

feature -- Debug

	trace is
		do
			io.error.putstring ("INHERIT_INFO ");
			if a_feature /= Void then
				a_feature.trace;
			end;
			if parent /= Void then
				parent.trace;
			end;
			io.error.new_line;	
		end;

end
			
