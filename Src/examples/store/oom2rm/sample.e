indexing

	date: "$Date$";
	revision: "$Revision$"

class SAMPLE inherit

	MODEL

creation

	make

feature

	model: HUMAN is
		local
			date: DATE_TIME;
			country: COUNTRY
		once
			!! date.make_now;
			!! country.make (1, "France");
			!! Result.make (1, "Gustave", date, <<country>>);
		end;

	register_keys is
		do
			register_key ("h_no", "HUMAN");
			register_key ("c_no", "COUNTRY")
		end

end -- class SAMPLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
