class
	TEST
create make

feature
	make is
		local
			target_a: $TARGET_MARK A
			source_b: $SOURCE_MARK B
		do
			$CREATE_SOURCE
			target_a := source_b
		end

end
