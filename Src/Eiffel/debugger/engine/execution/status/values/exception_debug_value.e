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
			debug_value_type_id,
			set_hector_addr,
			address
		end

create {RECV_VALUE, ATTR_REQUEST, CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make_with_value, make_without_any_value
create
	make_fake

feature {NONE} -- Initialization

	make_with_value (a_value: like debug_value) is
			-- Create Current with `a_value' as `debug_value'
		do
			name := "Exception occurred"
			set_exception_value (a_value)
		end

	make_without_any_value is
			-- Create Current without any value
		do
			make_with_value (Void)
			set_user_meaning ("Exception occurred (no information)")
		end

	make_fake (t: like user_meaning) is
		do
			make_with_value (Void)
			set_user_meaning (t)
		end

feature -- Report

	short_description: STRING_32 is
			-- Description for Current exception
		local
			l_mesg, l_meaning: STRING_32
			l_type_name: STRING_8
		do
			update_full_data

			create Result.make_empty

			l_mesg := message
			if l_mesg /= Void and then not l_mesg.is_empty then
				Result.append (l_mesg)
				Result.append (": ")
			end

			l_type_name := type_name
			l_meaning := meaning
			if l_meaning = Void or else l_meaning.is_empty then
				if l_type_name /= Void then
					Result.append (l_type_name.to_string_32)
					Result.append_string (" raised")
				else
					Result.append_string ("Exception occurred (no more information).")
				end
			elseif l_mesg = Void or else not l_meaning.is_equal (l_mesg) then
				Result.append_string (l_meaning)
			end
		ensure
			Result_not_void: Result /= Void
		end

	description: STRING_32 is
			-- Computed information message to display
		local
			s: STRING_32
			l_type_name: STRING_8
		do
			create Result.make_from_string (short_description)
			l_type_name := type_name
			if l_type_name /= Void then
				Result.append (" (")
				Result.append (l_type_name.to_string_32)
				Result.append (")")
			end

			s := text
			if s /= Void and then not s.is_empty then
				if not Result.is_empty then
					Result.append_string ("%N")
				end
				Result.append_string (s)
			end
		ensure
			Result_not_void: Result /= Void
		end

	long_description: STRING_32 is
			-- Computed full information message to display
		local
			k: STRING_8
			s: STRING_32
		do
			create Result.make_from_string (description)
			if exception_others /= Void then
				from
					exception_others.start
				until
					exception_others.after
				loop
					k := exception_others.key_for_iteration
					s := exception_others.item_for_iteration
					if k /= Void and s /= Void then
						Result.append_string ("%N")
						Result.append_string (k)
						Result.append_string (": ")
						Result.append_string (s)
					end
					exception_others.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access		

	type_name: STRING_8 is
			-- Type name.	
		do
			Result := exception_type_name
			if Result = Void then
				update_data
				Result := exception_type_name
			end
		end

	code: INTEGER is
			-- Code
		do
			Result := exception_code
			if Result = 0 then
				update_data
				Result := exception_code
			end
		end

	meaning: STRING_32 is
			-- Tag
		do
			Result := user_meaning
			if Result = Void then
				Result := exception_meaning
				if Result = Void then
					update_full_data
					Result := exception_meaning
				end
			end
		end

	message: STRING_32 is
			-- Message
		do
			Result := exception_message
			if Result = Void then
				update_full_data
				Result := exception_message
			end
		end

	text: STRING_32 is
			-- Message
		do
			Result := user_text
			if Result = Void then
				Result := exception_text
				if Result = Void then
					update_heavy_data
					Result := exception_text
				end
			end
		end

	other_info (k: STRING): STRING_32 is
			-- Other info named `k'.
		require
			k_not_void: k /= Void
		do
			if exception_others = Void or else not exception_others.has (k) then
				update_full_data
				if exception_others = Void or else not exception_others.has (k) then
					set_exception_others (Void, k)
				else
					Result := exception_others.item (k)
				end
			else
				Result := exception_others.item (k)
			end
		end

feature -- user change

	reset_user_data is
		do
			user_meaning := Void
		end

	set_user_meaning (a_meaning: STRING_GENERAL) is
			-- Set `user_meaning' to `a_meaning'	
		do
			if a_meaning /= Void then
				if a_meaning.is_string_32 then
					user_meaning := a_meaning
				else
					user_meaning := a_meaning.as_string_32
				end
			else
				user_meaning := Void
			end
		end

	set_user_text (a_text: STRING_GENERAL) is
			-- Set `user_text' to `a_text'	
		do
			if a_text /= Void then
				if a_text.is_string_32 then
					user_text := a_text
				else
					user_text := a_text.as_string_32
				end
			else
				user_text := Void
			end
		end

feature -- Change

	set_exception_value	(a_dbg_value: like debug_value) is
			-- Set associated Exception value
		do
			reset_data
			debug_value := a_dbg_value
			if debug_value /= Void then
				debug_value.set_name (once "<exception>")
			end
		end

	reset_data is
		do
			data_updated := False
			exception_code := 0
			exception_type_name := Void
			exception_meaning := Void
			exception_message := Void
			exception_others := Void
		end

	update_data is
			-- Update using `debug_value' if available
		do
			if not data_updated then
				if has_value then
					debugger_manager.application.get_exception_value_details (Current, 0)
				end
				data_updated := True
			end
		end

	update_full_data is
			-- Update using `debug_value' if available
		do
			if has_value then
				debugger_manager.application.get_exception_value_details (Current, 1)
			end
			data_updated := True
		end

	update_heavy_data is
			-- Update using `debug_value' if available
			-- only for exception text...
		do
			if has_value then
				debugger_manager.application.get_exception_value_details (Current, 2)
			end
			data_updated := True
		end

feature -- Value Access

	has_value: BOOLEAN is
			-- Is Current has an effective Exception debug value ?
		do
			Result := debug_value /= Void
		end

	debug_value: ABSTRACT_REFERENCE_VALUE
			-- Exception debug value

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		do
			if has_value then
				Result := debug_value.dynamic_class
			end
			if Result = Void then
				Result := Eiffel_system.any_class.compiled_class
			end
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_exception_value (Current)
		end

	address: STRING is
			-- Address of the object represented by `Current'. Void if none.
		do
			if has_value then
				Result := debug_value.address
			end
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
			Result := short_description
		end

feature -- Output

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result := has_value
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'.
			-- May be void if there are no children.
			-- Generated on demand.
			-- (sorted by name)
		do
			--| FIXME: we could list essential exception's data as children
			--| using DUMMY_MESSAGE_DEBUG_VALUE objects.
			if has_value then
				create {DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make_equal (1)
				Result.put_last (debug_value)
			end
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

feature {DUMP_VALUE, CALL_STACK_ELEMENT, DBG_EVALUATOR, ABSTRACT_DEBUG_VALUE, IPC_REQUEST, OBJECT_ADDR} -- Hector address

	set_hector_addr
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			if has_value then
				debug_value.set_hector_addr
			end
		end

feature {NONE} -- Implementation

	data_updated: BOOLEAN
			-- Data updated ?

	user_meaning: like exception_meaning
			-- Meaning which override `exception_meaning' is any.

	user_text: like exception_text
			-- Text which override `exception_text' is any.


feature {APPLICATION_EXECUTION} -- Implementation access

	exception_code: INTEGER
			-- Exception code.

	exception_meaning: STRING_32
			-- Exception meaning.

	exception_message: STRING_32
			-- Exception message.

	exception_text: STRING_32
			-- Exception text to display.

	exception_type_name: STRING_8
			-- Exception type name.

	exception_others: DS_HASH_TABLE [STRING_32, STRING]
			-- Other data for the Exception
			-- for instance: module_name for dotnet
			-- ...

feature {APPLICATION_EXECUTION} -- Implementation Change

	set_exception_code (v: like exception_code) is
			-- Set `exception_code' with `v'
		do
			exception_code := v
		end

	set_exception_meaning (v: like exception_meaning) is
			-- Set `exception_meaning' with `v'
		do
			exception_meaning := v
		end

	set_exception_message (v: like exception_message) is
			-- Set `exception_message' with `v'
		do
			exception_message := v
		end

	set_exception_text (v: like exception_text) is
			-- Set `exception_text' with `v'
		do
			exception_text := v
		end

	set_exception_type_name (v: like exception_type_name) is
			-- Set `exception_type_name' with `v'
		do
			exception_type_name := v
		end

	set_exception_others (v: STRING_32; k: STRING) is
			-- Set `exception_type_name' with `v'
		require
			k_not_void: k /= Void
		local
		do
			if exception_others = Void then
				create exception_others.make_equal (2)
			end
			exception_others.force_last (v, k)
		end

;indexing
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


