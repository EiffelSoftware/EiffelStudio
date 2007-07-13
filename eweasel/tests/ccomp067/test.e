class
	TEST

create
	make

feature

	make is
		local
			i: NATURAL_32
		do
			i := glGetError
		end

	glGetError: NATURAL_32 is
		external
			"C [dll32 %"opengl32.dll%"]: EIF_INTEGER"
		alias
			"glGetError"
		end

end
