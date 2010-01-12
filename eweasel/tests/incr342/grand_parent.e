
deferred class GRAND_PARENT

feature

	writable: BOOLEAN
		deferred
		end

	replace
		require
			writable: writable
		deferred
		end

end
