indexing
	description: "Exception debug value, named"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION_DEBUG_VALUE

inherit
	ABSTRACT_DEBUG_VALUE
		redefine
			debug_value_type_id
		end

create {RECV_VALUE, ATTR_REQUEST, CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make_with_name

feature {NONE} -- Initialization

	make_with_name (a_name: like name) is
			-- Create current
		do
			set_name (a_name)
		end

feature -- change

	is_wrapper_mode: BOOLEAN
			-- Is Current a "fake" Exception debug value ?
			-- i.e: it was created to hold an effective exception debug value.

	set_wrapper_mode (b: BOOLEAN) is
		do
			is_wrapper_mode := b
		end

	set_code (a_code: INTEGER) is
		do
			code := a_code
		end

	set_tag (a_tag: STRING_GENERAL) is
		do
			if a_tag /= Void then
				if a_tag.is_string_32 then
					tag := a_tag
				else
					tag := a_tag.as_string_32
				end
			end
		end

	set_message (a_mesg: STRING_GENERAL) is
		do
			if a_mesg /= Void then
				if a_mesg.is_string_32 then
					message := a_mesg
				else
					message := a_mesg.as_string_32
				end
			end
		end

	set_exception_value	(a_dbg_value: ABSTRACT_DEBUG_VALUE) is
		do
			debug_value := a_dbg_value
			debug_value.set_name (once "<exception>")
		end

feature -- Access

	debug_value: ABSTRACT_DEBUG_VALUE
			-- Exception debug value

	code: INTEGER
			-- Exception code

	tag: STRING_32
			-- Exception tag

	message: STRING_32
			-- Exception message to display in object tool

	display_tag: STRING_32 is
			-- Computed information message to display in object tool
		do
			if tag /= Void then
				Result := tag.as_string_32
			else
				Result := "Exception occurred"
			end
		end

	display_message: STRING_32 is
			-- Computed information message to display in object tool
		do
			if message /= Void then
				Result := message.as_string_32
			else
				Result := display_tag
			end
		end

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		do
			Result := Eiffel_system.any_class.compiled_class
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_exception_value (Current)
		end

feature {NONE} -- Output

	output_value: STRING_32 is
			-- A STRING representation of the value of `Current'.
		do
			Result := address
		end

	type_and_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			Result := display_tag
		end

feature -- Output

	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'.
			-- May be void if there are no children.
			-- Generated on demand.
			-- (sorted by name)
		do
			Result := Void
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Exception_message_value
		end

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER is
		do
			Result := exception_debug_value_id
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

end

