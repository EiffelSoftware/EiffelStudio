class
	TEST2

inherit
	ANY

inherit {NONE}
	SHARED_ANY

feature

	f is
		do
			print (any_once.twin)
		end

end
