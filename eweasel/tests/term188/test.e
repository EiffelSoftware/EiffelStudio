
class TEST
create
	make
feature
	make
		do
			create x
			x.try

			inspect 1
			when {TEST2}.a then
			when {like y}.b then
			else
			end
		end

	x: TEST1 [TEST2]

	y: detachable TEST2

end

