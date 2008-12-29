note
	description:
		"Factories that create object instances via a string key"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	PROTOTYPE_FACTORY [G]

feature {NONE} -- Initialization

	make
			-- Create factory.
		deferred
		ensure
			no_cloning: not is_cloning_enabled
		end

feature -- Access

	selected_product_key: STRING
			-- Key of selected product

	available_products: ARRAY [STRING]
		require
			not_empty: not is_empty
		deferred
		ensure
			non_empty_result: Result /= Void and then not Result.is_empty
		end

	product: G
			-- Selected product
		require
			product_selected: selected_product_key /= Void
			not_empty: not is_empty
		deferred
		ensure
			non_void_result: Result /= Void
		end

feature -- Measurement

	count: INTEGER
			-- Number of prototypes
		deferred
		end
			
feature -- Status report

	has_product (k: STRING): BOOLEAN
			-- Is there a product with key `k'?
		require
			not_empty: not is_empty
			non_empty_product_string: k /= Void and then not k.is_empty
		deferred
		end

	is_empty: BOOLEAN
			-- Is factory empty?
		deferred
		end
	 
	 is_cloning_enabled: BOOLEAN
	 		-- Are products cloned upon access?
			
feature -- Status setting

	select_product (k: STRING)
			-- Select product with key `k'.
		require
			not_empty: not is_empty
			non_empty_product_string: k /= Void and then not k.is_empty
			product_exists: has_product (k)
		deferred
		ensure
			product_set: selected_product_key = k
		end

	enable_cloning
			-- Turn cloning on.
		do
			is_cloning_enabled := True
		ensure
			cloning_on: is_cloning_enabled
		end

	disable_cloning
			-- Turn cloning off.
		do
			is_cloning_enabled := False
		ensure
			cloning_off: not is_cloning_enabled
		end

feature -- Element change

	extend (v: G; key: STRING)
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

	remove (key: STRING)
			-- Remove product registered under `key'.
		require
			non_empty_key: key /= Void and then not key.is_empty
			key_registered: has_product (key)
		deferred
		ensure
			one_less_product: count = old count - 1
			key_not_registered: not has_product (key)
		end

	wipe_out
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




end -- class PROTOTYPE_FACTORY

