
class APP_TEXT_IMAGE 

inherit

	EB_TEXT_IMAGE
		undefine
			make
		end

creation

	make

feature -- Creation

	make is
		do
			!!base_left
		end;

end
