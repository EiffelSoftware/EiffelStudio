class
	TEST

create
	make

feature

	make is
		do
		end
			
	f1 is
		external
			"dllwin %"foobar.dll%""
		end

	f2 is
		external
			"dllwin %"foo-bar.dll%""
		end

	f3 is
		external
			"dllwin bar"
		end

	f4 is
		external
			"dllwin %"bar/foo.dll%""
		end


end
