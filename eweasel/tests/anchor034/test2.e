
class TEST2 [G -> NUMERIC]
feature
	try
		do
			create x
		end

	x: like {TEST2 [like y]}.y

	y: like {G}.plus

end
