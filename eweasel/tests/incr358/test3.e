
class TEST3 [H -> ANY create default_create end]
inherit
	TEST1 [H]
	      redefine
			try, x
	      end
	TEST2 [H]
	      rename
			y as x
	      redefine
			try, x
	      end

feature
	try
		do
			precursor {TEST1}
			precursor {TEST2}
		end

	x: H
end

