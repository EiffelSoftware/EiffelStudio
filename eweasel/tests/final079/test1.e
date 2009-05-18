deferred class TEST1

feature

	f
		do
			print (x)
			print (y)
		end

	x: STRING
		deferred
		end

	y: STRING
		deferred
		ensure
			y_attached: Result /= Void
		end

end
