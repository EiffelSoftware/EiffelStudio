class TEST1

feature

	g: TEST1
		do
			Result := Current
		end

	h: LIST [like context]
		do
		end

	context: STRING

end
