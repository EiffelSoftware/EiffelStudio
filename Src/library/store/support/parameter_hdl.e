note
	status: "See notice at end of class."
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: "All_Bases (At least ODBC)"

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

	set_map_name (n: ANY; key: STRING)
			-- Store item `n' whith key `key'.
		do
			check
				key_allowed: parameter_name_exist (key)
				prepared_statement: is_prepared
				has_parameters: parameter_count > 0
			end
--			set_parameter (n, key)
			ht.put (n, key)
			ht_order.extend (key)
		end

	unset_map_name (key: STRING)
			-- Remove item associated with key `key'.
		do
			check
				key_allowed: parameter_name_exist (key)
				prepared_statement: is_prepared
			end
--			set_parameter (Void, key)
			ht.remove (key)
			ht_order.prune (key)
		end

	clear_all
		do
			Precursor
			parameters_value.clear_all
		end

feature -- Status report

	is_mapped (key: STRING): BOOLEAN
			-- Is `key' mapped to an Eiffel entity ?
		do
			Result := ht.has (key) -- and then mapped_value (key) /= Void
		end

	mapped_value (key: STRING): ANY
			-- Value mapped with `key'
		do
--			Result := parameters_value.item (parameter_name_to_position.item (key))
			Result := ht.item (key)
		end

	parameter_name_exist (key : STRING) : BOOLEAN
		require
			not_void: key /= Void
		do
			Result := parameters.has (key)
		end

	is_prepared: BOOLEAN
			-- Is the statement has been prepared ?

	is_executed: BOOLEAN
			-- Is the statement has been executed ?
		
	parameter_count : INTEGER
			-- number of parameters, set by 'prepare'
		do
			Result := last
		ensure
			result > 0 implies is_prepared
		end

feature -- setting

	set_parameter (value: ANY; key: STRING)
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
	
	set_parameters_value (p : ARRAY[ANY])
		require
			has_parameters: parameter_count > 0
		do
			parameters_value := p
		end

	set_prepared (b: BOOLEAN)
		do
			is_prepared := b
		end

	set_executed (b: BOOLEAN)
		do
			is_executed := b
		end

	setup_parameters
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
	
	init
		do
			create parameters_value.make(1,1)
			create parameters.make (1,1)
			parameters.compare_objects
--			create parameter_name_to_position.make (1)
		end	

	init_implementation (pv : like parameters_value; pp : like parameters)
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

	replacement_string (key, destination: STRING)
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

	last : INTEGER;

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




end -- class PARAMETER_HDL



