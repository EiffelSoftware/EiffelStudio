
class TEST3 [G -> ANY create default_create end, H -> ANY create default_create end, I -> ANY]
inherit
	TEST2 [$(PARENT_GENERICS)]
		redefine
			x
		end
feature
	x: like {TEST2 [$(QAT_GENERICS)]}.x
	   do
	   end

end
