
class TEST
create
	make
feature
	make
		local
			a: ANY
		do
			a := (agent {like {TEST2}.x}.count).item (["Weasel"])
		end

end
