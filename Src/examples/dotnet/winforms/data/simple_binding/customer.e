indexing
	description:"Representation of a customer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	CUSTOMER
	
inherit
	SYSTEM_DLL_COMPONENT

	ANY

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (an_id: like id; a_title: like title; a_first_name: like first_name; a_last_name: like last_name; an_address: like address; a_date_of_birth: like date_of_birth) is
		require
			non_void_an_id: an_id /= Void
			non_empty_an_id: not an_id.is_empty
			non_void_a_title: a_title /= Void
			non_empty_a_title: not a_title.is_empty
			non_void_a_first_name: a_first_name /= Void
			non_empty_a_first_name: not a_first_name.is_empty
			non_void_a_last_name: a_last_name /= Void
			non_empty_a_last_name: not a_last_name.is_empty
			non_void_an_address: an_address /= Void
			non_empty_an_address: not an_address.is_empty
		do
			id := an_id
			title := a_title
			first_name := a_first_name
			last_name := a_last_name
			address := an_address
			date_of_birth := a_date_of_birth
		ensure
			id_set: id = an_id
			title_set: title = a_title
			first_name_set: first_name = a_first_name
			last_name_set: last_name = a_last_name
			address_set: address = an_address
		end

feature -- Access

	id: STRING
	title: STRING
	first_name: STRING
	last_name: STRING
	address: STRING
    date_of_birth: SYSTEM_DATE_TIME

feature -- Status Setting

	set_id (an_id: like id) is
			-- Set `id' with `an_id'.
		require
			non_void_an_id: an_id /= Void
			non_empty_an_id: not an_id.is_empty
		do
			id := an_id
		ensure
			id_set: id = an_id
		end
		
	set_title (a_title: like title) is
			-- Set `title' with `a_title'.
		require
			non_void_a_title: a_title /= Void
			non_empty_a_title: not a_title.is_empty
		do
			title := a_title
		ensure
			title_set: title = a_title
		end
		
	set_first_name (a_first_name: like first_name) is
			-- Set `first_name' with `a_first_name'.
		require
			non_void_a_first_name: a_first_name /= Void
			non_empty_a_first_name: not a_first_name.is_empty
		do
			first_name := a_first_name
		ensure
			first_name_set: first_name = a_first_name
		end
		
	set_last_name (a_last_name: like last_name) is
			-- Set `last_name' with `a_last_name'.
		require
			non_void_a_last_name: a_last_name /= Void
			non_empty_a_last_name: not a_last_name.is_empty
		do
			last_name := a_last_name
		ensure
			last_name_set: last_name = a_last_name
		end
		
	set_address (an_address: like address) is
			-- Set `address' with `an_address'.
		require
			non_void_an_address: an_address /= Void
			non_empty_an_address: not an_address.is_empty
		do
			address := an_address
		ensure
			address_set: address = an_address
		end
		
	set_date_of_birth (a_date_of_birth: like date_of_birth) is
			-- Set `date_of_birth' with `a_date_of_birth'.
		do
			date_of_birth := a_date_of_birth
		end

invariant
	non_void_id: id /= Void
	non_void_title: title /= Void
	non_void_first_name: first_name /= Void
	non_void_address: address /= Void
	non_void_date_of_birth: date_of_birth /= Void

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


end -- Class CUSTOMER
