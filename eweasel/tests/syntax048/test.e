$KW
	what: "A test class"
	no_semicolon: This, item, has, several, values, without, semicolon
	semicolon: This, one, ends, with, a, semicolon;
	$ID: "This one uses `note' as an identifier"

class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
			$ID
		end

feature {NONE} -- Test

	$ID
		do
			io.put_string ("Test: OK")
			io.put_new_line
		end

$KW
	what: "More description";

end