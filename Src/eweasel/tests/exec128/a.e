
class A

feature -- Access

	entity: B

	original: B

feature -- Basic operations

	attempt (orig: like original) is
		do
			entity ?= orig
			if entity /= Void then
				io.print (generating_type)
				io.print (" succeeded%N")
			end
		end

end

