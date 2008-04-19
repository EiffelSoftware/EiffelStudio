class
	TEST2 [G]

inherit
	TEST1 [G]
		redefine
			make
		end

feature

	make (v: like int; g: like item) is
		external
			"C inline use <stdio.h>"
		alias
			"[
				printf("%d %d\n", (int) $v, (int) $g);
				return;
			]"
		end

end
