
class TEST
inherit
	TEST1 [$(ACTUAL_GENERIC)]
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
