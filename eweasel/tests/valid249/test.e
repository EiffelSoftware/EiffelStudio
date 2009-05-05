class
	TEST

create
	make

feature
	make
		local
			t: like Current
		do
			t.$TARGET_NAME $ACTUAL_ARGUMENTS := create {$ACTUAL_TYPE}
		end

	a $ASSIGNER_ARGUMENTS: TEST1 assign $FEATURE_NAME
		do
		end

	c: INTEGER
		do
		end

	set_a (t: $FORMAL_TYPE $FORMAL_ARGUMENTS)
		do
		end

	set_c (t: $FORMAL_TYPE $FORMAL_ARGUMENTS): STRING
		do
		end

	set_d (t: $FORMAL_TYPE; v: INTEGER $FORMAL_ARGUMENTS)
		do
		end


end
