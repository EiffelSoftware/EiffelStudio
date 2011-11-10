
class TEST5
inherit
	TEST4
		rename
			turkey as ermine
		redefine
			ermine
		end
feature
	ermine: INTEGER
		external "C inline"
		alias "[
			return 47;
			]"
		end
end
