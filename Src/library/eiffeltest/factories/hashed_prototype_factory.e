indexing
	description:
		"Factories that store product prototypes in hash tables"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class HASHED_PROTOTYPE_FACTORY [G] inherit

	PROTOTYPE_FACTORY [G]
		undefine
			copy, is_equal
		end

	HASH_TABLE [G, STRING]
		rename
			make as hash_make, current_keys as available_products,
			has as has_product, clear_all as wipe_out
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create factory.
		do
			hash_make (0)
		end
		
feature -- Access

	product: G is
			-- Selected product
		do
			search (selected_product_key)
				check
					item_found: found
						-- Because only supported products are selectable
				end
			if is_cloning_enabled then
				Result := clone (found_item)
			else
				Result := found_item
			end
		end

feature -- Status setting

	select_product (k: STRING) is
			-- Select product with key `k'.
		do
			selected_product_key := k
		end

end -- class HASHED_PROTOTYPE_FACTORY

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
