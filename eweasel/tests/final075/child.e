
class CHILD

create
	make_from_parent

convert
	make_from_parent ({PARENT})

feature

	make_from_parent (n: PARENT)
		external
			"C inline"
		alias "[
			printf ("In make_from_parent\n");
			fflush(stdout);
			]"
		end

	turkey: INTEGER = 47

end
