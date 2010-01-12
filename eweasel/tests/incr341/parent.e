
deferred class PARENT

feature

	replaceable: BOOLEAN
		do
			Result := True
		end

	replace
		require
			replaceable: replaceable
		deferred
		ensure
			replaceable: replaceable
		end

invariant
	replaceable: replaceable
end
