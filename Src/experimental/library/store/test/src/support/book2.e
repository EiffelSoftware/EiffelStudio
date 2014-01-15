note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class BOOK2

inherit
	ANY
		redefine
			out,
			is_equal
		end

create
	make

feature {NONE} -- Init

	make
		do
			create title.make (80)
			create author.make_filled ('x', 80)
			create year.make_now
		end

feature -- Access

	title: STRING

	author: IMMUTABLE_STRING_8

	quantity: INTEGER

	price: DOUBLE

	year: DATE_TIME

	double_value: DOUBLE

feature -- Query

	is_equal (other: like Current): BOOLEAN
			-- Is the same as `other'?
			do
				if other = Current then
					Result := True
				else
					Result := title ~ other.title and then
							author ~ other.author and then
							quantity = other.quantity and then
							price = other.price and then
							year ~ other.year and then
							double_value = other.double_value
				end
		end

feature -- Element Change

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
			create date.make (y,1,1)
			year.set_date (date)
			year.set_time (create {TIME}.make (0, 0, 0))
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

feature -- Access

	out: STRING
			-- Display contents
		do
			create Result.make (100)
			if author /= Void then
				Result.append ("Author:")
				Result.append (author)
				Result.extend ('%N')
			end
			if title /= Void then
				Result.append ("Title:")
				Result.append (title)
				Result.extend ('%N')
			end
			Result.append ("Quantity:")
			Result.append (quantity.out)
			Result.append ("%N")
			Result.append ("Price:")
			Result.append (price.out)
			Result.append ("%N")
			Result.append ("double_value:")
			Result.append (double_value.out)
			Result.extend ('%N')
			if year /= Void then
				Result.append ("First publication:")
				Result.append (year.out)
				Result.extend ('%N')
			end
			Result.extend ('%N')
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class BOOK2


