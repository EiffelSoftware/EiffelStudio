indexing
	description:
		"Factories that create object instances via a string key"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	PROTOTYPE_FACTORY [G]

feature {NONE} -- Initialization

	make is
			-- Create factory.
		deferred
		ensure
			no_cloning: not is_cloning_enabled
		end

feature -- Access

	selected_product_key: STRING
			-- Key of selected product

	available_products: ARRAY [STRING] is
		require
			not_empty: not is_empty
		deferred
		ensure
			non_empty_result: Result /= Void and then not Result.is_empty
		end

	product: G is
			-- Selected product
		require
			product_selected: selected_product_key /= Void
			not_empty: not is_empty
		deferred
		ensure
			non_void_result: Result /= Void
		end

feature -- Measurement

	count: INTEGER is
			-- Number of prototypes
		deferred
		end
			
feature -- Status report

	has_product (k: STRING): BOOLEAN is
			-- Is there a product with key `k'?
		require
			not_empty: not is_empty
			non_empty_product_string: k /= Void and then not k.is_empty
		deferred
		end

	is_empty: BOOLEAN is
			-- Is factory empty?
		deferred
		end
	 
	 is_cloning_enabled: BOOLEAN
	 		-- Are products cloned upon access?
			
feature -- Status setting

	select_product (k: STRING) is
			-- Select product with key `k'.
		require
			not_empty: not is_empty
			non_empty_product_string: k /= Void and then not k.is_empty
			product_exists: has_product (k)
		deferred
		ensure
			product_set: selected_product_key = k
		end

	enable_cloning is
			-- Turn cloning on.
		do
			is_cloning_enabled := True
		ensure
			cloning_on: is_cloning_enabled
		end

	disable_cloning is
			-- Turn cloning off.
		do
			is_cloning_enabled := False
		ensure
			cloning_off: not is_cloning_enabled
		end

feature -- Element change

	extend (v: G; key: STRING) is
			-- Add product `v' under `key'
		require
			product_exists: v /= Void
			non_empty_key: key /= Void and then not key.is_empty
			key_not_registered: not has_product (key)
		deferred
		ensure
			one_more_product: count = old count + 1
			key_registered: has_product (key)
		end

feature -- Removal

	remove (key: STRING) is
			-- Remove product registered under `key'.
		require
			non_empty_key: key /= Void and then not key.is_empty
			key_registered: has_product (key)
		deferred
		ensure
			one_less_product: count = old count - 1
			key_not_registered: not has_product (key)
		end

	wipe_out is
			-- Remove all products.
		deferred
		ensure
			empty: is_empty
		end

invariant

	empty_definition: is_empty = (count = 0)
	no_empty_key: selected_product_key /= Void implies 
			not selected_product_key.is_empty
	only_valid_products: selected_product_key /= Void implies 
			has_product (selected_product_key)
		
end -- class PROTOTYPE_FACTORY

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
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
--|----------------------------------------------------------------
