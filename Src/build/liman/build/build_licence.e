class BUILD_LICENCE

inherit
	ISE_LICENCE

creation
	make

feature

	crypt (t: INTEGER): INTEGER is
		do
			Result := t
		end

	override_key_line: INTEGER is 5;


end
