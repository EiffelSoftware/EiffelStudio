class DLE_LICENSE inherit

	ISE_LICENSE
		rename
			make as ise_make
		redefine
			handle_error
		end;

create

	make

feature

	application_delay: INTEGER is 90;

	override_key_line: INTEGER is 7;

feature

	make is
		do
			ise_make
			set_version (4.0)
			set_application_name ("eiffeldle")
			get_license
		end

feature

	handle_error is
		do
		end;

end -- class DLE_LICENSE
