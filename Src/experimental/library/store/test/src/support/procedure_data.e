note
	description: "Summary description for {PROCEDURE_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE_DATA

create
	make

feature -- Init

	make
		do
			create numeric_t.make_zero
			create title.make (80)
			create author.make (80)
			create year.make_now
		end

feature -- Access

	title: IMMUTABLE_STRING_32

	author: STRING_32

	year: DATE_TIME

	int_16: INTEGER_16

	int_32: INTEGER_32

	int_64: INTEGER_64

	real_32_t: REAL_32

	real_64_t: REAL_64

	numeric_t: DECIMAL

feature -- Element Change

	set_title (a_t: like title)
			-- Set `a_t' with `title'
		do
			title := a_t
		end

	set_author (a_t: like author)
			-- Set `a_t' with `author'
		do
			author := a_t
		end

	set_year (a_t: like year)
			-- Set `a_t' with `year'
		do
			year := a_t
		end

	set_int_16 (i: INTEGER_16)
			-- Set `int_16' with `i'.
		do
			int_16 := i
		end

	set_int_32 (i: INTEGER_32)
			-- Set `int_32' with `i'.
		do
			int_32 := i
		end

	set_int_64 (i: INTEGER_64)
			-- Set `int_64' with `i'.
		do
			int_64 := i
		end

	set_real_32_t (i: REAL_32)
			-- Set `real_32_t' with `i'.
		do
			real_32_t := i
		end

	set_real_64_t (i: REAL_64)
			-- Set `real_64_t' with `i'.
		do
			real_64_t := i
		end

	set_numeric_t (i: DECIMAL)
			-- Set `numeric_t' with `i'.
		do
			numeric_t := i
		end

end
