class
	TEST
create
	make

feature

	make is
		do
		end

	test : TEST2[FILE_NAME,TARGET[FILE_NAME]]

	z_panel: Z_PANEL [FILE_NAME]

	sig1: TEST_INVALID_SIGNATURE_1
	sig2: TEST_INVALID_SIGNATURE_2

	dup1: TEST_DUPLICATE_1
	dup2: TEST_DUPLICATE_2
	dup3: TEST_DUPLICATE_3

end
