class EXAMPLE create

	make

feature

	base_object: OBJECT;

	make is
		do
			create base_object; 
			base_object.operate
		end;

end
