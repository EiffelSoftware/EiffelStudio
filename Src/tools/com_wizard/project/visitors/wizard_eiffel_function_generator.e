indexing
	description: "Eiffel function generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_FUNCTION_GENERATOR

inherit
	WIZARD_FUNCTION_GENERATOR

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_EIFFEL_ASSERTION_GENERATOR
		export
			{NONE} all
		end

feature -- Access

	feature_writer: WIZARD_WRITER_FEATURE
			-- Feature writer

	function_renamed: BOOLEAN
			-- Function is renamed?

	original_name: STRING
			-- Original name

	changed_name: STRING
			-- Changed name

feature {NONE} -- Implementation

	set_feature_result_type_and_arguments is
			-- Set l_arguments
		require
			non_void_feature_writer: feature_writer /= Void
			non_void_func_desc: func_desc /= Void
			non_void_arguments: func_desc.arguments /= Void
		local
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			an_argument: STRING
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_arguments := func_desc.arguments
			from
				l_arguments.start
			until
				l_arguments.after
			loop
				visitor := l_arguments.item.type.visitor 
				if is_paramflag_fretval (l_arguments.item.flags) then
					l_descriptor ?= l_arguments.item.type

					if l_descriptor /= Void then
						visitor := l_descriptor.pointed_data_type_descriptor.visitor 
						add_enumeration_comments ("Result", l_descriptor.pointed_data_type_descriptor, visitor)
					else
						visitor := l_arguments.item.type.visitor 
						add_enumeration_comments ("Result", l_arguments.item.type, visitor)
					end
					feature_writer.set_result_type (visitor.eiffel_type)
					
				else
					create an_argument.make (100)
					an_argument.append (l_arguments.item.name)
					an_argument.append (": ")
					an_argument.append (visitor.eiffel_type)
					feature_writer.add_argument (an_argument)
				end
				visitor := Void
				l_arguments.forth
			end
			visitor := func_desc.return_type.visitor

			-- Eiffel will not have result type if the result type is "void" or "HRESULT"
			if not is_hresult (visitor.vt_type) and not is_error (visitor.vt_type) and not is_void (visitor.vt_type) then
				feature_writer.set_result_type (visitor.eiffel_type)
				add_enumeration_comments ("Result", func_desc.return_type, visitor)
			end

		end

	enumeration_comment (a_name: STRING; l_type: WIZARD_DATA_TYPE_DESCRIPTOR; a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Add coments for enumeration types.
		local
			a_user_defined_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			a_index: INTEGER
			a_type_descriptor: WIZARD_TYPE_DESCRIPTOR
		do
			if a_visitor.is_enumeration then
				a_user_defined_descriptor ?= l_type
				if a_user_defined_descriptor /= Void then
					a_index := a_user_defined_descriptor.type_descriptor_index
					a_type_descriptor := a_user_defined_descriptor.library_descriptor.descriptors.item (a_index)
					create Result.make (100)
					Result.append ("See ")
					Result.append (a_type_descriptor.eiffel_class_name)
					Result.append (" for possible `")
					Result.append (a_name)
					Result.append ("' values.")
				end
			else
				create Result.make (0)
			end
		end

	add_enumeration_comments (a_name: STRING; l_type: WIZARD_DATA_TYPE_DESCRIPTOR;
				a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Add coments for enumeration types.
		local
			l_comment: STRING
		do
			if feature_writer.comment = Void then
				create l_comment.make (100)
			else
				l_comment := feature_writer.comment.twin
			end
			if not l_comment.is_empty and a_visitor.is_enumeration then
				l_comment.append ("%N%T%T%T-- ")
			end
			l_comment.append (enumeration_comment (a_name, l_type, 	a_visitor))
			if not l_comment.is_empty then
				feature_writer.set_comment (l_comment)
			end
		end

	add_feature_argument_comments is
			-- Add comments
		local
			l_comment: STRING
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
		do
			if (feature_writer.comment = Void) then
				create l_comment.make (100)
			else
				l_comment := feature_writer.comment.twin
			end
			l_arguments := func_desc.arguments
			from
				l_arguments.start
			until 
				l_arguments.after
			loop
				if not is_paramflag_fretval (l_arguments.item.flags) then
					if not l_comment.is_empty then 
						l_comment.append ("%N%T%T%T-- ")
					end
					l_comment.append ("`")
					l_comment.append (l_arguments.item.name)
					l_comment.append ("' [")
					if is_paramflag_fin (l_arguments.item.flags) then
						if is_paramflag_fout (l_arguments.item.flags) then
							l_comment.append ("in, out")
						else
							l_comment.append ("in")
						end
					else
						l_comment.append ("out")
					end
					l_comment.append ("]. ")
					l_comment.append (enumeration_comment (l_arguments.item.name, l_arguments.item.type, l_arguments.item.type.visitor))
					l_comment.append (" ")
					l_comment.append (l_arguments.item.description)
				end
				l_arguments.forth
			end
			if not l_comment.is_empty then
				feature_writer.set_comment (l_comment)
			end
		end

	set_feature_assertions is
			-- Set precondition.
		local
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			l_type: WIZARD_DATA_TYPE_DESCRIPTOR
		do
			l_arguments := func_desc.arguments
			from
				l_arguments.start
			until 
				l_arguments.after
			loop

				if not is_paramflag_fretval (l_arguments.item.flags) then
					generate_precondition (l_arguments.item.name, l_arguments.item.type, 
						is_paramflag_fin (l_arguments.item.flags),
						is_paramflag_fout (l_arguments.item.flags))
					if not assertions.is_empty then
						from 
							assertions.start
						until
							assertions.off
						loop
							feature_writer.add_precondition (assertions.item)
							assertions.forth
						end
					end
				end
				if is_paramflag_fout (l_arguments.item.flags) then
					if is_paramflag_fretval  (l_arguments.item.flags) then
						l_descriptor ?= l_arguments.item.type
						if l_descriptor /= Void then
							l_type := l_descriptor.pointed_data_type_descriptor
						else
							l_type := l_arguments.item.type
						end
						generate_postcondition (feature_writer.name, l_type, is_paramflag_fretval  (l_arguments.item.flags))
					else
						generate_postcondition (l_arguments.item.name, l_arguments.item.type, 
							is_paramflag_fretval  (l_arguments.item.flags))
					end
					if not assertions.is_empty then
						from 
							assertions.start
						until
							assertions.after
						loop
							feature_writer.add_postcondition (assertions.item)
							assertions.forth
						end
					end
				end
				l_arguments.forth
			end
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
end -- class WIZARD_EIFFEL_FUNCTION_GENERATOR

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

