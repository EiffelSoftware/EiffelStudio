class DLE_LICENSE inherit

	ISE_LICENCE
		redefine
			handle_error
		end;

	SHARED_LICENSE

creation

	make

feature

	application_delay: INTEGER is 90;

	override_key_line: INTEGER is 7;

feature

	dle_registered: BOOLEAN is
			-- Does the current license support DLE mechanism?
		do
				-- Make sure there is no interference with
				-- the Bench regular license.
			discard_licence;
			set_version (3.5);
			set_application_name ("eiffeldle");
			get_licence;
			Result := licensed;
			discard
		end;

	handle_error is
		do
		end;

end -- class DLE_LICENSE
