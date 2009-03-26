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
			"dll %"opengl32.dll%" signature: EIF_INTEGER"
		alias
			"glGetError"
		end
end
