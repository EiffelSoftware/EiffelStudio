
class TEST
		
create
	make
	
feature

	make is
		local
			s: STRING
		do
			s := storable_path
		end


	storable_path: STRING is
		local
			l_start: STRING
		do
			l_start := "TEST"
			Result := l_start
			Result := global.formatter.composed_path_1 (<<Result>>)
			print (Result.generating_type)
			print ("%N")
			print (Result.is_equal (l_start)) 
			print ("%N")
			Result := global.formatter.composed_path_2 ([Result])
			print (Result.generating_type)
			print ("%N")
			print (Result.is_equal (l_start)) 
			print ("%N")
		end
	
	global: TEST1 is
		do
			create Result
		end
	
end
