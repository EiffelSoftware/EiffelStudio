class TEST1

feature

	try
		do
			create x
			(agent {TEST2}.hamster).call ([x])
			(agent {TEST2}.hamster).call ([y])
			(agent {expanded TEST2}.hamster).call ([y])
		end

	x: TEST2

	y: expanded TEST2

end
