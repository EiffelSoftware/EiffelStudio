indexing
	description: "Forward class declaration."
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
				Result.append ("%R%N#define ")
				Result.append (class_protector)
				Result.append ("%R%N")
			end

			if namespace /= Void and then not namespace.is_empty then
				Result.append ("namespace ")
				Result.append (namespace)
				Result.append ("%R%N{%R%N")
			end

			Result.append ("class ")
			Result.append (name)
			Result.append (";%R%N")

			if namespace /= Void and then not namespace.is_empty then
				Result.append ("}%R%N")
			end

			if abstract then
				Result.append ("#endif%R%N")
			end
			Result.append ("%R%N")

		ensure
			non_void_generated_code: Result /= Void
			valid_generated_code: not Result.is_empty
		end

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty 
			
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
