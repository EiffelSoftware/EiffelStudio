indexing
	description: "Forward class declaration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_FORWARD_CLASS_DECLARATION

inherit
	WIZARD_WRITER_DICTIONARY

create
	make

feature -- Initialization

	make (a_name, a_namespace: STRING; is_abstract: BOOLEAN) is
			-- Initialization.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			name := a_name
			namespace := a_namespace
			abstract := is_abstract
		ensure
			non_void_name: name /= Void
			valid_name: not name.is_empty and then name.is_equal (a_name)
		end

feature -- Access

	name: STRING
			-- Class name.
	
	namespace: STRING
			-- Class namespace.
	
	abstract: BOOLEAN
	
feature -- Basic operations

	generated_code: STRING is
			-- Generated code
		local
			class_protector: STRING
		do
			Create Result.make (1000)
			if abstract then
				create class_protector.make (50)
				class_protector.append ("__")
				if namespace /= Void and then not namespace.is_empty then
					class_protector.append (namespace)
					class_protector.append ("_")
				end
				class_protector.append (name)
				class_protector.append ("_FWD_DEFINED__")

				Result.append ("#ifndef ")
				Result.append (class_protector)
				Result.append ("%N#define ")
				Result.append (class_protector)
				Result.append ("%N")
			end

			if namespace /= Void and then not namespace.is_empty then
				Result.append ("namespace ")
				Result.append (namespace)
				Result.append ("%N{%N")
			end

			Result.append ("class ")
			Result.append (name)
			Result.append (";%N")

			if namespace /= Void and then not namespace.is_empty then
				Result.append ("}%N")
			end

			if abstract then
				Result.append ("#endif%N")
			end
			Result.append ("%N")

		ensure
			non_void_generated_code: Result /= Void
			valid_generated_code: not Result.is_empty
		end

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty 
			
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
end -- class WIZARD_WRITER_FORWARD_CLASS_DECLARATION

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
