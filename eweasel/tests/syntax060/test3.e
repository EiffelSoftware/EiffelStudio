class TEST3

feature

	f: STRING
		do
			if attached {TEST} $OBJECT_TEST as loc then
			end
		end


	object: ANY

	b: BOOLEAN

end
