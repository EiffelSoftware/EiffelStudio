class TEST

create
	make, make_with_value

feature {NONE} -- Creation

        make
		do
			f (
				01, 02, 03, 04, 05, 06, 07, 08, 09, 10,
				11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
				31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
				41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
				51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
				61, 62, 63,
				create {separate TEST}.make_with_value (1)
			)
			g (
				01, 02, 03, 04, 05, 06, 07, 08, 09, 10,
				11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
				21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
				31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
				41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
				51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
				61, 62, 63, 64,
				create {TEST}.make_with_value (2)
			)
		end

	make_with_value (value: like item)
		do
			item := value
		ensure
			item_set: item = value
		end

feature -- Access

	f (
		a01, a02, a03, a04, a05, a06, a07, a08, a09, a10,
		a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
		a21, a22, a23, a24, a25, a26, a27, a28, a29, a30,
		a31, a32, a33, a34, a35, a36, a37, a38, a39, a40,
		a41, a42, a43, a44, a45, a46, a47, a48, a49, a50,
		a51, a52, a53, a54, a55, a56, a57, a58, a59, a60,
		a61, a62, a63: like item;
		t: separate TEST
	)
		do
			io.put_character ('f')
			io.put_integer (t.item)
			io.put_new_line
		end

	g (
		a01, a02, a03, a04, a05, a06, a07, a08, a09, a10,
		a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
		a21, a22, a23, a24, a25, a26, a27, a28, a29, a30,
		a31, a32, a33, a34, a35, a36, a37, a38, a39, a40,
		a41, a42, a43, a44, a45, a46, a47, a48, a49, a50,
		a51, a52, a53, a54, a55, a56, a57, a58, a59, a60,
		a61, a62, a63, a64: like item;
		t: TEST
	)
		do
			io.put_character ('g')
			io.put_integer (t.item)
			io.put_new_line
		end

	item: INTEGER

end
