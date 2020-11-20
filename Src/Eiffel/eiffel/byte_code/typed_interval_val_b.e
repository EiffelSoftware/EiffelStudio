note
	description: "Abstract representation of an inspect value of a particular type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPED_INTERVAL_VAL_B [H -> COMPARABLE]

inherit
	INTERVAL_VAL_B
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (v: H)
			-- Initialize `value' with `v'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to Current?
		do
			Result := value = other.value
		end

	is_next (other: like Current): BOOLEAN
			-- Is `other' next to Current?
		do
			Result := other.value = next_value (value)
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is `other' greater than Current?
		do
			Result := value < other.value
		end

feature {TYPED_INTERVAL_B, TYPED_INTERVAL_VAL_B, BYTE_NODE_VISITOR} -- Data

	value: H
			-- Constant value

feature {TYPED_INTERVAL_B} -- C code generation

	generate_interval (other: like Current; once_value: detachable EXPR_B; creators: detachable ARRAY [FEATURE_I])
			-- Generate interval Current..`other'.
		local
			l, u: H
			buf: GENERATION_BUFFER
			done: BOOLEAN
			code_index: like {FEATURE_I}.body_index
			header: like header_generation_buffer
			f: FEATURE_I
		do
				-- Do not use `l > u` as exit test because `l`
				-- will be out of bounds when `u` is the greatest
				-- allowed value.
			from
				header := header_generation_buffer
				buf := buffer
				l := value
				u := other.value
			until
				done
			loop
				buf.put_new_line
				if attached once_value then
					buf.put_string (" || ")
					f := creators [position (l)]
					code_index := f.body_index
					if system.in_final_mode and not system.has_multithreaded then
						header.put_new_line
						header.put_string ("RTOSHF (EIF_REFERENCE, ")
						header.put_integer (code_index)
						header.put_character (')')
						buf.put_string ("RTOSV (")
						buf.put_integer (code_index)
					elseif system.in_final_mode and system.has_multithreaded and then f.is_process_relative then
						header.put_new_line
						header.put_string ("RTOPHR (EIF_REFERENCE, ")
						header.put_integer (code_index)
						header.put_character (')')
						buf.put_string ("RTOPV (")
						buf.put_integer (code_index)
					elseif system.in_final_mode and system.has_multithreaded and then not f.is_process_relative then
							-- Once routine might be not registered yet
							-- Let's do it now
						context.add_thread_relative_once (context.reference_c_type, code_index)
						buf.put_string ("RTOUV (")
						buf.put_integer (context.thread_relative_once_index (code_index))
					elseif not system.in_final_mode and not system.has_multithreaded then
						buf.put_string ("RTOTV (")
						buf.put_string (encoder.feature_name (real_type (once_value.type).type_id (context.context_cl_type), code_index))
					elseif not system.in_final_mode and system.has_multithreaded and then f.is_process_relative then
						buf.put_string ("RTOQV (")
						buf.put_string (encoder.feature_name (real_type (once_value.type).type_id (context.context_cl_type), code_index))
					elseif not system.in_final_mode and system.has_multithreaded and then not f.is_process_relative then
						buf.put_string ("RTOTV (")
						buf.put_string (encoder.feature_name (real_type (once_value.type).type_id (context.context_cl_type), code_index))
					end
					buf.put_two_character (',', ' ')
					once_value.print_register
					buf.put_character (')')
				else
					buf.put_string ("case ")
					generate_value (l)
					buf.put_character (':')
				end
				done := l = u
				l := next_value (l)
			end
		end

feature {NONE} -- Implementation: C code generation

	generate_value (v: like value)
			-- Generate single value `v'.
		require
			value_not_void: value /= Void
		deferred
		end

	next_value (v: like value): like value
			-- Value after given value `v'
		require
			value_not_void: value /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Code generation

	position (v: like value): like {FEATURE_I}.creator_position
			-- `v` treated as a position.
		do
			check valid_inspect_value_type: False then end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
