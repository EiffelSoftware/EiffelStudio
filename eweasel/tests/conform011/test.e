class
    TEST

create
	make

feature 

	make
		local
			target: $TYPE_TARGET
			source: $TYPE_SOURCE
		do
			create target
			create source

			$ASSIGNMENT

			$FEATURE_CALL
		end

end
