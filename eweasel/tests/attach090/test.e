class TEST

inherit
	A
		redefine
			f
		end

create

	make

feature

	make
		do
		end

	f: $DETACHABLE like Current
		do
			Result := Current
		end

end
