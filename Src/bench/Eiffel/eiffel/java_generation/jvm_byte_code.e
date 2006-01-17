indexing
	description: "a chunk of java byte code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_BYTE_CODE

inherit
	
	SHARED_JVM_CLASS_REPOSITORY
			
	APPENDABLE_NETWORK_BYTE_ARRAY
		export {NONE}
			store
		end

create
	make,
	make_size

feature {NONE} -- Initialization

feature {ANY}

	constant_pool: CONSTANT_POOL

feature {ANY}
			
	set_constant_pool (cp: CONSTANT_POOL) is
		do
			constant_pool := cp
		end
			
	put_class (cpi: INTEGER pos: INTEGER) is
			-- put class identified with constant pool index `cpi' at
			-- position `pos'
		require
			valid_cpi: cpi > 0
			pos_small_enough: (pos + Int_16_size) <= count;
			pos_large_enough: pos > 0;
		do
			put_uint_16_from_int (cpi, pos)
		end
			
	append_class (cpi: INTEGER) is
		require
			valid_cpi: cpi > 0
		do
			append_uint_16_from_int (cpi)
		end
	
	append_class_by_type_id (a_type_id: INTEGER) is
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_type_id: repository.valid_id (a_type_id)
		do
			constant_pool.class_type_id_to_cpe.search (a_type_id)
			if
				not constant_pool.class_type_id_to_cpe.found
			then
				constant_pool.put_class_by_type_id (a_type_id)
			end
							
			check
				has_key: constant_pool.class_type_id_to_cpe.has (a_type_id)
			end
						  	
			append_class (constant_pool.class_type_id_to_cpe.item (a_type_id))
		end
			
	append_class_by_name (name: STRING) is
			-- appends an cpe index in the byte code pointing to a class 
			-- named `name'. CPE Entry will be created if not yet existant.
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_name: name /= Void and then not name.is_empty
		do
			constant_pool.put_class (name)
			append_class (constant_pool.last_cpe_index)
		end
			
	emit (file: RAW_FILE) is
		require
			constant_pool_closed: constant_pool /= Void implies constant_pool.is_closed
		do
			ca_store ($area, position - 1, file.file_pointer)
		end
			
	append_feature_by_type_id (a_type_id, a_feature_type_id: INTEGER) is
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_type_id: repository.valid_id (a_type_id)
			valid_feature_type_id: repository.item (a_type_id).features.valid_index (a_feature_type_id)
		do
			constant_pool.put_feature_by_type_id (a_type_id, a_feature_type_id)
			append_feature (constant_pool.last_cpe_index)
		end
			
	append_feature_by_object (f: JVM_WRITTEN_FEATURE) is
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_f: f /= Void
		do
			constant_pool.put_feature_by_object (f)
			append_feature (constant_pool.last_cpe_index)
		end
									
	append_feature (cpi: INTEGER) is
		require
			valid_cpi: cpi > 0
		do
			append_uint_16_from_int (cpi)
		end
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class JVM_BYTE_CODE




