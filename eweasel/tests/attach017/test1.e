class
	TEST1

feature

	f
		do
			if attached {STD_FILES} io as a then
			end
		ensure
			tag: attached {STD_FILES} io as d and then d.default = Void
		end

end
