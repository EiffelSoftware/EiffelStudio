
class PARENT

create
	make, default_create
feature
	
	make
		do
			create a
			a.try
		end

	a: like {TEST1 [like Current]}.default

end

