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

	INTERNAL_COMPILER_STRING_EXPORTER

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (fi: FEATURE_I)
			-- Create once relative info object
		require
			fi_attached: fi /= Void
		do
			routine := fi
			rout_id_set := fi.rout_id_set
			init_return_info (fi)
			create_name_prefix
		end

feature {OBJECT_RELATIVE_ONCE_INFO, FEATURE_TABLE} -- Initialization		

	init_return_info (fi: FEATURE_I)
			-- Init return type info
		do
			result_type_a := fi.type.as_detachable_type
			has_result := result_type_a /= Void and then not result_type_a.is_void
		end

feature -- Update changes

	updated_with (fi: FEATURE_I): like Current
			-- Current twin updated return info with `fi' information
		do
			create Result.make (routine)
			Result.init_return_info (fi)

			Result.set_called_feature_id (called_feature_id)
			Result.set_called_body_index (called_body_index)
			Result.set_called_name_id (called_name_id)
			Result.set_called_routine_id (called_routine_id)

			Result.set_exception_feature_id (exception_feature_id)
			Result.set_exception_body_index (exception_body_index)
			Result.set_exception_name_id (exception_name_id)
			Result.set_exception_routine_id (exception_routine_id)

			if has_result then
				Result.set_result_feature_id (result_feature_id)
				Result.set_result_body_index (result_body_index)
				Result.set_result_name_id (result_name_id)
				Result.set_result_routine_id (result_routine_id)
			end
		end

feature -- Basic operations

	reuse (fi: FEATURE_I)
			-- Reuse current object.
		require
			fi_attached: fi /= Void
		do
			if
				is_valid and then
				fi.written_class = written_class and then
				fi.rout_id_set.intersect (rout_id_set) and then
				fi.same_interface (routine)
			then
				debug ("ONCE_PER_OBJECT")
					print (generator + ".reuse [" + fi.feature_name + "]: KEEP%N")
					debug_output_info (routine, "Reused identifiers ...")
				end
				init_return_info (fi)
				reset
			else
				clean
				make (fi)
				debug ("ONCE_PER_OBJECT")
					print (generator + ".reuse [" + fi.feature_name + "]: CLEANED+REUSED%N")
				end
			end
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is valid info?
		do
			Result := system.class_of_id (routine.written_in) /= Void
		end

	debug_output: STRING
		do
			Result := routine.feature_name + ":" + rout_id_set.first.out
		end

	debug_output_info (f: FEATURE_I; a_msg: detachable STRING)
			-- Print debug information related to object relative once's info
		local
			l_once: ONCE_PROC_I
		do
			l_once ?= f
			if f.is_object_relative_once then
				print ("Once per object ")
			else
				print ("Routine ")
			end
			print ("(fid:" + f.feature_id.out
					+ " rid:" + debug_output_rout_id_set_info (rout_id_set)
					+ " bid:" + f.body_index.out
					+ "): ")
			if attached system.class_of_id (f.written_in) as c then
				print (c.name_in_upper)
			else
				print ("!Missing-Class!")
			end
			print ("<" + f.written_in.out + ">." + f.feature_name)

			if a_msg /= Void then
				print (" -- " + a_msg)
			end
			print ("%N")
			print ("    - called: fid=" + called_feature_id.out + " rid=" + called_routine_id.out + " bid=" + called_body_index.out +"%N")
			print ("    - except: fid=" + exception_feature_id.out + " rid=" + exception_routine_id.out + " bid=" + exception_body_index.out + "%N")
			if has_result then
				print ("    - result: fid=" + result_feature_id.out + " rid=" + result_routine_id.out + " bid=" + result_body_index.out)
				print ("  TYPE=" + result_type_a.name)
				print ("%N")
			end
		end

	debug_output_rout_id_set_info (a_rout_id_set: ROUT_ID_SET): STRING
			-- Debug output for ROUT_ID_SET
		local
			i,c: INTEGER
		do
			create Result.make_empty
			Result.append_character ('<')
			from
				c := a_rout_id_set.count
				i := 1
			until
				i > c
			loop
				Result.append_integer (a_rout_id_set.item (i))
				if i < c then
					Result.append_character (' ')
				end
				i := i + 1
			end
			Result.append_character ('>')
		end

feature -- Access

	is_set: BOOLEAN
			-- Is Current object set?
			-- in relation with "reuse"
		do
			Result := called_routine_id /= 0 and exception_routine_id /= 0 and (not has_result or else result_routine_id /= 0)
		end

	routine: FEATURE_I
			-- Associated once routine.

	rout_id_set: ROUT_ID_SET
			-- Associated once rout id set

	written_class: CLASS_C
			-- Associated once routine's written class.
		do
			Result := routine.written_class
		end

	is_transient: BOOLEAN
			-- Is related once per object's extra attribute transient?
		do
--			Result := routine.is_transient

			--| FIXME 2010-04-27: Until there is a clear decision (ECMA?)
			--| let's consider the once per object as transient (by default)
			--| without anyway to make it non transient for now (Version 6.6)
			Result := True
		end

feature -- Access: attribute

	attribute_of_feature_id (a_feature_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute related to `a_feature_id' if exists.
		do
			if a_feature_id = called_feature_id then
				Result := called_attribute_i
			elseif a_feature_id = exception_feature_id then
				Result := exception_attribute_i
			elseif a_feature_id = result_feature_id then
				Result := result_attribute_i
			end
		end

	attribute_of_routine_id	(a_routine_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute related to `a_routine_id' if exists.
		do
			if a_routine_id = called_routine_id then
				Result := called_attribute_i
			elseif a_routine_id = exception_routine_id then
				Result := exception_attribute_i
			elseif a_routine_id = result_routine_id then
				Result := result_attribute_i
			end
		end

	called_attribute_i: ATTRIBUTE_I
			-- ATTRIBUTE_I for extra attribute `called_name'

	called_attr_desc: ATTR_DESC
			-- ATTR_DESC for extra attribute `called_name'			

	exception_attribute_i: ATTRIBUTE_I
			-- ATTRIBUTE_I for extra attribute `exception_name'	

	exception_attr_desc: ATTR_DESC
			-- ATTR_DESC for extra attribute `exception_name'				

	result_attribute_i: ATTRIBUTE_I
			-- ATTRIBUTE_I for extra attribute `result_name'	

	result_attr_desc: ATTR_DESC
			-- ATTR_DESC for extra attribute `result_name'				

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

	reset
			-- Reset computed references.
		do
			debug ("ONCE_PER_OBJECT")
				print (generator + ".reset: " + routine.feature_name + "%N")
				debug_output_info (routine, "Reseting")
			end
			called_attribute_i := Void
			called_attr_desc := Void

			exception_attribute_i := Void
			exception_attr_desc := Void

			if has_result then
				result_attribute_i := Void
				result_attr_desc := Void
			end
		end

	clean
			-- Clean Current from computed and store data
		do
			debug ("ONCE_PER_OBJECT")
				print (generator + ".clean: "+ routine.feature_name + "%N")
				debug_output_info (routine, "Cleaning")
			end
			called_attribute_i := Void
			called_attr_desc := Void
			called_feature_id := 0
			called_routine_id := 0
			called_body_index := 0

			exception_attribute_i := Void
			exception_attr_desc := Void
			exception_feature_id := 0
			exception_routine_id := 0
			exception_body_index := 0

			if has_result then
				result_attribute_i := Void
				result_attr_desc := Void
				result_feature_id := 0
				result_routine_id := 0
				result_body_index := 0
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

	get_called_attr_desc
			-- Compute `called_attr_desc' value .	
		local
			l_desc: BOOLEAN_DESC
		do
			create l_desc
			l_desc.set_attribute_name_id (called_name_id)
			l_desc.set_feature_id (called_feature_id)
			l_desc.set_rout_id (called_routine_id)
			l_desc.set_is_transient (is_transient)
			l_desc.set_is_hidden (True)
			called_attr_desc := l_desc
		end

	get_exception_attr_desc
			-- Compute `exception_attr_desc' value .		
		local
			l_desc: REFERENCE_DESC
			l_cl_type_a: detachable CL_TYPE_A
		do
			create l_desc
			if
				attached system.exception_class as l_exception_class
				and then l_exception_class.is_compiled
			then
				create l_cl_type_a.make (system.exception_class_id)
				l_cl_type_a.set_detachable_mark
				l_desc.set_type_i (l_cl_type_a)
			else
				l_desc.set_type_i (system.any_type)
				check exception_class_available: False end
			end

			l_desc.set_attribute_name_id (exception_name_id)
			l_desc.set_feature_id (exception_feature_id)
			l_desc.set_rout_id (exception_routine_id)
			l_desc.set_is_transient (is_transient)
			l_desc.set_is_hidden (True)

			exception_attr_desc := l_desc
		end

	get_result_attr_desc
			-- Compute `result_attr_desc' value .
		require
			has_result: has_result
		local
			l_desc: ATTR_DESC
		do
			l_desc := result_type_a.description_with_detachable_type
			l_desc.set_attribute_name_id (result_name_id)
			l_desc.set_feature_id (result_feature_id)
			l_desc.set_rout_id (result_routine_id)
			l_desc.set_is_transient (is_transient)
			l_desc.set_is_hidden (True)

			result_attr_desc := l_desc
		end

	get_called_attribute_i
			-- Compute `called_attribute_i' value .
		local
			l_id_set: ROUT_ID_SET
			l_att_i: ATTRIBUTE_I
			l_feat_depend: FEATURE_DEPENDANCE
		do
			create l_att_i.make
			l_att_i.set_type (called_type_a, 0)
			l_att_i.set_body_index (called_body_index)
			l_att_i.set_written_in (routine.written_in)
			l_att_i.set_origin_class_id (routine.origin_class_id)
			l_att_i.set_feature_id (called_feature_id)
			l_att_i.set_origin_feature_id (called_feature_id)
			l_att_i.set_feature_name_id (called_name_id, 0)
			l_att_i.set_is_transient (routine.is_transient)
			l_att_i.set_is_hidden (True)

			create l_feat_depend.make
			l_feat_depend.set_feature_name_id (called_name_id)
			routine.record_suppliers (l_feat_depend)

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
			l_feat_depend: FEATURE_DEPENDANCE
		do
			create l_att_i.make
			l_att_i.set_type (exception_type_a, 0)
			l_att_i.set_body_index (exception_body_index)
			l_att_i.set_written_in (routine.written_in)
			l_att_i.set_origin_class_id (routine.origin_class_id)
			l_att_i.set_feature_id (exception_feature_id)
			l_att_i.set_origin_feature_id (exception_feature_id)
			l_att_i.set_feature_name_id (exception_name_id, 0)
			l_att_i.set_is_transient (routine.is_transient)
			l_att_i.set_is_hidden (True)

			create l_feat_depend.make
			l_feat_depend.set_feature_name_id (exception_name_id)
			routine.record_suppliers (l_feat_depend)

			create l_id_set.make
			l_id_set.extend (exception_routine_id)
			l_att_i.set_rout_id_set (l_id_set)

			l_att_i.process_pattern
			exception_attribute_i := l_att_i
		end


	get_result_attribute_i
			-- Compute `result_attribute_i' value .
		require
			has_result: has_result
		local
			l_id_set: ROUT_ID_SET
			l_att_i: ATTRIBUTE_I
			l_feat_depend: FEATURE_DEPENDANCE
		do
			create l_att_i.make
			l_att_i.set_type (result_type_a, 0)
			l_att_i.set_body_index (result_body_index)
			l_att_i.set_written_in (routine.written_in)
			l_att_i.set_origin_class_id (routine.origin_class_id)
			l_att_i.set_feature_id (result_feature_id)
			l_att_i.set_origin_feature_id (result_feature_id)
			l_att_i.set_feature_name_id (result_name_id, 0)
			l_att_i.set_is_transient (routine.is_transient)
			l_att_i.set_is_hidden (True)

			create l_feat_depend.make
			l_feat_depend.set_feature_name_id (result_name_id)
			routine.record_suppliers (l_feat_depend)


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

	called_body_index: INTEGER assign set_called_body_index
			-- body_index of extra attribute: called

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
			Result := system.exception_class.compiled_class.actual_type.as_detachable_type
		end

	exception_body_index: INTEGER assign set_exception_body_index
			-- body_index of extra attribute: exception

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

	result_body_index: INTEGER assign set_result_body_index
			-- body_index of extra attribute: result

	result_feature_id: INTEGER assign set_result_feature_id
			-- feature id of extra attribute: result	

	result_routine_id: INTEGER assign set_result_routine_id
			-- routine id of extra attribute: result	

	result_name_id: INTEGER assign set_result_name_id
			-- feature name id of extra attribute: result

	name_prefix: STRING
			-- Computed name prefix
			-- (common to all attrib names)

feature -- Element changes

	create_name_prefix
			-- Create the name prefix for hidden attributes
		local
			n: STRING
		do
			create n.make (15)
			n.append_character ('_')
			n.append_integer (routine.body_index)
			n.append_character ('_')
			n.append_string (routine.feature_name)
			n.append_character ('_')
			n.append_character ('_')
			name_prefix := n
		end

	create_called_name_id
			-- Set the associated `called_name_id' name id.
		local
			n: STRING
		do
			create n.make (15)
			n.append_string (name_prefix)
			n.append_string ("called")
			names_heap.put (n)
			set_called_name_id (names_heap.found_item)
		ensure
			called_name_id_set: called_name_id > 0 and then called_name /= Void
		end

	create_exception_name_id
			-- Set the associated `exception_name_id'.	
		local
			n: STRING
		do
			create n.make (15)
			n.append_string (name_prefix)
			n.append_string ("exception")
			names_heap.put (n)
			set_exception_name_id (names_heap.found_item)
		ensure
			exception_name_id_set: exception_name_id > 0 and then exception_name /= Void
		end

	create_result_name_id
			-- Set the associated `result_name_id' name id.	
		require
			has_result: has_result
		local
			n: STRING
		do
			create n.make (15)
			n.append_string (name_prefix)
			n.append_string ("result")
			names_heap.put (n)
			set_result_name_id (names_heap.found_item)
		ensure
			result_name_id_set: result_name_id > 0 and then result_name /= Void
		end

feature -- Element changes

	set_called_body_index (a_bi: INTEGER)
			-- Set body index related to called attribute
		require
			valid_bi: a_bi > 0
		do
			called_body_index := a_bi
		end

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

	set_exception_body_index (a_bi: INTEGER)
			-- Set body index related to exception attribute
		require
			valid_bi: a_bi > 0
		do
			exception_body_index := a_bi
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

	set_result_body_index (a_bi: INTEGER)
			-- Set body index related to result attribute
		require
			valid_bi: a_bi > 0
		do
			result_body_index := a_bi
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

invariant
	routine_attached: routine /= Void
	rout_id_set_attached: rout_id_set /= Void

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
