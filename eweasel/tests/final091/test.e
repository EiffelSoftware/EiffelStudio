
class TEST
create
	make
feature
	make
		do
			try
		end

	try
		do
			create {CHILD [STRING]} z
			z.try
		end

	z: TEST1

end

