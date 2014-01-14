note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class BOOK4

create
	make

feature

	title: IMMUTABLE_STRING_32

	author: STRING_32

	quantity: INTEGER

	price: DOUBLE

	year: DATE_TIME

	double_value: DOUBLE

 	set_title (t: like title)
			-- Set `title' with `t'
		require
			argument_exists: not (t = Void)
		do
			title := t
		ensure
			title = t
		end

	set_author (a: like author)
			-- Set `author' with `a'
		require
			argument_exists: not (a = Void)
		do
			author := a
		ensure
			author = a
		end

	set_quantity (q: like quantity)
			-- Set `quantity' with `q'
		do
			quantity := q
		end

	set_year (y: INTEGER)
			-- Set `year' with `y'
		local
			date: DATE
		do
			create date.make(y,1,1)
			year.set_date(date)
		end

	set_price (p: like price)
			-- Set `price' with `p'
		do
			price := p
		end

	set_double_value (d: like double_value)
			-- set `double_value' with `d'
		do
			double_value := d
		end

	make
		do
			create title.make_filled ('x', 80)
			create author.make (80)
			create year.make_now
		end

	out_32: STRING_32
			-- Display contents
		do
			create Result.make (100)
			if author /= Void then
				Result.append_string_general ("Author:")
				Result.append (author)
				Result.extend ('%N')
			end
			if title /= Void then
				Result.append_string_general ("Title:")
				Result.append (title)
				Result.extend ('%N')
			end
			Result.append_string_general ("Quantity:")
			Result.append_string_general (quantity.out)
			Result.append_string_general ("%N")
			Result.append_string_general ("Price:")
			Result.append_string_general (price.out)
			Result.append_string_general ("%N")
			Result.append_string_general ("double_value:")
			Result.append_string_general (double_value.out)
			Result.extend ('%N')
			if year /= Void then
				Result.append_string_general ("First publication:")
				Result.append_string_general (year.out)
				Result.extend ('%N')
			end
			Result.extend ('%N')
		end

end
