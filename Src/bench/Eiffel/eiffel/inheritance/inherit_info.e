-- Information about an inherited feature

class INHERIT_INFO 

inherit
	COMPARABLE

	SHARED_WORKBENCH
		undefine
			is_equal
		end
	
create
	make

feature {NONE} -- Initialization

	make (f: like a_feature) is
		do
			a_feature := f
		ensure
			a_feature_set: a_feature = f
		end

feature 

	a_feature: FEATURE_I;
			-- Inherited feature

	parent: PARENT_C;
			-- Parent from which the feature is inherited

	renaming_processed: BOOLEAN;
			-- Has Current already been processed for renaming?

	set_renaming_processed is
			-- Set True to `renaming_processed'.			
		do
			renaming_processed := True
		end;

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
			Result := a_feature.body_index < other.a_feature.body_index;
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

	trace is
		do
			if a_feature/= Void and then a_feature.written_class > System.any_class.compiled_class then
				io.error.putstring ("set a feature in inherit info%N")
				a_feature.trace
				io.error.putstring (a_feature.generator)
				io.new_line
			end
		end
			
end
			
