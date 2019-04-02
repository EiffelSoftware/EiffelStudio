class ZZ3

inherit

	ZZ1
		redefine
			foo
		end
		
feature

	foo: STRING
		do
			Result := generator + "%N"
		end

end