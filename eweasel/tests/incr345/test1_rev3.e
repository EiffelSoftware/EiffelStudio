
deferred class TEST1 [G]
feature
	try
		do
			io.new_line;
			(agent stoat).call ([47, 29])
		end

	stoat (a, b: INTEGER)
		deferred
		end
end
