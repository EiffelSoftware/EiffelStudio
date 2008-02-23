indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Request for once functions' result

class
	ONCE_REQUEST

inherit
	IPC_SHARED
	SK_CONST
	DEBUG_EXT
	RECV_VALUE
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

	EXCEPTION_CODE_MEANING

create
	make

feature -- Initialization

	make is
		do
			old_make (Rqst_inspect)
			init_recv_c
		end

	address: STRING

	already_called (once_routine: FEATURE_I): BOOLEAN is
			-- Has `once_routine' already been called?
		require
			exists: once_routine /= Void
			is_once: once_routine.is_once
		local
			l_index: INTEGER
			s: STRING
		do
			debug ("debugger_ipc")
				print (generator + ".already_called (" + once_routine.feature_name + ") %N")
			end
			if not debugger_manager.application_is_executing then
				Result := False
			else
				l_index := once_index (once_routine)
				if once_routine.is_process_relative then
					send_rqst_3_integer (Rqst_once, Out_called, Out_once_per_process, l_index)
				else
					send_rqst_3_integer (Rqst_once, Out_called, Out_once_per_thread, l_index)
				end
				debug ("debugger_ipc")
					print (generator + ".already_called (" + once_routine.feature_name + " ~ 0x" + l_index.to_hex_string + ") : request sent%N")
				end
				s := c_tread
				debug ("debugger_ipc")
					print (generator + ".already_called (" + once_routine.feature_name + ") : request received [" + s + "]%N")
				end
				if s.is_boolean then
					Result := s.to_boolean
				else
					debug ("debugger_ipc")
						print (generator + ".already_called ("+ once_routine.feature_name +") returned ")
						if s /= Void then
							print (s)
						else
							print ("Void")
						end
						print ("%N")
					end
					check False end
					Result := False
				end
			end
debug ("ONCE")
	io.error.put_string ("Once routine `");
	io.error.put_string (once_routine.feature_name);
	io.error.put_string ("' (");
	io.error.put_integer (once_routine.body_index)
	if Result then
		io.error.put_string (") already called.")
	else
		io.error.put_string (") not called yet.")
	end
	io.error.put_new_line
end
			debug ("debugger_ipc")
				print (generator + ".already_called (" + once_routine.feature_name + "): " + Result.out + " %N")
			end
		end

	once_result (once_routine: FEATURE_I): ABSTRACT_DEBUG_VALUE is
			-- Result of `once_routine'
		require
			exists: once_routine /= Void
			is_once: once_routine.is_once
			result_exists: already_called (once_routine)
		do
			debug ("debugger_ipc")
				print (generator + ".once_result (" + once_routine.feature_name + ") : start %N")
			end
			Result := once_data (once_routine)
			debug ("debugger_ipc")
				print (generator + ".once_result (" + once_routine.feature_name + ") : done %N")
			end
		ensure
			result_exists: Result /= Void
		end

feature -- Implementation

	once_data (once_routine: FEATURE_I): ABSTRACT_DEBUG_VALUE is
			-- Fetched data related to `once_routine'
			-- first if it has already been called
			-- then if it failed
			-- and then the result if available.
		require
			exists: once_routine /= Void
			is_once: once_routine.is_once
		local
			l_index: INTEGER
			l_type: TYPE_A
			l_type_value: INTEGER
			l_once_func: ONCE_FUNC_I
			l_const: CONSTANT_I
			exc_v: EXCEPTION_DEBUG_VALUE
			err_v: DUMMY_MESSAGE_DEBUG_VALUE
			proc_v: PROCEDURE_RETURN_DEBUG_VALUE
			l_once_nature: INTEGER
		do
			clear_last_values
			l_index := once_index (once_routine)
			if l_index >= 0 then
				debug ("debugger_ipc")
					print ("### feature is of type : " + once_routine.generating_type + "%N")
				end
				if
					(once_routine.is_function or once_routine.is_constant) and
					once_routine.type /= Void
				then
					l_once_func ?= once_routine
					if l_once_func /= Void then
						l_type := l_once_func.type
					else
						l_const ?= once_routine
						if l_const /= Void then
							l_type := l_const.type
						end
					end
					if l_type /= Void then
							-- FIXME: Manu 2008/02/04: do we need a context type here?
						l_type_value := l_type.sk_value (Void)
					end
				else
					l_type_value := 0
				end
				debug ("debugger_ipc")
					print ("### Called [type=" + l_type_value.out + "]?%N")
				end
				if once_routine.is_process_relative then
					l_once_nature := out_data_per_process
				else
					l_once_nature := out_data_per_thread
				end
				send_rqst_3_integer (Rqst_once, l_once_nature, l_type_value, l_index)
				last_is_called := c_tread.to_boolean
			end
			if last_is_called then
				debug ("debugger_ipc")
					print ("### Failed ?%N")
				end
				last_failed := c_tread.to_boolean
				if not last_failed then
					debug ("debugger_ipc")
						print ("### Result of type[" + l_type_value.out +" ~ 0x" + l_type_value.to_hex_string+"] ?%N")
					end
					if l_type_value = 0 then
						create proc_v.make_with_name (once_routine.feature_name)
						Result := proc_v
					else
						recv_value (Current)
						if is_exception then
							exc_v := exception_item
							reset_recv_value
							if exc_v /= Void then
								exc_v.set_hector_addr
								Result := exc_v
							else
								create {EXCEPTION_DEBUG_VALUE} Result.make_without_any_value
							end
							Result.set_name (once_routine.feature_name)
						else
							Result := item
							reset_recv_value
							if Result /= Void then
								last_result := Result
								Result.set_name (once_routine.feature_name)
								Result.set_hector_addr
							else
								create err_v.make_with_name (once_routine.feature_name)
								err_v.set_message ("Error : unable to retrieve the data.")
								Result := err_v
							end
						end
					end
				else
					recv_value (Current)
					check is_exception: is_exception end
					if is_exception then
						exc_v := exception_item
						reset_recv_value
						check exc_v /= Void end
						if exc_v /= Void then
							Result := exc_v
						else
							create {EXCEPTION_DEBUG_VALUE} Result.make_without_any_value
						end
					else
						if {arv: !ABSTRACT_REFERENCE_VALUE} item then
							create {EXCEPTION_DEBUG_VALUE} Result.make_with_value (arv)
						else
							check should_not_occurred: False end
							create {EXCEPTION_DEBUG_VALUE} Result.make_without_any_value
						end
						reset_recv_value
					end
					Result.set_hector_addr
					Result.set_name (once_routine.feature_name)

					debug ("debugger_ipc")
						print (once_routine.feature_name + " : failed%N")
					end
				end

				debug ("debugger_ipc")
					print (once_routine.feature_name + " : already called%N")
				end
			else
				create err_v.make_with_name (once_routine.feature_name)
				err_v.set_message ("Not yet called")
				Result := err_v
			end

			if Result = Void then
				check should_not_occur: False end
				create err_v.make_with_name (once_routine.feature_name)
				err_v.set_message ("Error! : unable to retrieve the data.")
				Result := err_v
			end
		ensure
			Result /= Void
		end

	once_index (once_routine: FEATURE_I): INTEGER is
			-- Index used in runtime to retrieve once information.
		local
			l_index: INTEGER
			s: STRING
		do
			l_index := once_routine.body_index
			debug ("debugger_ipc")
				print (generator + ".once_index (" + once_routine.feature_name + " ~ " + l_index.out + ")  %N")
			end
			if once_indexes.has (l_index) then
				Result := once_indexes.item (l_index)
				debug ("debugger_ipc")
					print ("%T cached -> " + Result.out + "%N")
				end
			else
					--| FIXME: when ready, we may use FEATURE_I.code_id
				if once_routine.is_process_relative then
					send_rqst_3_integer (Rqst_once, Out_index, Out_once_per_process, l_index)
				else
					send_rqst_3_integer (Rqst_once, Out_index, Out_once_per_thread, l_index)
				end
				s := c_tread
				Result := s.to_integer
				check Result >= 0 end
				once_indexes.put (Result, l_index)
				debug ("debugger_ipc")
					print ("%T fetched -> " + Result.out + "%N")
				end
			end
			debug ("debugger_ipc")
				print (once_routine.feature_name + " : index = " + Result.out + " ~ 0x" + Result.to_hex_string + "%N")
			end
		end

feature -- Last fetched values

	clear_last_values is
		do
			last_is_called := False
			last_failed := False
			last_exception_code := 0
			last_result := Void
		end

	last_is_called: BOOLEAN

	last_failed: BOOLEAN

	last_exception_code: INTEGER

	last_result: ABSTRACT_DEBUG_VALUE

	last_exception_meaning: STRING is
		do
			Result := exception_code_meaning (last_exception_code)
		end

feature -- Recycling

	recycle is
		do
			reset_recv_value
			clear_last_values
			once_indexes.wipe_out
		end

feature -- Impl

	exception_tag_from_code (a_code: INTEGER): STRING is
		do
			Result := exception_code_meaning (a_code)
		end

	Once_indexes: HASH_TABLE [INTEGER, INTEGER] is
			-- Once indexes cached during the debugging session.
		once
			create Result.make (10)
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
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
