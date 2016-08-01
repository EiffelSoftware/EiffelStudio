note
	description: "[
			Interface to access TYPE and run-time information
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TYPE_UTILITIES

inherit
	REFLECTOR_CONSTANTS

feature -- Access

	type_of_type (a_type_id: INTEGER): TYPE [detachable ANY]
		do
			Result := reflector.type_of_type (a_type_id)
		end

	is_deferred_type (a_type: TYPE [detachable ANY]): BOOLEAN
		do
			Result := a_type.is_deferred
		end

feature -- Factory

	new_special_any_instance (a_type: TYPE [detachable ANY]; count: INTEGER): detachable SPECIAL [detachable ANY]
		do
			check reflector.is_special_type (a_type.type_id) end
			Result := reflector.new_special_any_instance (a_type.type_id, count)
		end

	new_instance_of (a_type_name: detachable READABLE_STRING_GENERAL; a_type: detachable TYPE [detachable ANY]): detachable ANY
		do
			if a_type_name /= Void then
				Result := new_instance_for_type_name (a_type_name)
			end
			if Result = Void and a_type /= Void then
				Result := new_instance_of_effective_type (a_type)
			end
		end

	new_instance_for_type_name (a_type_name: READABLE_STRING_GENERAL): detachable ANY
		do
			if
				attached reflector.dynamic_type_from_string (a_type_name) as l_type_id and then
				l_type_id >= 0 and then attached type_of_type (l_type_id) as l_type
			then
				Result := new_instance_of_effective_type (l_type)
			end
		end

	new_instance_of_effective_type (a_type: TYPE [detachable ANY]): detachable ANY
		do
			if a_type.has_default then
				Result := a_type.default
			end
			if Result = Void and then not is_deferred_type (a_type) then
				Result := new_instance_for_type_id (a_type.type_id)
			end
		end

feature {NONE} -- Implementation		

	new_instance_for_type_id (a_type_id: INTEGER): detachable ANY
		local
			l_retried: BOOLEAN
		do
			if a_type_id < 0 or l_retried then
				Result := Void
			else
				Result := reflector.new_instance_of (a_type_id)
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	reflector: REFLECTOR
		once
			create Result
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
