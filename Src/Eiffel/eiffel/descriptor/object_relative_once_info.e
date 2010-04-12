note
	description: "[
			This class contains information for object relative once (once per object)
			For each object relative once, we add 2 or 3 extra attributes to store 
				- called information
				- exception value (if exception occurred during once's execution)
				- result value (if the once is returning a value, and if no exception occurred)
				
			It is created and populated by FEATURE_TABLE.skeleton for each object relative once.
			
			Those informations are used to generate proper code related to skeleton , check the code:
				- FEATURE_TABLE.skeleton : mainly with C code generation, to declare the extra attributes
				- FEATURE_TABLE.routine_id_array: to keep the mapping between routine id, and the extra attrib
				- SELECT_TABLE.descriptors
				- SELECT_TABLE.add_units
				- CIL_CODE_GENERATOR where we generate private attributes
				
			This information container is kept in the associated CLASS_C
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_RELATIVE_ONCE_INFO

inherit
	COMPILER_EXPORTER

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_once: ONCE_PROC_I)
			-- Create once relative info object
		require
			a_once_attached: a_once /= Void
		do
			once_routine := a_once
			once_routine_id := a_once.rout_id_set.first
			result_type_a := a_once.type
			has_result := result_type_a /= Void and then not result_type_a.is_void
		end

feature -- Basic operations

	reuse (a_once: ONCE_PROC_I)
			-- Reuse current object.
		require
			a_once_attached: a_once /= Void
		do
			if
				a_once.rout_id_set.first = once_routine_id and then
				a_once.same_interface (once_routine)
			then
				debug ("ONCE_PER_OBJECT")
					print (generator + ".reuse: KEEP")
				end
			else
				clean
				make (a_once)
				debug ("ONCE_PER_OBJECT")
					print (generator + ".reuse: REUSED")
				end
			end
			debug ("ONCE_PER_OBJECT")
				print (" => " + a_once.feature_name)
				print ("%N")
			end
		end

feature -- Debug

	debug_output_info (f: FEATURE_I; a_msg: detachable STRING)
			-- Print debug information related to object relative once's info
		local
			l_once: ONCE_PROC_I
		do
			l_once ?= f
			if l_once /= Void then
				print ("Once per object (fid:" + l_once.feature_id.out + " rid:"+ once_routine_id.out +"): " + l_once.written_class.name_in_upper + "." + l_once.feature_name)
			end
			if a_msg /= Void then
				print (" -- " + a_msg)
			end
			print ("%N")
			print ("%T- called: fid=" + called_feature_id.out + " rid=" + called_routine_id.out + "%N")
			print ("%T- except: fid=" + exception_feature_id.out + " rid=" + exception_routine_id.out + "%N")
			print ("%T- result: fid=" + result_feature_id.out + " rid=" + result_routine_id.out + "%N")
		end

feature -- Access

	is_set: BOOLEAN
			-- Is Current object set?
			-- in relation with "reuse"
		do
			Result := called_routine_id /= 0 and exception_routine_id /= 0 and (not has_result or else result_routine_id /= 0)
		end

	once_routine: ONCE_PROC_I
			-- Associated once routine.

	once_routine_id: INTEGER
			-- Routine id of the associated ONCE_PROC_I

feature -- Access: attribute

	called_attribute_i: ATTRIBUTE_I
			-- ATTRIBUTE_I for extra attribute `called_name'

	exception_attribute_i: ATTRIBUTE_I
			-- ATTRIBUTE_I for extra attribute `exception_name'	

	result_attribute_i: ATTRIBUTE_I
			-- ATTRIBUTE_I for extra attribute `result_name'	

	called_name: STRING
			-- Name of extra attribute for called's value	
		do
			Result := names_heap.item (called_name_id)
		end

	exception_name: STRING
			-- Name of extra attribute for exception's value	
		do
			Result := names_heap.item (exception_name_id)
		end

	result_name: STRING
			-- Name of extra attribute for result's value
		do
			Result := names_heap.item (result_name_id)
		end

	called_rout_info: detachable ROUT_INFO
			-- Rout_info associated with `called_attribute_i'
		do
			Result := System.rout_info_table.item (called_routine_id)
		end

	exception_rout_info: detachable ROUT_INFO
			-- Rout_info associated with `exception_attribute_i'	
		do
			Result := System.rout_info_table.item (exception_routine_id)
		end

	result_rout_info: detachable ROUT_INFO
			-- Rout_info associated with `result_attribute_i' if any
		do
			Result := System.rout_info_table.item (result_routine_id)
		end

feature -- Element change

	clean
			-- Clean Current from computed and store data
		do
			debug ("ONCE_PER_OBJECT")
				print (generator + ".clean: "+ once_routine.feature_name + "%N")
			end
			system.rout_info_table.remove (called_routine_id)
			called_attribute_i := Void
			called_feature_id := 0
			called_routine_id := 0

			system.rout_info_table.remove (exception_routine_id)
			exception_attribute_i := Void
			exception_feature_id := 0
			exception_routine_id := 0

			if has_result then
				system.rout_info_table.remove (result_routine_id)
				result_attribute_i := Void
				result_feature_id := 0
				result_routine_id := 0
				has_result := False
				result_type_a := Void
			end
		end

	update
			-- Compute the various attribute_i values.
		do
			get_called_attribute_i
			get_exception_attribute_i
			if has_result then
				get_result_attribute_i
			end
		end

	get_called_attribute_i
			-- Compute `called_attribute_i' value .
		local
			l_id_set: ROUT_ID_SET
			l_att_i: ATTRIBUTE_I
		do
			create l_att_i.make
			l_att_i.set_type (called_type_a, 0)
			l_att_i.set_written_in (once_routine.written_in)
			l_att_i.set_origin_class_id (once_routine.origin_class_id)
			l_att_i.set_feature_id (called_feature_id)
			l_att_i.set_origin_feature_id (called_feature_id)
			l_att_i.set_feature_name_id (called_name_id, called_name_id)
			l_att_i.set_is_transient (once_routine.is_transient)
			l_att_i.set_is_hidden (True)

			create l_id_set.make
			l_id_set.extend (called_routine_id)
			l_att_i.set_rout_id_set (l_id_set)

			l_att_i.process_pattern
			called_attribute_i := l_att_i
		end

	get_exception_attribute_i
			-- Compute `exception_attribute_i' value .	
		local
			l_id_set: ROUT_ID_SET
			l_att_i: ATTRIBUTE_I
		do
			create l_att_i.make
			l_att_i.set_type (exception_type_a, 0)
			l_att_i.set_written_in (once_routine.written_in)
			l_att_i.set_origin_class_id (once_routine.origin_class_id)
			l_att_i.set_feature_id (exception_feature_id)
			l_att_i.set_origin_feature_id (exception_feature_id)
			l_att_i.set_feature_name_id (exception_name_id, exception_name_id)
			l_att_i.set_is_transient (once_routine.is_transient)
			l_att_i.set_is_hidden (True)

			create l_id_set.make
			l_id_set.extend (exception_routine_id)
			l_att_i.set_rout_id_set (l_id_set)

			l_att_i.process_pattern
			exception_attribute_i := l_att_i
		end


	get_result_attribute_i
			-- Compute `result_attribute_i' value .	
		local
			l_id_set: ROUT_ID_SET
			l_att_i: ATTRIBUTE_I
		do
			create l_att_i.make
			l_att_i.set_type (result_type_a, 0)
			l_att_i.set_written_in (once_routine.written_in)
			l_att_i.set_origin_class_id (once_routine.origin_class_id)
			l_att_i.set_feature_id (result_feature_id)
			l_att_i.set_origin_feature_id (result_feature_id)
			l_att_i.set_feature_name_id (result_name_id, result_name_id)
			l_att_i.set_is_transient (once_routine.is_transient)
			l_att_i.set_is_hidden (True)

			create l_id_set.make
			l_id_set.extend (result_routine_id)
			l_att_i.set_rout_id_set (l_id_set)

			l_att_i.process_pattern
			result_attribute_i := l_att_i
		end

feature -- Access: called

	called_type_a: TYPE_A
			-- Type of `called_name' extra attribute
		do
			Result := system.boolean_class.compiled_class.actual_type
		end

	called_feature_id: INTEGER assign set_called_feature_id
			-- feature id of extra attribute: called

	called_routine_id: INTEGER assign set_called_routine_id
			-- routine id of extra attribute: called

	called_name_id: INTEGER assign set_called_name_id
			-- feature name id of extra attribute: called

feature -- Access: exception

	exception_type_a: TYPE_A
			-- Type of `exception_name' extra attribute	
		do
			Result := system.exception_class.compiled_class.actual_type
		end

	exception_feature_id: INTEGER assign set_exception_feature_id
			-- feature id of extra attribute: exception	

	exception_routine_id: INTEGER assign set_exception_routine_id
			-- routine id of extra attribute: exception	

	exception_name_id: INTEGER assign set_exception_name_id
			-- feature name id of extra attribute: exception			

feature -- Access: result

	has_result: BOOLEAN
			-- Has a result?
			-- (i.e: is it a once function? or a once method)

	result_type_a: TYPE_A
			-- Type of `result_name' extra attribute	

	result_feature_id: INTEGER assign set_result_feature_id
			-- feature id of extra attribute: result	

	result_routine_id: INTEGER assign set_result_routine_id
			-- routine id of extra attribute: result	

	result_name_id: INTEGER assign set_result_name_id
			-- feature name id of extra attribute: result

feature -- Element changes

	set_called_feature_id (a_id: INTEGER)
			-- Set feature id related to called attribute
		require
			valid_id: a_id > 0
		do
			called_feature_id := a_id
		end

	set_called_routine_id (a_id: INTEGER)
			-- Set routine id related to called attribute	
		require
			valid_id: a_id > 0
		do
			called_routine_id := a_id
		end

	set_called_name_id (a_id: INTEGER)
			-- Set feature name id related to called attribute	
		require
			valid_id: a_id > 0
		do
			called_name_id := a_id
		end

	set_exception_feature_id (a_id: INTEGER)
			-- Set feature id related to exception attribute	
		require
			valid_id: a_id > 0
		do
			exception_feature_id := a_id
		end

	set_exception_routine_id (a_id: INTEGER)
			-- Set routine id related to exception attribute	
		require
			valid_id: a_id > 0
		do
			exception_routine_id := a_id
		end


	set_exception_name_id (a_id: INTEGER)
			-- Set feature name id related to exception attribute	
		require
			valid_id: a_id > 0
		do
			exception_name_id := a_id
		end

	set_result_feature_id (a_id: INTEGER)
			-- Set feature id related to result attribute	
		require
			valid_id: a_id > 0
		do
			result_feature_id := a_id
		end

	set_result_routine_id (a_id: INTEGER)
			-- Set routine id related to result attribute	
		require
			valid_id: a_id > 0
		do
			result_routine_id := a_id
		end

	set_result_name_id (a_id: INTEGER)
			-- Set feature name id related to result attribute	
		require
			valid_id: a_id > 0
		do
			result_name_id := a_id
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
