class TEST1

feature

	try
		local
			a: ANY
		do
			a := value
			print (a.generating_type); io.put_new_line
		end

	value: ANY
		attribute 
			Result := "Hamster"
		end

end
