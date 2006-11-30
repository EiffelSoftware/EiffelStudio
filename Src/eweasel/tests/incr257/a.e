class
	A

feature

	f is
		do
			print ((agent g ("base", Void $THIRD_VAL)).generating_type)
			print ("%N")
			(agent g ("base", Void $THIRD_VAL)).call ([Void])
			print ("%N")
		end

	g (s,v $THIRD_DECL: STRING) is
		do
			print (s) print ("%N")
			print (v) print ("%N")
			$THIRD_INST
		end

end
