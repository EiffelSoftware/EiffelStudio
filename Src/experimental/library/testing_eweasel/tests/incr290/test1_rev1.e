class TEST1
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create is
		do
			io.putstring ("In TEST1 creation procedure%N");
			to
		end
end

