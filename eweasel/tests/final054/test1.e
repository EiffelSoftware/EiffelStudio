class
	TEST1 [G]

feature

	make2 (v: like int; g: like item) is
		do
			print (v)
			print (' ')
			print (g)
			print ("%N")
		end

	make (v: like int; g: like item) is
		external
			"C inline use <stdio.h>,<stdlib.h>"
		alias
			"[
				printf("%d %d\n", (int) $v, (int) $g);
				fflush(stdout);
				return;
			]"
		end

	int: INTEGER

	item: G

end
