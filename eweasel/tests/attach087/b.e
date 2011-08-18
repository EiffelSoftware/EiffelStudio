class B

inherit

	A
		redefine
			 d
		end

create

	make

feature

	d: like Current
			-- detachable B

end
