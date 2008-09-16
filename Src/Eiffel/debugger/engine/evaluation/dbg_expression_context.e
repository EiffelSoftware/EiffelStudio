indexing
	description: "Abstraction of an expression's context"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXPRESSION_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (k: like kind)
			-- Create context as `k' kind
		require
			valid_kind: valid_kind (k)
		do
			set_kind (k)
		end

feature -- Status

	on_context: BOOLEAN
			-- Is the expression to be evaluated in the current call stack element context?
		do
			Result := kind = Kind_context
		end

	on_object: BOOLEAN
			-- Is the expression relative to an object?
		do
			Result := kind = Kind_object
		end

	on_class: BOOLEAN
			-- Is the expression relative to a class (the expression must be a once/constant).
		do
			Result := kind = Kind_class
		end

feature -- Access		

	associated_class: CLASS_C assign set_context_class
			-- Class the expression refers to (only valid if `on_class').

	associated_address: DBG_ADDRESS assign set_context_address
			-- Address of the object the expression refers to (only valid if `on_object').

	kind: INTEGER assign set_kind
		-- Kind of context
		--| cf: kind_* constant

feature -- Element change

	set_kind (i: INTEGER)
			-- Set `on_object' to `b'
		require
			valid_kind: valid_kind (i)
		do
			kind := i
		end

	set_context_address (add: like associated_address)
			-- Set `associated_address' to `add'
		require
			add_attached: add /= Void and then not add.is_void
			valid_context: on_object
		do
			associated_address := add
		end

	set_context_class (a_class: like associated_class)
			-- Set `associated_class' to `a_class'
		require
			a_class_attached: a_class /= Void
			valid_context: on_class or on_object
		do
			associated_class := a_class
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is context using valid data?
		do
			Result := is_coherent and then
						on_class implies (associated_class.is_valid and then associated_class.has_feature_table)
						--| If `Current' relies on an class, the class it relies on
						--| must be valid itself and correctly compiled.
		end

	is_coherent: BOOLEAN
			-- Is current context coherent?
		do
			Result := (on_object implies (associated_address /= Void and then not associated_address.is_void)) and
					(on_class implies associated_class /= Void)
		end

	valid_kind (i: INTEGER): BOOLEAN
			-- Is `i' a valid `kind' value ?
		do
			Result :=  (i = Kind_context)
					or (i = Kind_object)
					or (i = Kind_class)
		end

feature -- Constants

	kind_context: INTEGER = 1
			-- Expression will be evaluate in the Current object + current feature context.

	kind_object: INTEGER = 2
			-- Expression will be evaluate on target object

	kind_class: INTEGER = 3
			-- Expression will be evaluate on the context class (mainly for once, static routine)

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
