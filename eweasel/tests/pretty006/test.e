class TEST obsolete "Use another class."
create
	make

feature

	make obsolete "Don't use this" do end try external "C inline" alias "weasel" end
	f (i: INTEGER): INTEGER external "[
		C
			blocking
			signature (EIF_INTEGER): EIF_INTEGER
]" end
	g (a, b: INTEGER): INTEGER external "C inline" alias "[
if ($a > $b)
	return $a;
return $b;
]" end

	h obsolete "[
		This feature should not be used.
		Use feature `try' instead.
				]" do end
		
end
