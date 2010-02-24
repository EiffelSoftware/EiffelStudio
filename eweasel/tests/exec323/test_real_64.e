class TEST_REAL_64

create
	make

feature

	make
		do
			test_real_32_equality
			test_real_32_tilde
			test_real_32_lt
			test_real_32_le
			test_real_32_gt
			test_real_32_ge
		end

	test_real_32_equality
		do
			print_boolean (1, {REAL_64}.nan = {REAL_64}.nan)
			print_boolean (2, {REAL_64}.nan /= {REAL_64}.nan)
			print_boolean (3, {REAL_64}.nan = {REAL_64} 0.4)
			print_boolean (4, {REAL_64}.nan /= {REAL_64} 0.4)
		end

	test_real_32_tilde
		do
			print_boolean (5, {REAL_64}.nan ~ {REAL_64}.nan)
			print_boolean (6, {REAL_64}.nan /~ {REAL_64}.nan)
			print_boolean (7, {REAL_64}.nan ~ {REAL_64} 0.4)
			print_boolean (8, {REAL_64}.nan /~ {REAL_64} 0.4)
		end

	test_real_32_lt
		do
			print_boolean (9, {REAL_64}.nan < {REAL_64}.nan)
			print_boolean (10, {REAL_64}.nan < {REAL_64} 0.5)
			print_boolean (11, {REAL_64} 0.5 < {REAL_64}.nan)
		end

	test_real_32_le
		do
			print_boolean (12, {REAL_64}.nan <= {REAL_64}.nan)
			print_boolean (13, {REAL_64}.nan <= {REAL_64} 0.5)
			print_boolean (14, {REAL_64} 0.5 <= {REAL_64}.nan)
		end

	test_real_32_gt
		do
			print_boolean (15, {REAL_64}.nan > {REAL_64}.nan)
			print_boolean (16, {REAL_64}.nan > {REAL_64} 0.5)
			print_boolean (17, {REAL_64} 0.5 > {REAL_64}.nan)
		end

	test_real_32_ge
		do
			print_boolean (18, {REAL_64}.nan >= {REAL_64}.nan)
			print_boolean (19, {REAL_64}.nan >= {REAL_64} 0.5)
			print_boolean (20, {REAL_64} 0.5 >= {REAL_64}.nan)
		end

	print_boolean (i: INTEGER; v: BOOLEAN)
		do
			io.put_integer (i)
			io.put_string (": ")
			io.put_boolean (v)
			io.put_new_line
		end

end
