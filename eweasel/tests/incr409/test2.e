
class TEST2
feature
	try
		require
			good: attached {like Current} Current as x and then x.value
		do
		end

	value: BOOLEAN
		once ("OBJECT")
			Result := True
		end
	
end
