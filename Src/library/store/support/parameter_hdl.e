indexing

	Status: "Objects that handle parameters in dynamic requests"
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases "(At least ODBC)"

class
	PARAMETER_HDL

inherit
	
	STRING_HDL
		redefine
			set_map_name,
			unset_map_name,
			is_mapped,
			mapped_value,
			clear_all
		end

feature

	set_map_name (n: ANY; key: STRING) is
			-- Store item `n' whith key `key'.
		do
			check
				key_allowed: parameter_name_exist (key)
				prepared_statement: is_prepared
				has_parameters: parameter_count > 0
			end
--			set_parameter (n, key)
			ht.put (n, key)
		end

	unset_map_name (key: STRING) is
			-- Remove item associated with key `key'.
		do
			check
				key_allowed: parameter_name_exist (key)
				prepared_statement: is_prepared
			end
--			set_parameter (Void, key)
			ht.remove (key)
		end

	clear_all is
		do
			Precursor
			parameters_value.clear_all
		end

feature -- Status report

	is_mapped (key: STRING): BOOLEAN is
			-- Is `key' mapped to an Eiffel entity ?
		do
			Result := ht.has (key) -- and then mapped_value (key) /= Void
		end

	mapped_value (key: STRING): ANY is
			-- Value mapped with `key'
		do
--			Result := parameters_value.item (parameter_name_to_position.item (key))
			Result := ht.item (key)
		end

	parameter_name_exist (key : STRING) : BOOLEAN is
		require
			not_void: key /= Void
		do
			Result := parameters.has (key)
		end

	is_prepared: BOOLEAN
			-- Is the statement has been prepared ?

	is_executed: BOOLEAN
			-- Is the statement has been executed ?
		
	parameter_count : INTEGER is
			-- number of parameters, set by 'prepare'
		do
			Result := last
		ensure
			result > 0 implies is_prepared
		end

feature -- setting

	set_parameter (value: ANY; key: STRING) is
		require
			key_not_void: key /= Void
			has_parameters: parameter_count > 0
		local
			i : INTEGER
		do
--			parameters_value.force (value, parameter_name_to_position.item (key))
--			parameters_value.force (value, ke))
			from
				i := parameters.lower
			until 
				i > parameters.upper
			loop
				if parameters.item (i).is_equal (key) then
					parameters_value.force (value, i)
				end
				i := i + 1
			end			
		end
	
	set_parameters_value (p : ARRAY[ANY]) is
		require
			has_parameters: parameter_count > 0
		do
			parameters_value := p
		end

	set_prepared (b: BOOLEAN) is
		do
			is_prepared := b
		end

	set_executed (b: BOOLEAN) is
		do
			is_executed := b
		end

	setup_parameters is
			-- setup parameters_value with actual parameters value
		local
			i : INTEGER
		do
			from
				i := parameters.lower
			until
				i > parameters.upper
			loop
				parameters_value.force (ht.item(parameters.item(i)), i)
				i := i + 1
			end
		end
		
feature {PARAMETER_HDL}

	
	parameters_value: ARRAY [ANY]
			-- Values of the parameters of the sql statement

	parameters : ARRAY[STRING]
	
	init is
		do
			create parameters_value.make(1,1)
			create parameters.make (1,1)
			parameters.compare_objects
--			create parameter_name_to_position.make (1)
		end	

	init_implementation (pv : like parameters_value; pp : like parameters) is
		require
			parameters_value_exists: pp /= Void
			parameter_name_to_positions_exists: pv /= Void
		do
			parameters_value := pv
--			parameter_name_to_position := pp
			parameters := pp
		ensure
			parameters_value = pv
--			parameter_name_to_position = pp		
			parameters = pp
		end

--	parameter_name_to_position : HASH_TABLE [INTEGER, STRING]

	replacement_string (key, destination: STRING) is
			-- Replace object associated with `key' by a '?' in `destination'.
			-- and, fill chronologically, the parameters_value array.
		local
--			object: ANY
		do
				destination.append ("?")
--				check
--					parameter_name_to_position_not_void: parameter_name_to_position /= Void
--				end
				last := last + 1
--				parameter_name_to_position.put (last, key)
				parameters.force (key, last)
		end;

	last : INTEGER

end -- class PARAMETER_HDL



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

