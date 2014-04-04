note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class BOOK5

inherit
	ANY
		redefine
			out,
			is_equal
		end

feature -- Access

	title: detachable STRING

	author: detachable IMMUTABLE_STRING_8

	text_value: detachable STRING

	quantity: INTEGER

	price: DOUBLE

	year: detachable DATE_TIME

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
		do
			title := t
		ensure
			title = t
		end

	set_author (a: like author)
			-- Set `author' with `a'
		do
			author := a
		ensure
			author = a
		end

	set_text_value (a: like text_value)
			-- Set `text_value' with `a'
		do
			text_value := a
		ensure
			text_value = a
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
			l_year: like year
		do
			l_year := year
			create date.make (y,1,1)
			if l_year = Void then
				create l_year.make_by_date (date)
				year := l_year
			else
				l_year.set_date (date)
			end
			l_year.set_time (create {TIME}.make (0, 0, 0))
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
			if attached author as l_author then
				Result.append ("Author:")
				Result.append (l_author)
				Result.extend ('%N')
			end
			if attached title as l_title then
				Result.append ("Title:")
				Result.append (l_title)
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
			if attached year as l_year then
				Result.append ("First publication:")
				Result.append (l_year.out)
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

end
