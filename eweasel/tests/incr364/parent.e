
class PARENT [G]
inherit
	GRAND_PARENT [G]
		redefine
			b
		end
feature
	
	b: like {G}.out.xxx
end
