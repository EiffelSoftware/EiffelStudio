class
	TEST1

create
	set

feature -- Settings

	set (r1: REAL_32; r2: REAL_64)
		do
			r32 := r1
			r64 := r2
		end

feature -- Access

	r32: REAL_32

	r64: REAL_64

end
