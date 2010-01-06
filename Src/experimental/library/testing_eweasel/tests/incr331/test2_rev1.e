
class TEST2
feature
	try
		do
			print (value); io.new_line
		end

	value: DOUBLE
		external "C inline"
		alias "29.02"
		end
	
end
