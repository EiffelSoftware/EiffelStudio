class
	TEST

create
	make

feature

	make is
		local
			target_d: $TARGET_MARK D
			source_c: C [$SOURCE_MARK D]
		do
			create source_c.make (create {D})
			target_d := source_c
		end

end
