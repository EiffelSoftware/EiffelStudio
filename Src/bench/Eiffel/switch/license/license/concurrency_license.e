class CONCURRENCY_LICENSE inherit

	ISE_LICENSE
		rename
			make as ise_make
		redefine
			handle_error
		end;

creation

	make

feature

	application_delay: INTEGER is 140;

	override_key_line: INTEGER is 18;

	license_checksum: INTEGER is 100

	product_key: STRING is ""
	
	non_commercial_product_key: STRING is ""

feature

	make is
		do
			ise_make
			set_version (4.0)
			set_application_name ("eiffelconcurrent")
			get_license
		end

feature

	handle_error is
		do
		end;

end -- class CONCURRENCY_LICENSE
