indexing
	description: "License for ISE EiffelStudio"
	date: "$Date$"
	description: "$Revision$"
	
class
	BENCH_LICENSE

inherit
	ISE_LICENSE

	SHARED_CODES
		rename
			Bench_key_45_unix as Product_key,
			Bench_key_45 as Non_commercial_product_key
		export
			{NONE} all
		end
		
creation
	make

feature -- Access

	application_delay: INTEGER is 50

	override_key_line: INTEGER is 14;

	license_checksum: INTEGER is 100

end
