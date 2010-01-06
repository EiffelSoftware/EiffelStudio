
class TEST

create
	make

feature

	make
		local
			s: STRING
			n: INTEGER
		do
			print (x.has (n))
		end

	x: DS_BINARY_SEARCH_TREE_CONTAINER [STRING, INTEGER]

end
