deferred class TEST1

feature

	f
		do
			print (x)
			print (y)
			print (z)
			print (w)
		end

	x: STRING
		deferred
		end

	y: STRING
		deferred
		ensure
			y_attached: Result /= Void
		end

	z: STRING
		deferred
		end

	w: INTEGER
		deferred
		ensure
			w > 0
		end

end
