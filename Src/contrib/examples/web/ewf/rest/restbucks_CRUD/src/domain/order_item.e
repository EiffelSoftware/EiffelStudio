note
	description: "Summary description for {ORDER_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER_ITEM

inherit
	ORDER_ITEM_VALIDATION

create
	make

feature -- Initialization

	make (a_name: STRING_32; a_size: STRING_32; a_option: STRING_32; a_quantity: NATURAL_8)
		do
			set_name (a_name)
			set_size (a_size)
			set_option (a_option)
			set_quantity (a_quantity)
		end

feature -- Access

	name: READABLE_STRING_32
			-- product name type of Coffee(Late, Cappuccino, Expresso)

	option: READABLE_STRING_32
			-- customization option Milk (skim, semi, whole)

	size: READABLE_STRING_32
			-- small, mediumm large

	quantity: NATURAL_8

feature -- Element Change

	set_name (a_name: like name)
		require
			valid_name: is_valid_coffee_type (a_name)
		do
			name := a_name
		ensure
			name_assigned: name.same_string (a_name)
		end

	set_size (a_size: like size)
		require
			valid_size: is_valid_size_option (a_size)
		do
			size := a_size
		ensure
			size_assigned: size.same_string (a_size)
		end

	set_option (a_option: like option)
		require
			valid_option: is_valid_milk_type (a_option)
		do
			option := a_option
		ensure
			option_assigned: option.same_string (a_option)
		end

	set_quantity (a_quantity: NATURAL_8)
		do
			quantity := a_quantity
		ensure
			quantity_assigned: quantity = a_quantity
		end

feature -- Report

	hash_code: INTEGER
			-- Hash code value
		do
			Result := option.hash_code + name.hash_code + size.hash_code + quantity.hash_code
		end

invariant
	valid_size: is_valid_size_option (size)
	valid_coffe: is_valid_coffee_type (name)
	valid_customization: is_valid_milk_type (option)
	valid_quantity: quantity > 0

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
