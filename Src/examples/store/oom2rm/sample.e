note
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SAMPLE inherit

	MODEL

create

	make

feature

	model: HUMAN
		local
			date: DATE_TIME;
			country: COUNTRY
		once
			create date.make_now;
			create country.make (1, "France");
			create Result.make (1, "Gustave", date, <<country>>);
		end;

	register_keys
		do
			register_key ("h_no", "HUMAN");
			register_key ("c_no", "COUNTRY")
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


end -- class SAMPLE


