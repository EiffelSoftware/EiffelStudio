class DLE_LICENSE inherit

	ISE_LICENCE
		rename
			make as ise_make
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

	make is
		do
			ise_make
			set_version (3.5)
			set_application_name ("eiffeldle")
			get_licence
		end

feature

	handle_error is
		do
		end;

end -- class DLE_LICENSE
