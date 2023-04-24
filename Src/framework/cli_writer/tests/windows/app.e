note
	description: "Summary description for {APPLICATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	APP

create
	make

feature {NONE} -- Implementation

	make
		do
			(create {TEST_METADATA_TABLES}).test_empty_assembly;
--			(create {TEST_METADATA_TABLES}).test_define_assembly;
--			(create {TEST_METADATA_TABLES}).test_cli_directory_size;
--			(create {TEST_METADATA_TABLES}).test_cli_header_size;

		end
end
