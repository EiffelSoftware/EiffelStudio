class AFTER_CLASS

inherit
	BEFORE_CLASS
		redefine
			image
		end

creation
	make

feature

	image: STRING is
		do
			!! Result.make (0);
			Result.append (" -- ");
			Result.append (class_name);
		end;

end
