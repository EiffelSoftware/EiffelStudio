note
	description: "Common routine for RT_EXTENSION classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_EXTENSION_GENERAL

inherit
	RT_EXTENSION_COMMON

feature -- RT extension identifiers (check eif_debug.h uses the same values)

	Op_enter_feature: 		INTEGER = 10
	Op_leave_feature: 		INTEGER = 11
	Op_rescue_feature: 		INTEGER = 12
	Op_rt_hook:				INTEGER = 13
	Op_rt_assign_attrib:	INTEGER = 14
	Op_rt_assign_local:		INTEGER = 15

feature -- Debugger helper

	debugger_type_string (a_obj: detachable ANY): detachable STRING
			-- Return the evaluation of `a.generating_type.out'
		do
			if a_obj /= Void then
				Result := a_obj.generating_type.out
			end
		end

feature -- Evaluation helper

	tilda_equal_evaluation (a,b: detachable ANY): BOOLEAN
			-- Return the evaluation of `a ~ b'
		do
			Result := a ~ b
		end

	is_equal_evaluation (a,b: ANY): BOOLEAN
			-- Return the evaluation of `a.is_equal (b)'	
		require
			a_b_attached: a /= Void and b /= Void
		do
			Result := a.is_equal (b)
		end

	equal_sign_evaluation (a,b: detachable ANY): BOOLEAN
			-- Return the evaluation of `a = b'
		do
			Result := a = b
		end

feature -- Object storage Access

	saved_object_to (r: detachable ANY; fn: READABLE_STRING_GENERAL): detachable ANY
			-- Save object `r' into file `fn'
		require
			fn_attached: fn /= Void
		local
			file: RAW_FILE
		do
			create file.make_with_name (fn)
			if r /= Void and then (not file.exists or else file.is_writable) then
				file.create_read_write
				file.independent_store (r)
				file.close
				Result := r
			else
				Result := Void
			end
		end

	object_loaded_from (r: detachable ANY; fn: READABLE_STRING_GENERAL): detachable ANY
			-- Loaded object from file `fn'.
			-- if `r' is Void return a new object
			-- else load into `r'
			-- If failure then results Void object.
		require
			fn_attached: fn /= Void
		local
			o: detachable ANY
			file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create file.make_with_name (fn)
				if file.exists and then file.is_readable then
					file.open_read
					o := file.retrieved
					file.close
					if attached {ANY} r as o1 then
						if attached {ANY} o as o2 and then o1.same_type (o2) then
							o1.standard_copy (o2)
							Result := o1
						end
					else
						Result := o
					end
				else
					Result := Void
				end
			else
				Result := r
			end
		rescue
			retried := True
			retry
		end

	object_runtime_info (r: detachable ANY): STRING_32
			-- Representation of the internal information for object `r'.
			--| Semi-colon separated information
			--| class_name=FOO; type_name=FOO; dynamic_type=123;
		local
			int: INTERNAL
		do
			if r /= Void then
				create Result.make (0)
				Result.append ("class_name=")
				Result.append (r.generator)
				Result.append (";")
				Result.append ("type_name=")
				Result.append (r.generating_type.name_32)
				Result.append (";")

				create int
				Result.append ("dynamic_type=")
				Result.append_integer (int.dynamic_type (r))
				Result.append (";")

				Result.append ("field_count=")
				Result.append_integer (int.field_count (r))
				Result.append (";")

				Result.append ("deep_physical_size=")
				Result.append_natural_64 (int.deep_physical_size_64 (r))
				Result.append (";")

				Result.append ("physical_size=")
				Result.append_natural_64 (int.physical_size_64 (r))

			else
				create Result.make_empty
			end
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
