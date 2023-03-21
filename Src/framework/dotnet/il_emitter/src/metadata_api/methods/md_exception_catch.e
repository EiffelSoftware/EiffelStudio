note
	description: "Description of an exception catch clause."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EXCEPTION_CATCH

inherit

	MD_EXCEPTION_CLAUSE
		rename
			class_token_or_filter_offset as class_token
		redefine
			class_token,
			is_defined,
			reset
		end

create
	make

feature -- Reset

	reset
			-- Restore default values.
		do
			class_token := 0
			state := Start_state
			Precursor
		ensure then
			class_token_set: class_token = 0
			state_set: state = Start_state
		end

feature -- Status report

	is_defined: BOOLEAN
			-- Is current a fully described exception clause?
		do
			Result := Precursor and then class_token /= 0
		ensure then
			valid_class_token: Result implies
				(class_token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_def or else
				class_token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_ref or else
				class_token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_spec)
			valid_state: state = Frozen_state implies Result
		end

	flags: INTEGER_16
			-- Flags of exception clause
		do
			Result := {MD_METHOD_CONSTANTS}.clause_exception
		ensure then
			definition: Result = {MD_METHOD_CONSTANTS}.clause_exception
		end

feature -- Access

	class_token: INTEGER
			-- Meta data token for type-based exception handler

feature -- Modification

	set_class_token (token: like class_token)
			-- Set `class_token' to `token'.
		require
			valid_token:
				token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_def or else
				token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_ref or else
				token & {MD_TOKEN_TYPES}.md_mask = {MD_TOKEN_TYPES}.md_type_spec
		do
			class_token := token
		ensure
			class_token_set: class_token = token
		end

feature -- Access

	start_position: INTEGER
			-- Starting index of `try-catch' clause in associated MD_METHOD_BODY.
		require
			is_defined: is_defined
		do
			Result := try_offset
		end

	catch_position: INTEGER
			-- Index of where `catch' starts.
		require
			is_defined: is_defined
		do
			Result := handler_offset
		end

	type_token: INTEGER
			-- Token type on which catch clause will stop.
			-- Usually token for System.Exception.
		require
			is_defined: is_defined
		do
			Result := class_token
		end

	end_position: INTEGER
			-- Ending index of `try-catch' clause in associated MD_METHOD_BODY.
		require
			is_defined: is_defined
		do
			Result := handler_offset + handler_length
		end

feature -- Settings

	set_start_position (p: INTEGER)
			-- Set `start_position' to `p'.
		require
			valid_p: p >= 0
			valid_state: state = Start_state
		do
			set_try_offset (p)
			state := Catch_state
		ensure
			start_position_set: start_position = p
			state_set: state = Catch_state
		end

	set_catch_position (p: INTEGER)
			-- Set `catch_position' to `p'.
		require
			valid_p: p >= start_position
			valid_state: state = Catch_state
		do
			set_try_end (p)
			set_handler_offset (p)
			state := Type_state
		ensure
			catch_position_set: catch_position = p
			state_set: state = Type_state
		end

	set_type_token (p: INTEGER)
			-- Set `type_token' to `p'.
		require
			valid_p: p /= 0
			valid_state: state = Type_state
		do
			set_class_token (p)
			state := End_state
		ensure
			type_token_set: type_token = p
			state_set: state = End_state
		end

	set_end_position (p: INTEGER)
			-- Set `end_position' to `p'.
		require
			valid_p: p >= catch_position
			valid_state: state = End_state
		do
			set_handler_end (p)
			state := Frozen_state
		ensure
			end_position_set: end_position = p
			state_set: state = Frozen_state
		end

feature -- Implementation

	state: INTEGER
			-- Is current exception block ready for new settings?

	start_state: INTEGER = 1
	catch_state: INTEGER = 2
	type_state: INTEGER = 3
	end_state: INTEGER = 4
	frozen_state: INTEGER = 5;
			-- Possible state of current object

note
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
