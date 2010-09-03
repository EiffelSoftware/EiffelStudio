deferred class A [G -> ANY]

feature

	item (i: INTEGER): G is
		deferred
		end

	f is
		do
			print (item (1))
		end

end
