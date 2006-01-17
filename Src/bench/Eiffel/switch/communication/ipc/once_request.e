indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Request for once functions' result

class
	ONCE_REQUEST

inherit
	IPC_SHARED
	DEBUG_EXT
	RECV_VALUE
	SHARED_DEBUG
	COMPILER_EXPORTER
		export
			{NONE} all
		end
	BEURK_HEXER
	EWB_REQUEST
		rename
			make as old_make
		end
	SHARED_WORKBENCH
	REFACTORING_HELPER
	
create
	make

feature 

	make is
		do
			old_make (Rqst_inspect)
			init_recv_c
		end
		
	address: STRING

	already_called (once_routine: E_FEATURE): BOOLEAN is
			-- Has `once_routine' already been called?
		require
			exists: once_routine /= Void
			is_once: feature_i (once_routine).is_once
		local
			real_body_id: INTEGER
		do
			if not Application.is_running then
				Result := False
			else
				real_body_id := once_routine.real_body_id
				send_rqst_3_integer (Rqst_once, Out_called, 0, real_body_id - 1)
				Result := c_tread.to_boolean
			end
	
debug ("ONCE")
	io.error.put_string ("Once routine `");
	io.error.put_string (once_routine.name);
	io.error.put_string ("' (");
	io.error.put_integer (once_routine.real_body_id)
	if Result then
		io.error.put_string (") already called.")
	else
		io.error.put_string (") not called yet.")
	end
	io.error.put_new_line
end
		end

	once_result (once_function: E_FEATURE): ABSTRACT_DEBUG_VALUE is
			-- Result of `once_function'
		require
			exists: once_function /= Void
			is_once: feature_i (once_function).is_once
			is_function: once_function.type /= Void
			result_exists: already_called (once_function)
		local
			real_body_id: INTEGER
		do
			real_body_id := once_function.real_body_id
			send_rqst_3_integer (Rqst_once, Out_result, once_function.argument_count, real_body_id - 1)
			c_recv_value (Current)
			Result := item
			if Result /= Void then
				Result.set_name (once_function.name)
					-- Convert the physical addresses received from 
					-- the application to hector addresses.
				Result.set_hector_addr
			else
					--| FIXME XR: This shouldn't happen, but happens anyway.
					--| It's better to display a dummy once instead of crashing...
				create {REFERENCE_VALUE} Result.make (default_pointer, 1)
			end
		ensure
			result_exists: Result /= Void
		end

	once_eval_result (a_addr: STRING; f: E_FEATURE; dclass: CLASS_C): ABSTRACT_DEBUG_VALUE is
		local
			par: INTEGER
			rout_info: ROUT_INFO
			l_dynclass: CLASS_C
			l_dyntype: CLASS_TYPE
		do
			fixme ("JFIAT: update the runtime to avoid evaluate the once")
			debug ("debugger_trace_eval")
				if a_addr /= Void then
					print (generator + ".once_eval_result (" + a_addr.out + ", " + f.name + ", " + dclass.name_in_upper + ")%N")
				else					
					print (generator + ".once_eval_result (Void, " + f.name + ", " + dclass.name_in_upper + ")%N")
					
				end
			end
			if a_addr = Void then
				fixme ("JFIAT: for expanded value, we can not evaluate the once, so we use the old way")
				Result := once_result (f)
			else
				l_dynclass := dclass
				if l_dynclass /= Void and then l_dynclass.is_basic then
					l_dyntype := associated_reference_class_type (l_dynclass)
				elseif l_dynclass = Void or else l_dynclass.types.count > 1 then
					if a_addr /= Void then
							-- The type has generic derivations: we need to find the precise type.
						l_dyntype := debugged_object_manager.class_type_at_address (a_addr)
						if l_dyntype = Void then
						elseif l_dynclass = Void then
							l_dynclass := l_dyntype.associated_class						
						end
					else
						--| Shouldn't happen: basic types are not generic.
					end
				else
					l_dyntype := l_dynclass.types.first
				end
				
				send_ref_value (hex_to_pointer (a_addr))
	
				if f.is_external then
					par := par + 1
				end
				if f.written_class.is_precompiled then
					par := par + 2
					rout_info := System.rout_info_table.item (f.rout_id_set.first)
					send_rqst_3_integer (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, par)
				else
					send_rqst_3_integer (Rqst_dynamic_eval, f.feature_id, l_dyntype.static_type_id - 1, par)
				end
				c_recv_value (Current)
				Result := item
				if Result /= Void then
					Result.set_name (f.name)
						-- Convert the physical addresses received from 
						-- the application to hector addresses.
					Result.set_hector_addr
				else
						--| FIXME XR: This shouldn't happen, but happens anyway.
						--| It's better to display a dummy once instead of crashing...
					create {REFERENCE_VALUE} Result.make (default_pointer, 1)
				end
			end
		end

feature -- Impl

	associated_reference_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			--| for instance return INTEGER_REF for INTEGER
		require
			cl_not_void: cl /= Void
			cl_is_basic: cl.is_basic
		local
			l_basic: BASIC_I
		do
			l_basic ?= cl.actual_type.type_i
			check
				l_basic_not_void: l_basic /= Void
			end
			Result := l_basic.associated_class_type
		ensure
			associated_reference_class_type_not_void: Result /= Void
		end		

feature -- Contract support

	feature_i (f: E_FEATURE): FEATURE_I is
			-- Return the feature_i associated to `f'.
			--| For contract support only.
		require
			valid_f: f /= Void
		do
			Result := f.associated_feature_i
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

end -- class ONCE_REQUEST	
