class TEST
creation
	make

feature
	make is
		local
			l_grandma: like person
			l_grandpa: TUPLE [STRING, INTEGER]
		do
			l_grandma := ["Suzanne", 73]
			l_grandpa := ["Albert", 73]

			l_grandma := ["Suzanne", 73, 1]
			l_grandpa := ["Albert", 73, 2]
		end

	person: TUPLE [name: STRING; age: INTEGER]

end
