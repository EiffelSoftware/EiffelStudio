class BOOK2 

inherit 
	
	ANY
		redefine
			out
		end

create

	make

feature 

	title: STRING

	author: STRING

	quantity: INTEGER

	price: DOUBLE

	year: DATE_TIME

	double_value: DOUBLE

 	set_title (t: STRING) is
			-- Set `title' with `t'
		require
			argument_exists: not (t = Void)
		do
			title := t
		ensure
			title = t
		end


	set_author (a: STRING) is
			-- Set `author' with `a'
		require
			argument_exists: not (a = Void)
		do
			author := a
		ensure
			author = a
		end


	set_quantity (q: INTEGER) is
			-- Set `quantity' with `q'
		do
			quantity := q
		end


	set_year (y: INTEGER) is
			-- Set `year' with `y'
		local
			date: DATE 
		do
			create date.make(y,1,1)
			year.set_date(date)
		end


	set_price (p: DOUBLE) is
            		-- Set `price' with `p'
	        do
			price := p
        	end

	set_double_value (d: DOUBLE) is
			-- set `double_value' with `d'
		do
			double_value := d
		end

	set_from_array (v:  ARRAY [ANY]) is
		local
			q: INTEGER_REF
			p, d: DOUBLE_REF
		do
			title ?= v.item (1)
			author ?= v.item (2)
			year ?= v.item (3)
			q ?= v.item (4)
			p ?= v.item (5)
			d ?= v.item (6)
			quantity := q.item
			price := p.item
			double_value := d.item
		end

	make is
		do
			create title.make (80)
			create author.make (80)
			create year.make_now 
		end


	out: STRING is
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

end -- class BOOK2


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

