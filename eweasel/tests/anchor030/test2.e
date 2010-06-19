
deferred class TEST2
feature
	try
		local
			x: like {expanded TEST2}.value
		do
			print (x); io.new_line
		end
	
	value: INTEGER
		deferred
		end
	
end
