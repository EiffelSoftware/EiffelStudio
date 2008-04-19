class
	TEST1

feature

	f is
		do
			if {a: STD_FILES} io then
			end
		ensure
			tag: {d: STD_FILES} io and then d.default = Void
		end

end
