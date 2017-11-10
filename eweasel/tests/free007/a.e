deferred class A

feature

	f
		require
			precondition
		deferred
		ensure
			postcondition
		end

	precondition: BOOLEAN
		do
			Result := True
		end

	postcondition: BOOLEAN
		do
			Result := True
		end

end