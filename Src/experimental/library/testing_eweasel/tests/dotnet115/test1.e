deferred class
	TEST1

feature

	printf
		external
			"C inline"
		alias
			"[
				printf ("Coucou\n");
			]"
		end

end
