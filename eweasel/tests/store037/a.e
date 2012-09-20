class A

create
	make

feature {NONE} -- Creation

	make
		do
			s := "NON_VOLATILE"
		end

feature -- Access

	s: STRING
		-- This signature is detachable in a non-void-safe system.

end
