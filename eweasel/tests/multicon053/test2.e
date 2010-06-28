
class TEST2 [G -> {ANY, ANY} create default_create end]
feature
	try
		do
			create x
			x.do_nothing
		end

	x: G
end
