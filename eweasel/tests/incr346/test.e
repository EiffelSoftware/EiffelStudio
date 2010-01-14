
class TEST
inherit
	TEST1 -- [TEST3]
create
	make
feature
	
	make is
		do
			try
		end

	stoat (a, b: INTEGER)
		external "C inline"
		alias "[
			printf("%d %d\n", $a, $b);
			]"
		end
end
