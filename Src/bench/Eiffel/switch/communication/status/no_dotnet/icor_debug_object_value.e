indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_OBJECT_VALUE

inherit
	ICOR_DEBUG_VALUE
--		redefine
--			init_icor
--		end
--
--create 
--	make_by_pointer
--	
--	
--feature {NONE} -- Access
--	
--	init_icor is
--			-- 
--		do
--			Precursor
--			is_value_class_prop := is_value_class
--		end
--		
--	
--feature {ICOR_EXPORTER} -- Properties
--
--	is_value_class_prop: BOOLEAN
--
--
--feature {ICOR_EXPORTER} -- Access
--
--	get_class: ICOR_DEBUG_CLASS is
--			-- GetClass returns the runtime class of the object in the value. 
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_class (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_field_value (a_class: ICOR_DEBUG_CLASS; a_mdfield_def: INTEGER): ICOR_DEBUG_VALUE is
--			-- GetFieldValue returns a value for the given field in the given
--			-- class. The class must be on the class hierarchy of the object's
--			-- class, and the field must be a field of that class.
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_field_value (item, a_class.item, a_mdfield_def, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
----		ensure
----			success: last_call_success = 0
--		end
--
--	is_value_class: BOOLEAN is
--		local
--			l_result: INTEGER
--		do
--			last_call_success := cpp_is_value_class (item, $l_result)
--			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0			
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_managed_copy: POINTER is
--			-- GetManagedCopy will return an IUnknown that is a managed copy
--			-- of a value class object. This can be used with Common Language Runtime Interop to
--			-- get info about the object, like calling System.Object::ToString
--			-- on it.
--		do
--			last_call_success := cpp_get_managed_copy (item, $Result)
--		ensure
--			success: last_call_success = 0
--		end
--
--	set_from_managed_copy (p: POINTER) is
--			-- SetFromManagedCopy will update a object's contents given a
--			-- managed copy of the object. This can be used after using
--			-- GetManagedCopy to update an object with a changed version.
--		do
--			last_call_success := cpp_set_from_managed_copy (item, p)
--		ensure
--			success: last_call_success = 0
--		end

end -- class ICOR_DEBUG_OBJECT_VALUE


