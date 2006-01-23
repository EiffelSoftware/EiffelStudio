indexing 
	description: "Demonstration of FORMATTING and COUNTABLES"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	name: demo_driver;
	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DEMO_DRIVER

create
	make

feature -- Initialization

	make is
		local
			formatting: FORMATTING;
			countables: COUNTABLES
		do
			io.putstring ("Formatting demonstration%N%N");
			create formatting.make;
			io.putstring ("%NPress <Return> to start Countables demonstration%N");
			io.readline;
			create countables.make;
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DEMO_DRIVER


