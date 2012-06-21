note
	description: "[
					A dictionary item, which has a KEY and a VALUE. Used in DICTIONARY
					class as a holder that relates a KEY to a VALUE. A dictionary item requires to have
					a KEY.
				  ]"
	author: "Faraz A. Torshizi"
	date: "Jan 4, 2004"
	revision: "1.0"

class
	DIC_ITEM_ [VALUE, KEY]

create
	make

feature -- Creation
	make (v: VALUE; k: KEY)
			-- creates a new dictionary item with key k and value v
		require
			key_non_void: k /= void
		do
			key_item := k
			value_item := v
		ensure
			key_item_set: key_item = k
			value_item_set: value_item = v
		end

feature {DICTIONARY_, DICTIONARY_TESTS_YOURS} -- Access
	get_key: KEY
			-- returns the 'key' of this dictionary item
		require
			true
		do
			Result := key_item
		ensure
			does_not_change_key: key_item = old key_item
			does_not_change_value: value_item = old value_item
		end
	
	get_value: VALUE
			-- returns the 'value' of this dictionary item
		require
			true
		do
			Result := value_item
		ensure
			does_not_change_key: key_item = old key_item
			does_not_change_value: value_item = old value_item
		end
		
		

feature {NONE} -- Implementation
	key_item: KEY	
		-- stores the 'key' value for this dictionary item
	value_item: VALUE
		-- stores the 'value' for this dictionary item
		

invariant
	key_non_void: key_item /= void

end -- class DIC_ITEM
