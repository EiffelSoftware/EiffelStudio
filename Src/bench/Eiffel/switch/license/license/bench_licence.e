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
			Studio_unix_enterprise_key_51 as Product_key,
			Bench_key_45 as Non_commercial_product_key
		export
			{NONE} all
		end
		
create
	make

feature -- Access

	application_delay: INTEGER is 50

	override_key_line: INTEGER is 14;

	license_checksum: INTEGER is 100

end
