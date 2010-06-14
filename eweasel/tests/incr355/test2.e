
class TEST2
feature
	value: STRING
		local
			y: expanded TEST2
		do
			y := y
		end
	
	n: like Current
end
