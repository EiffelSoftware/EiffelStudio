indexing
	description: "[
					Simple XML serializer for Eiffel for .NET objects.
					Does not process reference cycles.
					Does not serialize expanded references.
					Does not serialize attributes of type INTEGER_64,
					INTEGER_16, INTEGER_8 and BIT.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_SERIALIZER

inherit
	EIFFEL_XML_SERIALIZATION_ERRORS
	
	EXCEPTIONS
		rename
			class_name as exceptions_class_name
		export
			{NONE} all
		end

	EIFFEL_XML_SERIALIZATION_ROUTINES
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

	TYPE_NAME_ID

feature -- Basic Operations

	serialize (a: ANY; path: STRING) is
			-- Serialize object `a' into file `path'.
		require
			non_void_object: a /= Void
			non_void_path: path /= Void
		local
			f: STREAM_WRITER
			retried: BOOLEAN
			l_so: SYSTEM_OBJECT
		do
			last_error := No_error
			last_error_context := Void
			if not retried then
				l_so := Current
				create f.make_from_path (path.to_cil)
				f.write_string (xml_header)
				f.write_string (open_xmls_field)
				f.write_string (xmls_ver)
				f.write_string (end_element)
				f.write_string (new_line)
				if a = Void then
					write (root_reference, "", open_none_field, close_none_field, 1, f)
				else
					process_reference (root_reference, a, 1, f)
				end
				f.write_string (close_xmls_field)
				f.close
			end
		rescue
			retried := True
			last_error := Generic_error
			last_error_context := ""
			if f /= Void then
				f.close		
			end
			retry
		end

feature {NONE} -- Implementation

	internal_serialize  (obj: ANY; tab_count: INTEGER; f: TEXT_WRITER) is
			-- Serialize object field `parent_field' with value `obj' into file `f'.
			-- XML is written after `tab_count' tabs.
		require
			obj_not_void: obj /= Void
			valid_tab_count: tab_count >= 0
			non_void_file: f /= Void
		local
			s: STRING
			ar: ARRAY [ANY]
			int_ar: ARRAY [INTEGER]
			char_ar: ARRAY [CHARACTER]
			bool_ar: ARRAY [BOOLEAN]
			i, nb, dtype: INTEGER
			l_name: STRING
			l_field_obj: ANY
		do
			dtype := dynamic_type (obj)
			from
				i := 1
				nb := field_count_of_type (dtype)
			until
				i > nb
			loop
				l_name := field_name_of_type (i, dtype)
				l_field_obj := field (i, obj)
				if l_field_obj /= Void then
					inspect
						field_type_of_type (i, dtype)
					when integer_32_type then
						write (l_name, l_field_obj, open_integer_field,
							close_integer_field, tab_count, f)
					when character_type then
						write (l_name, l_field_obj, open_character_field,
							close_character_field, tab_count, f)
					when boolean_type then
						write (l_name, l_field_obj, open_boolean_field, close_boolean_field,
							tab_count, f)
					when reference_type then
						if generic_count_of_type (dynamic_type (l_field_obj)) = 1 then
								-- Most likely an array.
							ar ?= l_field_obj
							if ar /= Void then
								process_array (l_name, ar, tab_count, f)
							else
								int_ar ?= l_field_obj
								if int_ar /= Void then
									process_array (l_name, int_ar, tab_count, f)
								else
									char_ar ?= l_field_obj
									if char_ar /= Void then
										process_array (l_name, char_ar, tab_count, f)
									else
										bool_ar ?= l_field_obj
										if bool_ar /= Void then
											process_array (l_name, bool_ar, tab_count, f)
										else
											check False end
										end
									end
								end
							end
						else
							s ?= l_field_obj
							if s /= Void then
								write (l_name, escaped_string (s), open_string_field,
									close_string_field, tab_count, f)
							else
								process_reference (l_name, l_field_obj, tab_count, f)
							end
						end
					end
				end
				i := i + 1
			end
		end

	process_array (name: STRING; obj: ANY; tab_count: INTEGER; f: TEXT_WRITER) is
			-- 	Write array field `ar' named `name' in `f' tabulated with `tab_count' tabs.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
			non_void_reference: obj /= Void
			valid_tab_count: tab_count >= 0
			non_void_file: f /= Void
		local
			integer_array: ARRAY [INTEGER]
			character_array: ARRAY [CHARACTER]
			boolean_array: ARRAY [BOOLEAN]
			ar: ARRAY [ANY]
			i, count: INTEGER
			l_name: STRING
			elem: ANY
		do
			write_tabs (f, tab_count)
			f.write_string (Open_array_field)
			f.write_string (name.to_cil)
			f.write_string (Quote_space)
			f.write_string (Array_lower_bound_xml_attribute)
			f.write_string (Equal_quote)
			ar ?= obj
			if ar /= Void then
				l_name := type_name_of_type (generic_dynamic_type (ar, 1))
				count := ar.count
				f.write (ar.lower)
				f.write_string (Quote_space)
				f.write_string (Array_count_xml_attribute)
				f.write_string (Equal_quote)
				f.write (count)
				f.write_string (Quote_space)
				f.write_string (Compare_objects_xml_attribute)
				f.write_string (Equal_quote)
				f.write_boolean (ar.object_comparison)
				f.write_string (Quote_space)
				f.write_string (Type_xml_attribute)
				f.write_string (Equal_quote)
				f.write (id_from_type (l_name))
				f.write_string (End_element)
				f.write_string (New_line)
				from
					i := 1
				until
					i > count
				loop
					elem := ar.item (i)
					if elem /= Void then
						l_name ?= elem
						if l_name /= Void then
							write (i.out, escaped_string (l_name),
								open_string_field, close_string_field,
								tab_count + 1, f)
						else
							process_reference (i.out, elem, tab_count + 1, f)
						end
					end
					i := i + 1
				end
			else
				integer_array ?= obj
				if integer_array /= Void then
					count := integer_array.count
					f.write (integer_array.lower)
					f.write_string (Quote_space)
					f.write_string (Array_count_xml_attribute)
					f.write_string (Equal_quote)
					f.write (count)
					f.write_string (Quote_space)
					f.write_string (Compare_objects_xml_attribute)
					f.write_string (Equal_quote)
					f.write_boolean (integer_array.object_comparison)
					f.write_string (Quote_space)
					f.write_string (Type_xml_attribute)
					f.write_string (Equal_quote)
					f.write_string (Integer_node)
					f.write_string (End_element)
					f.write_string (New_line)
					from
						i := 1
					until
						i > count
					loop
						write (i.out, integer_array.item (i), open_integer_field, close_integer_field, tab_count + 1, f)
						i := i + 1
					end
				else
					character_array ?= obj
					if character_array /= Void then
						count := character_array.count
						f.write (character_array.lower)
						f.write_string (Quote_space)
						f.write_string (Array_count_xml_attribute)
						f.write_string (Equal_quote)
						f.write (count)
						f.write_string (Quote_space)
						f.write_string (Compare_objects_xml_attribute)
						f.write_string (Equal_quote)
						f.write_boolean (character_array.object_comparison)
						f.write_string (Quote_space)
						f.write_string (Type_xml_attribute)
						f.write_string (Equal_quote)
						f.write_string (Character_node)
						f.write_string (End_element)
						f.write_string (New_line)
						from
							i := 1
						until
							i > count
						loop
							write (i.out, character_array.item (i), open_character_field, close_character_field, tab_count + 1, f)
							i := i + 1
						end
					else
						boolean_array ?= obj
						if boolean_array /= Void then
							count := boolean_array.count
							f.write (boolean_array.lower)
							f.write_string (Quote_space)
							f.write_string (Array_count_xml_attribute)
							f.write_string (Equal_quote)
							f.write (count)
							f.write_string (Quote_space)
							f.write_string (Compare_objects_xml_attribute)
							f.write_string (Equal_quote)
							f.write_boolean (boolean_array.object_comparison)
							f.write_string (Quote_space)
							f.write_string (Type_xml_attribute)
							f.write_string (Equal_quote)
							f.write_string (Boolean_node)
							f.write_string (End_element)
							f.write_string (New_line)
							from
								i := 1
							until
								i > count
							loop
								write (i.out,  boolean_array.item (i), open_boolean_field, close_boolean_field, tab_count + 1, f)
								i := i + 1
							end
						end
					end
				end
			end
			write_tabs (f, tab_count)
			f.write_string (Close_array_field)
			f.write_string (New_line)			
		end

	process_reference (parent_field: STRING; obj: ANY; tab_count: INTEGER; f: TEXT_WRITER) is
			-- 	Write reference field `a' named `name' in `f' tabulated with `tab_count' tabs.
		require
			non_void_name: parent_field /= Void
			valid_name: not parent_field.is_empty
			non_void_reference: obj /= Void
			valid_tab_count: tab_count >= 0
			non_void_file: f /= Void
		do
			write_tabs (f, tab_count)
			f.write_string (Open_reference_field)
			f.write_string (parent_field.to_cil)
			f.write_string (Quote_space)
			f.write_string (Type_xml_attribute)
			f.write_string (Equal_quote)
			f.write (id_from_type (obj.generating_type))
			f.write_string (End_element)
			f.write_string (New_line)
			if obj = Void then
				write (parent_field, "", open_none_field, close_none_field, tab_count + 1, f)
			else
				internal_serialize (obj, tab_count + 1, f)
			end
			write_tabs (f, tab_count)
			f.write_string (Close_reference_field)
			f.write_string (New_line)
		end

	Xml_header: SYSTEM_STRING is
			-- Header for XML file generated by Current.
		once
			Result := ("<?xml version=%"1.0%"?>%N").to_cil	
		end
	
	write (name: STRING; a: ANY; prefix_text, suffix: SYSTEM_STRING; tab_count: INTEGER; f: TEXT_WRITER) is
			-- Write `a' with name `name' in `f' in between `prefix' and `suffix' after `tab_count' tabs.
		require
			non_void_object: a /= Void
			non_void_name: name /= Void
			non_void_prefix_text: prefix_text /= Void
			non_void_suffix_text: suffix /= Void
			valid_tab_count: tab_count >= 0
			non_void_file: f /= Void
		do
			write_tabs (f, tab_count)
			f.write_string (prefix_text)
			f.write_string (name.to_cil)
			f.write_string (end_element)
			f.write_string (a.out.to_cil)
			f.write_string (suffix)
			f.write_string (new_line)
		end

	escaped_string (s: STRING): STRING is
			-- Escaped `s' for XML writting
		require
			non_void_string: s /= Void
		local
			i, nb: INTEGER
		do
			create Result.make (s.count + s.count // 10)
			from
				i := 1
				nb := s.count
			until
				i > nb
			loop
				escape_char (Result, s.item (i))
				i := i + 1
			end
		end

	escape_char (buffer: STRING; c: CHARACTER) is
			-- Write char `c' with XML escape sequences
		require
			valid_buffer: buffer /= Void
		do
			inspect
				c
		 	when '&' then
				buffer.append_string ("&amp;")
		 	when '<' then
				buffer.append_string ("&lt;")
		 	when '>' then
				buffer.append_string ("&gt;")
			when '"' then
				buffer.append_string ("&quot;")
			when ''' then
				buffer.append_string ("&apos;")
			else
				if c <= ' ' or c > '%/127/' then
					buffer.append_string ("&#")
					buffer.append_integer (c.code)
					buffer.append_character (';')
				else
					buffer.append_character (c)
				end
			end
		end
		
invariant
	error_message_if_failed: not successful implies last_error_context /= Void
	no_message_if_successful: successful implies last_error_context = Void

end -- class EIFFEL_XML_SERIALIZER
