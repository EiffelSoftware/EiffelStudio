
class TEST

create
	make

feature

	make is
		do
			print (weasel)
			io.new_line
		end

	weasel: STRING
		require
			hamster: value.is_equal ("hamster")
		attribute
			print ("Initializing weasel%N")
			Result := "ermine"
		ensure
			hamster: value.is_equal ("hamster")
		end

	value: STRING
		attribute
			print ("Initializing value%N")
			Result := hamster
		end

	hamster: STRING
		do
			Result := "hamster"
		end

end
