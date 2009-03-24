deferred class
	A

feature

	f (a, b, c: detachable ANY): detachable ANY
		require
			a /= Void
			a.out /= Void
		deferred
		ensure
			Result /= Void
			Result.out /= Void
		end

end