
class PARENT

create
	make, default_create
feature
	
	make
		do
			create a
			a.try
			create b
			b.try
			create c
			c.try
		end

	a: like {TEST3 [like Current]}.default

	b: like {TEST3 [BOOLEAN]}.default

	c: like {TEST3 [like {like Current}.default]}.default

end
