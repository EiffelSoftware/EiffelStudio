indexing
	description: "Convert a data to its string representation according%
			%to an agent. Use this class when `out' cannot be used."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	DV_VALUE_REDIRECTOR

create
	make,
	make_with_default_size

feature -- Initialization

	make is
			-- Create storage hash-tables.
		do
			create result_table.make (10)
			create inversion_table.make (10)
		end

	make_with_default_size (n_items: INTEGER) is
			-- Make with and allocate space to store at least `n_items'.
		do
			create result_table.make (n_items)
			create inversion_table.make (n_items)
		end

feature -- Access

	redirected_value (data: ANY): STRING is
			-- Return the redirected value from redirector.
		require
			at_least_one_result_set: at_least_one_result_set
		local
			h: HASHABLE
		do
			h ?= data
			if h /= Void then
				if result_table.has (h) then
					Result := result_table.item (h)
				else
					if redirector /= Void then
						Result := redirector.item ([h])
			-- Bug on `extend'.
			--			result_table.extend (Result, h)
						result_table.put (Result, h)
					end
				end
			else
				if redirector /= Void then
					Result := redirector.item ([data])
				end
			end
		end

	inverted_value (s: STRING): ANY is
			-- 
		require
			can_invert: can_invert
		do
			if inversion_table.has (s) then
				Result := inversion_table.item (s)
			else
				if invertor /= Void then
					Result := invertor.item ([s])
		-- Bug on `extend'.
		--			result_table.extend (Result, s)
					inversion_table.put (Result, s)
				end
			end
		end

feature -- Status report

	at_least_one_result_set: BOOLEAN is
			-- Is one way to get a result set?
		do
			Result := redirector /= Void or else result_table /= Void
		end

	can_invert: BOOLEAN is
			-- Can component retrieve data from its indirection?
		do
			Result := invertor /= Void or else inversion_table /= Void
		end

feature -- Basic operations

	set_results (res_t: HASH_TABLE [STRING, HASHABLE]) is
			-- Set values of the redirector result table with `res_t'.
		require
			not_void: res_t /= Void
		do
			result_table := res_t
		ensure
			at_least_one_result_set: at_least_one_result_set
		end

	set_inversion_table (inv_t: HASH_TABLE [ANY, STRING]) is
			-- Set values of the invertor result table with `res_t'.
		require
			not_void: inv_t /= Void
		do
			inversion_table := inv_t
		ensure
			can_invert: can_invert
		end

	set_redirector (red: FUNCTION [ANY, TUPLE [ANY], STRING]) is
			-- Set the redirector to use.
			-- PLEASE set a procedure keeping argument of type ANY to avoid cat calls.
		require
			not_void: red /= Void
		do
			redirector := red
		ensure
			at_least_one_result_set: at_least_one_result_set
		end

	set_invertor (inv: FUNCTION [ANY, TUPLE [STRING], ANY]) is
			-- Set the invertor to use.
			-- Warning: set a procedure keeping result of type ANY to avoid cat calls.
		require
			not_void: inv /= Void
		do
			invertor := inv
		ensure
			can_invert: can_invert
		end

feature {NONE} -- Implementation

	redirector: FUNCTION [ANY, TUPLE [ANY], STRING]
			-- Function to redirect data to a string representation.

	invertor: FUNCTION [ANY, TUPLE [STRING], ANY]
			-- Function to find back data from its string representation.

	result_table: HASH_TABLE [STRING, HASHABLE]
			-- Table to store and access string corresponding to an hashable data.

	inversion_table: HASH_TABLE [ANY, STRING];
			--  Table to store and access data from its string representation.

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_VALUE_REDIRECTOR



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

