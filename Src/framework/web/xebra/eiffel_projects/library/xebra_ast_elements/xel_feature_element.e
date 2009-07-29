note
	description: "[
		Used to render a feature with its local variables
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_FEATURE_ELEMENT

inherit
	XEL_SERVLET_ELEMENT

create
	make,
	make_with_locals

feature -- Initialization

	make (a_signature: STRING)
			-- `a_signature': The signature of the feature
		do
			make_with_expressions (a_signature, create {ARRAYED_LIST [XEL_EXPRESSION]}.make (5))
		end

	make_with_expressions (a_signature: STRING; a_content: LIST [XEL_EXPRESSION])
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
		require
			signature_valid: not a_signature.is_empty
		do
			make_with_locals (a_signature, a_content, create {HASH_TABLE [XEL_VARIABLE_ELEMENT, STRING]}.make (1))
		end

	make_with_locals (a_signature: STRING; a_content: LIST [XEL_EXPRESSION]; some_locals: HASH_TABLE [XEL_VARIABLE_ELEMENT, STRING])
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
			-- `some_locals': The local variables of the feature
		require
			signature_valid: not a_signature.is_empty
		do
			signature := a_signature
			locals := some_locals
			content := a_content
			create {ARRAYED_LIST [XEL_SERVLET_ELEMENT]} precontent.make (2)
			create {ARRAYED_LIST [XEL_SERVLET_ELEMENT]} postcontent.make (2)
			create {ARRAYED_LIST [XEL_SERVLET_ELEMENT]} requires.make (2)
			create {ARRAYED_LIST [XEL_SERVLET_ELEMENT]} ensures.make (2)
			feature_comment := "<Precursor>"
			variable_count := 0
			is_once := False
		end

feature {NONE} -- Access

	variable_count: NATURAL
			-- Used to generate unique identifiers

	is_once: BOOLEAN
			-- Is it a once feature?

feature -- Access

	parent_class: XEL_CLASS_ELEMENT assign set_parent_class
			-- The class in which this feature is contained

	set_parent_class (a_parent_class: XEL_CLASS_ELEMENT)
			-- Sets the parent_class.
		do
			parent_class := a_parent_class
		end

	set_feature_comment (a_feature_comment: STRING)
			-- Sets the feature comment.
		require
			a_feature_comment_valid: attached a_feature_comment and not a_feature_comment.is_empty
		do
			feature_comment := a_feature_comment
		ensure
			feature_comment_set: a_feature_comment = feature_comment
		end

	signature: STRING
			-- Signature of the feature

	feature_comment: STRING
			-- The commment for the feature

	locals: HASH_TABLE [XEL_VARIABLE_ELEMENT, STRING]
			-- The local variables of the feature

	content: LIST [XEL_EXPRESSION]
			-- The body expressions of the feature

	precontent: LIST [XEL_SERVLET_ELEMENT]
			-- The prebody expressions of the feature

	postcontent: LIST [XEL_SERVLET_ELEMENT]
			-- The postbody expressions of the feature

	ensures: LIST [XEL_SERVLET_ELEMENT]
			-- The ensure statements

	requires: LIST [XEL_SERVLET_ELEMENT]
			-- The require statements

	append_local (name, type: STRING)
			-- Appends a {XEL_PLAIN_CODE_ELEMENT} to the feature
			-- The name of the local has to be unique
		require
			name_is_valid: not name.is_empty
			name_is_not_already_used: not locals.has (name)
			type_is_valid: not type.is_empty
		do
			locals.put (create {XEL_VARIABLE_ELEMENT}.make (name, type), name)
		ensure
			local_has_been_added: old locals.count < locals.count
		end

	append_expression (expression: STRING)
			-- Appends a {XEL_PLAIN_CODE_ELEMENT} to the feature
		require
			expression_is_valid: not expression.is_empty
		do
			append_expression_object (create {XEL_PLAIN_EXPRESSION}.make (expression))
		ensure
			expression_has_been_added: old content.count < content.count
		end

	append_expression_to_start (expression: STRING)
			-- Appends a {XEL_PLAIN_CODE_ELEMENT} to the start of the feature
	 	require
	 		expression_is_valid: attached expression and not expression.is_empty
	 	do
	 		precontent.extend (create {XEL_PLAIN_CODE_ELEMENT}.make (expression))
		ensure
			expression_has_been_added: old precontent.count < precontent.count
	 	end

	append_expression_object (a_expression: XEL_EXPRESSION)
			-- Adds an expressionobject to the content
		require
			a_expression_attached: attached a_expression
		do
			content.extend (a_expression)
		ensure
			expression_has_been_added: old content.count < content.count
		end

	append_expression_to_end (expression: STRING)
			-- Appends a {XEL_PLAIN_CODE_ELEMENT} to the end of the feature
	 	require
	 		expression_is_valid: attached expression and not expression.is_empty
	 	do
	 		postcontent.extend (create {XEL_PLAIN_CODE_ELEMENT}.make (expression))
		ensure
			expression_has_been_added: old postcontent.count < postcontent.count
	 	end

	append_comment (a_comment: STRING)
		do
			content.extend (create {XEL_COMMENT}.make (a_comment))
				-- Don't use append_expression_oject, otherwise you will get an endless recursion!
		end

	append_require (expression: STRING)
			-- Appends a require-expression to the feature
	 	require
	 		expression_is_valid: attached expression and not expression.is_empty
	 	do
	 		requires.extend (create {XEL_PLAIN_CODE_ELEMENT}.make (expression))
		ensure
			expression_has_been_added: old requires.count < requires.count
	 	end

	 append_ensure (expression: STRING)
			-- Appends a require-expression to the feature
	 	require
	 		expression_is_valid: attached expression and not expression.is_empty
	 	do
	 		ensures.extend (create {XEL_PLAIN_CODE_ELEMENT}.make (expression))
		ensure
			expression_has_been_added: old ensures.count < ensures.count
	 	end

	new_uid: STRING
			-- Generates a name for a unique (feature scope) temp variable
		do
			Result := "l_temp_" + variable_count.out
			variable_count := variable_count + 1
		end

	new_local (type: STRING): STRING
			-- Generates a new local variable and returns its unique identifier
		do
			Result := new_uid
			append_local (Result, type)
		end

	set_once
			-- Set the feature to a once feature
		do
			is_once := True
		end

feature -- Implementation

	serialize (buf:XU_INDENDATION_FORMATTER)
			-- <Precursor>			
		do
			buf.put_string (signature)
			buf.indent
			buf.indent
			buf.put_string ("--" + feature_comment)
			buf.unindent
			if not requires.is_empty then
				buf.put_string ("require")
				buf.indent
				from
					requires.start
				until
					requires.after
				loop
					requires.item_for_iteration.serialize (buf)
					requires.forth
				end
				buf.unindent
			end
			if not locals.is_empty then
				buf.put_string ("local")
				buf.indent
				from
					locals.start
				until
					locals.after
				loop
					locals.item_for_iteration.serialize (buf)
					locals.forth
				end
				buf.unindent
			end
			if is_once then
				buf.put_string ("once")
			else
				buf.put_string ("do")
			end
			buf.indent
			from
				precontent.start
			until
				precontent.after
			loop
				precontent.item.serialize (buf)
				precontent.forth
			end
			from
				content.start
			until
				content.after
			loop
				content.item.serialize (buf)
				content.forth
			end
			from
				postcontent.start
			until
				postcontent.after
			loop
				postcontent.item.serialize (buf)
				postcontent.forth
			end
			buf.unindent
			if not ensures.is_empty then
				buf.put_string ("require")
				buf.indent
				from
					ensures.start
				until
					ensures.after
				loop
					ensures.item_for_iteration.serialize (buf)
					ensures.forth
				end
				buf.unindent
			end
			buf.put_string ("end")
			buf.unindent
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
