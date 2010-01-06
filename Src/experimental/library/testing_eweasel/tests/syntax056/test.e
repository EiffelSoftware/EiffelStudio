class TEST
create
	make
feature
	
	make is
		do
		end

	f: detachable STRING
		do
			create Result.make (10)
			Result.append ("TEST")
		end

	g (o: ANY; u: STRING; i: INTEGER; b: BOOLEAN): ANY
		do
			Result := ""
		ensure
			e: $EXPRESSION
		end

end
