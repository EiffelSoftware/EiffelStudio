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
			date: ABSOLUTE_DATE;
			country: COUNTRY
		once
			!! date.make;
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
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
