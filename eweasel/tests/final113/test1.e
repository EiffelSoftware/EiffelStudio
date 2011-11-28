
class TEST1
feature

	try
		local
			a: ANY
		do
			a := value
			io.put_string (a.generating_type); io.new_line
		end

	value: ANY
		attribute 
			Result := "Hamster"
		end
end

