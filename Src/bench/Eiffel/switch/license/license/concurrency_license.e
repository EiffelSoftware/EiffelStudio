class CONCURRENCY_LICENSE inherit

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

	application_delay: INTEGER is 140;

	override_key_line: INTEGER is 18;

feature

	make is
		do
			ise_make
			set_version (3.5)
			set_application_name ("eiffelconcurrent")
			get_licence
		end

feature

	handle_error is
		do
		end;

end -- class CONCURRENCY_LICENSE
