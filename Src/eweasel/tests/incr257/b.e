class
	B
inherit
	A
		redefine
			g
		end

feature

	g (s,v $THIRD_DECL: STRING) is
		do
			print (s) print ("%N")
			print (v) print ("%N")
			$THIRD_INST
		end

end
