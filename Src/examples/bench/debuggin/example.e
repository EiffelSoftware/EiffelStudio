class EXAMPLE creation

	make

feature

	base_object: OBJECT;

	make is
		do
			!! base_object; 
			base_object.operate
		end;

end
