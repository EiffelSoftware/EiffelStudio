
class TEST
create
	make, default_create
feature
	
	make is
		do
			(agent {like a}.default_create).call ([a])
		end

	a: $CLASS_NAME

end
