deferred class
	GENERIC [G -> ANY]

feature

	test: !G
		do
			Result := another_test
		end

	another_test: like test
		deferred
		end

end

