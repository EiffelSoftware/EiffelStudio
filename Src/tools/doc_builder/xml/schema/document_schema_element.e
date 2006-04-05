indexing
	description: "Schema element."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA_ELEMENT

create
	default_create,
	make_from_element,
	make_from_type
	
feature -- Initialization

	make_from_element (element: XML_XML_SCHEMA_ELEMENT; schema: DOCUMENT_SCHEMA) is
			-- Make from 'element'
		require
			element_not_void: element /= Void
			schema_not_void: schema /= Void
		do
			internal_element := element
			min_occurs := element.min_occurs
			max_occurs := element.max_occurs
			create name.make_from_cil (element.name)
			initialize (schema, element.schema_type)
		end
		
	make_from_type (a_type: XML_XML_SCHEMA_TYPE; schema: DOCUMENT_SCHEMA) is
			-- Make from 'type'
		require
			type_not_void: a_type /= Void
			schema_not_void: schema /= Void
		do
			is_schema_type := True
			if a_type.name /= Void then
				create name.make_from_cil (a_type.name)
			end
			initialize (schema, a_type)
		end
		
	initialize (schema: DOCUMENT_SCHEMA; a_type: XML_XML_SCHEMA_TYPE) is
			-- Initialization
		require
			schema_not_void: schema /= Void
		do
			schema_document := schema
			complex_type ?= a_type
			simple_type ?= a_type
			process_attributes
			process_children
			process_annotation
		end
		
feature -- Query
		
	is_schema_type: BOOLEAN
			-- Is Current a schema type?
		
	is_complex_particle: BOOLEAN is
			-- Is Current a particle type (sequence, choice, all groupref, element, any)
		do
			Result := complex_type.particle /= Void
		end
	
	is_group: BOOLEAN is
			-- Is Current a group type (all, sequence, choice)
		require
			is_complex_particle
		do
			Result := is_all or is_choice or is_sequence
		end
	
	is_all: BOOLEAN is
			-- An all particle?
		require
			is_complex_particle
		local
			l_all: XML_XML_SCHEMA_ALL 
		do
			l_all ?= particle
			Result := l_all /= Void
		end
		
	is_sequence: BOOLEAN is
			-- An sequence particle?
		require
			is_complex_particle
		local
			l_sequence: XML_XML_SCHEMA_SEQUENCE 
		do
			l_sequence ?= particle
			Result := l_sequence /= Void
		end
		
	is_choice: BOOLEAN is
			-- An choice particle?
		require
			is_complex_particle
		local
			l_choice: XML_XML_SCHEMA_CHOICE
		do
			l_choice ?= particle
			Result := l_choice /= Void
		end	
			
	is_type: BOOLEAN is
			-- Is Current a complex OR simple type?
		do
			Result := is_complex_type or is_simple_type
		end
			
	is_complex_type: BOOLEAN is
			-- Is current a complex type?
		do
			Result := complex_type /= Void
		end
		
	is_simple_type: BOOLEAN is
			-- Is current a simple type?
		do
			Result := simple_type /= Void
		end	
	
	has_complex_content_model: BOOLEAN is
			-- Does current, being a complex type, have a complex content model?
		require
			is_complex_type
		local
			model: XML_XML_SCHEMA_COMPLEX_CONTENT
		do
			model ?= complex_type.content_model
			Result := model /= Void
		end
		
	has_simple_content_model: BOOLEAN is
			-- Does current, being a complex type, have a simple content model?
		require
			is_simple_type
		local
			model: XML_XML_SCHEMA_SIMPLE_CONTENT
		do
			model ?= complex_type.content_model
			Result := model /= Void
		end
		
	derives_by_restriction: BOOLEAN is
			-- Does current derive by restriction?
		require
			is_complex_type
			has_complex_content_model
		local
			restriction_type: XML_XML_SCHEMA_COMPLEX_CONTENT_RESTRICTION
		do
			restriction_type ?= complex_content_model.content
			Result := restriction_type /= Void
		end
	
	derives_by_extension: BOOLEAN is
			-- Does current derive by extension?
		require
			is_complex_type
			has_complex_content_model
		local
			extension_type: XML_XML_SCHEMA_COMPLEX_CONTENT_EXTENSION
		do
			extension_type ?= complex_content_model.content
			Result := extension_type /= Void
		end
	
	group_base: XML_XML_SCHEMA_GROUP_BASE is
			-- The group base of current (all, sequence or choice)
		require
			is_group
		do
			Result ?= particle
		end		
	
	child_element_by_name (el_name: STRING): DOCUMENT_SCHEMA_ELEMENT is
			-- Get a schema element with name `el_name'.  It may be Current,
			-- a child of Current, or Void
		require
			el_name_not_void: el_name /= Void
			el_name_not_empty: not el_name.is_empty
		do
			if name.is_equal (el_name) then
				Result ?= Current
			else			
				from
				children.start
				until
					children.after or Result /= Void
				loop
					Result ?= children.item.child_element_by_name (el_name)
					children.forth
				end
			end		
		end	
	
feature -- Access

	name: STRING
			-- Element name
	
	min_occurs, max_occurs: DECIMAL
			-- Minimum and maximum element should appear in 
			-- schema
	
	annotation: STRING
			-- Annotation string of Current, if any
	
	type_name: STRING is
			-- Type name
		local
			l_type: XML_XML_SCHEMA_TYPE
		do
			if is_complex_type then
				if has_complex_content_model and derives_by_extension then
					create Result.make_from_cil (extension_content_model.base_type_name.name)
				elseif has_complex_content_model and derives_by_restriction then
					l_type ?= restriction_content_model.base_type_name
					if l_type /= Void then
						create Result.make_from_cil (l_type.name)
					end				
				else				
					l_type ?= complex_type.base_schema_type
					if l_type /= Void then
						create Result.make_from_cil (l_type.name)
					end	
				end
			elseif is_simple_type then
				l_type ?= simple_type.base_schema_type
				if l_type /= Void then
					create Result.make_from_cil (l_type.name)
				end	
			elseif internal_element.schema_type_name /= Void then
				create Result.make_from_cil (internal_element.schema_type_name.name)
			end
		end

	particle: XML_XML_SCHEMA_PARTICLE is
			-- Particle or Current
		require
			is_complex_type
			is_complex_particle
		do
			Result := complex_type.particle
		end

	type: XML_XML_SCHEMA_TYPE is
			-- Type
		do
			if complex_type /= Void then
				Result := complex_type
			elseif simple_type /= Void then
				Result := simple_type
			end
		end		

	complex_type: XML_XML_SCHEMA_COMPLEX_TYPE
			-- Complex Type of Current
	
	simple_type: XML_XML_SCHEMA_SIMPLE_TYPE
			-- Simple Type of Current
	
	complex_content_model: XML_XML_SCHEMA_COMPLEX_CONTENT is
			-- The complex content model of 'complex_type'
		require
			has_complex_content_model
		do
			Result ?= complex_type.content_model
		end
	
	simple_content_model: XML_XML_SCHEMA_SIMPLE_CONTENT is
			-- The simple content model of 'complex_type'
		require
			has_simple_content_model
		do
			Result ?= complex_type.content_model
		end
		
	restriction_content_model: XML_XML_SCHEMA_COMPLEX_CONTENT_RESTRICTION is
			-- The restricted content model of 'complex_type'
		require
			derives_by_restriction
		do
			Result ?= complex_content_model.content
		end
	
	extension_content_model: XML_XML_SCHEMA_COMPLEX_CONTENT_EXTENSION is
			-- The extended content model of 'complex_type'
		require
			derives_by_extension
		do
			Result ?= complex_content_model.content
		end		
	
feature -- Elements

	children: ARRAYED_LIST [like Current]
			-- Children elements
	
	type_children: ARRAYED_LIST [like Current] is
			-- Children elements of Current as type
		local
			l_name: STRING
			elem: DOCUMENT_SCHEMA_ELEMENT
		do
			create Result.make (5)
			l_name := type_name
			if not type_name.is_empty and then schema_document.has_type (type_name) then
				create elem.make_from_type (schema_document.get_type_by_name (type_name), schema_document)
				Result.append (elem.children.twin)
			end			
		end	
	
	attributes: ARRAYED_LIST [DOCUMENT_SCHEMA_ATTRIBUTE]
			-- Attributes
	
	xml: STRING is
			-- Xml of current element (includes required child
			-- elements)
		local
			start_tag_open, end_tag_open,
			start_tag_close, end_tag_close,
			start_tag_empty, end_tag_empty,
			inner_xml: STRING
			indent, cnt: INTEGER
		do
			indent := 0
			start_tag_open := "<"
			end_tag_open := ">"
			start_tag_close := "</"
			end_tag_close := end_tag_open
			start_tag_empty := start_tag_open
			end_tag_empty := "/>"
			if children /= Void then
				from
					create inner_xml.make_empty
					children.start
				until
					children.after
				loop
					if feature {DECIMAL}.to_int_32 (children.item.min_occurs) > 0 then
						from
							cnt := 0
						until
							cnt = indent
						loop
							inner_xml.append ("%T")
							cnt := cnt + 1
						end						
						inner_xml.append (children.item.xml)
					end
					children.forth
				end
				create Result.make_from_string (start_tag_open + name + attribute_xml + end_tag_open + 
					inner_xml + 
					start_tag_close + name + end_tag_close)
			else
				create Result.make_from_string (start_tag_empty + name + end_tag_empty)
			end	
		end		
	
	attribute_xml: STRING is
			-- Xml for attribute values
		do
			create Result.make_empty
			from 
				attributes.start
			until
				attributes.after
			loop
				if attributes.item.required then
					Result.append (" " + attributes.item.name + "=%"")
					if 
						attributes.item.default_value /= Void and then 
						not attributes.item.default_value.is_empty 
					then
						Result.append (attributes.item.default_value)						
					end
					Result.append ("%"")
				end
				attributes.forth
			end
		end		
	
feature {DOCUMENT_SCHEMA} -- Implementation

	internal_element: XML_XML_SCHEMA_ELEMENT

	schema_document: DOCUMENT_SCHEMA

	parent_type_names: ARRAYED_LIST [STRING] is
			-- List of parent types names used for traversal
		once
			create Result.make (5)
			Result.compare_objects
		end

feature -- Status Setting

	add_attributes (atts: ARRAYED_LIST [DOCUMENT_SCHEMA_ATTRIBUTE]) is
			-- Append `atts' to `attributes'
		do
			attributes.append (atts)
		end	

feature -- Processing

	process_attributes is
			-- Process attributes of current
		do
			create attributes.make (5)
			if is_complex_type then
				extract_attributes (complex_type.attributes)
				if has_complex_content_model then
					if derives_by_extension then
						extract_attributes (extension_content_model.attributes)
					elseif derives_by_restriction then
						extract_attributes (restriction_content_model.attributes)				
					end
				end
			end
		end

feature {NONE} -- Processing

	process_annotation is
			-- Extract annotation from Current for help purposes
		do
			if internal_element /= Void then
				if internal_element.annotation /= Void then
					extract_annotation (internal_element.annotation.items)
				end				
			elseif is_type then
				if type.annotation /= Void then
					extract_annotation (type.annotation.items)
				end
			end
			if annotation = Void then
				create annotation.make_from_string ("No details.")
			end
		end		

	process_children is
			-- Process all children of Current
		do
			create children.make (5)
			if is_type then
				if is_complex_type then
					process_as_complex_type
				end
			elseif internal_element.schema_type_name.name.length > 0 then
				process_as_schema_type
			end	
		end		

	process_as_complex_type is
			-- Process children from Current as complex type
		do
			if is_complex_particle then
				process_as_complex_particle	
			elseif has_complex_content_model then
				process_as_complex_content_model
			end	
		end
		
	process_as_complex_particle is
			-- Process children from Current as complex type with particle (all, sequence, choice)
		local
			cnt: INTEGER
			elem: DOCUMENT_SCHEMA_ELEMENT
			dotnet_elem: XML_XML_SCHEMA_ELEMENT
		do
			if is_group then	
				from
					cnt := 0
				until
					cnt = group_base.items.count
				loop
					dotnet_elem ?= group_base.items.item (cnt)
					if dotnet_elem /= Void then
						create elem.make_from_element (dotnet_elem, schema_document)
						children.extend (elem)
					end
					cnt := cnt + 1
				end
			end		
		end
		
	process_as_complex_content_model is
			-- Process current as complex type with complex content model
		local
			elem: DOCUMENT_SCHEMA_ELEMENT
		do
			if not parent_type_names.has (type_name) then
				parent_type_names.extend (type_name)
				create elem.make_from_type (schema_document.get_type_by_name (type_name), schema_document)
				add_attributes (elem.attributes)
				parent_type_names.prune (type_name)
				children.append (elem.children)
			end
		end
		
	process_as_schema_type is
			-- Process Current as a schema type (string, anyURI, user defined types)
		local
			elem: DOCUMENT_SCHEMA_ELEMENT
			schema_type_name: STRING
		do
			create schema_type_name.make_from_string (internal_element.schema_type_name.name)
			if schema_document.has_type (schema_type_name) then
				if not parent_type_names.has (schema_type_name) then
					parent_type_names.extend (schema_type_name)
					create elem.make_from_type (schema_document.get_type_by_name (schema_type_name), schema_document)
					add_attributes (elem.attributes)
					children.append (elem.children)
					parent_type_names.prune (schema_type_name)
				end
			end
		end	

	extract_attributes (attribute_collection: XML_XML_SCHEMA_OBJECT_COLLECTION) is
			-- Extract attributes from 'attribute_collection' and put in 'attributes'
		local
			dotnet_att: XML_XML_SCHEMA_ATTRIBUTE
			att: DOCUMENT_SCHEMA_ATTRIBUTE
			enum: XML_XML_SCHEMA_OBJECT_ENUMERATOR
		do
			from
				enum := attribute_collection.get_enumerator_2
			until
				not enum.move_next
			loop
				dotnet_att ?= enum.current_
				if dotnet_att /= Void then
					create att.make (create {STRING}.make_from_cil (dotnet_att.name), Current)
					att.set_use (dotnet_att.use)
					att.set_default_value (dotnet_att.default_value)
					attributes.extend (att)
				end
			end
		end
	
	extract_annotation (annotation_collection: XML_XML_SCHEMA_OBJECT_COLLECTION) is
			-- Extract attributes from 'attribute_collection' and put in 'attributes'
		local
			dotnet_ann: XML_XML_SCHEMA_DOCUMENTATION
			node: XML_XML_NODE
			enum: XML_XML_SCHEMA_OBJECT_ENUMERATOR
			l_nat: NATIVE_ARRAY [XML_XML_NODE]
		do
			from
				enum := annotation_collection.get_enumerator_2
			until
				not enum.move_next
			loop
				dotnet_ann ?= enum.current_
				if dotnet_ann /= Void then
					l_nat := dotnet_ann.markup
					node ?= l_nat.item (0)
					if node /= Void then
						annotation ?= create {STRING}.make_from_cil (node.value)
					end
				end
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
end -- class DOCUMENT_SCHEMA_ELEMENT
