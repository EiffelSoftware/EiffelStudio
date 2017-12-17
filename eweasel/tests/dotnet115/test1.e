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
		ensure
			is_class: class
		end

end
