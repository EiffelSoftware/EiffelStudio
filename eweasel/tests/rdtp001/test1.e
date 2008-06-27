
class TEST1 [G -> {STRING, STRING, STRING, STRING} create make end]
feature
	try
		do
			create x.make (47)
		end

	x: G

	f (t: Tuple [Any])
		do
		end
end
