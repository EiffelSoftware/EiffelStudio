
class TEST
inherit
	PARENT [NATURAL_64]
		redefine
			b
		end

create
	make
feature

	make
		do
		end

	b: like {NATURAL_64}.out
end
