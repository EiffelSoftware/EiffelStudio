class
	TEST1 [G]

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

	int: INTEGER

	item: G

end
