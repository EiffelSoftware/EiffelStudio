indexing
	description:
		"Factories that store product prototypes in hash tables"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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




end -- class HASHED_PROTOTYPE_FACTORY

