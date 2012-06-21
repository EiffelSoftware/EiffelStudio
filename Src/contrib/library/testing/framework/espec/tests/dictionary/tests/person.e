note
	description: "For use in testing DICTIONARY"
class
	PERSON
create
	make
	
feature -- Access

	name: STRING
			
	age: INTEGER

feature{NONE}
	make(n:STRING;a:INTEGER)
			-- create person with name `n' and age `a'
		do
			name := n
			age := a
		end
end
