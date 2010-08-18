
class TEST
inherit
	TEST1 [INTEGER]
create
	make
feature
	
	make
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
