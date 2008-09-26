
class TEST1 [G -> {STRING, STRING, STRING, STRING} create make end]
feature
	try
		do
			create x.make (47)
			from
			variant
				True
			until
				False
			loop
			end
			from
			until
				False
			loop
			variant
				True
			end
		end

	x: G

	f (t: Tuple [Any])
		do
		end
end
