class TEST

create
	make

feature {NONE}

	make
		local
			titi: like company.mapping
			toto: like company.mapping.item
		do
		end

	intersect (a_company: like company.mapping): detachable like company.mapping
		local
			tiit: like company.mapping.item
		do

		end

	company: detachable TEST1
		do

		end

end
