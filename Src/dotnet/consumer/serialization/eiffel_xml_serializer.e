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

feature -- Basic Operations

	serialize (a: ANY; path: STRING) is
			-- Serialize object `a' into file `path'.
		require
			non_void_object: a /= Void
			non_void_path: path /= Void
		local
			f: STREAM_WRITER
			retried: BOOLEAN
			r: SYSTEM_RANDOM
		do
			create serialized_references.make_1 (25)
			last_error := No_error
			last_error_context := Void
			if not retried then
				create f.make_stream_writer_3 (path.to_cil)
				f.write_string (Xml_header)
				internal_serialize (Root_reference, a, 0, f)
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

	internal_serialize  (parent_field: STRING; obj: ANY; tab_count: INTEGER; f: TEXT_WRITER) is
			-- Serialize object field `parent_field' with value `obj' into file `f'.
			-- XML is written after `tab_count' tabs.
		require
			non_void_object: obj /= Void
			valid_tab_count: tab_count >= 0
			non_void_file: f /= Void
			non_void_parent_field: parent_field /= Void
		local
			int: INTEGER_REF
			bool: BOOLEAN_REF
			doub: DOUBLE_REF
			real: REAL_REF
			char: CHARACTER_REF
			pointer: POINTER_REF
			s: STRING
			ar: ARRAY [ANY]
		do
			if obj = Void then
				write (parent_field, "", open_none_field, close_none_field, tab_count, f)
			else
				int ?= obj
				if int /= Void then
					write (parent_field, int.item, open_integer_field, close_integer_field, tab_count, f)					
				else
					real ?= obj
					if real /= Void then
						write (parent_field, real.item, open_real_field, close_real_field, tab_count, f)						
					else
						doub ?= obj
						if doub /= Void then
							write (parent_field, doub.item, open_double_field, close_double_field, tab_count, f)							
						else
							char ?= obj
							if char /= Void then
								write (parent_field, char.item, open_character_field, close_character_field, tab_count, f)					
							else
								bool ?= obj
								if bool /= Void then
									write (parent_field, bool.item, open_boolean_field, close_boolean_field, tab_count, f)									
								else
									pointer ?= obj
									if pointer /= Void then
										write (parent_field, pointer.item, open_pointer_field, close_pointer_field, tab_count, f)										
									else
										s ?= obj
										if s /= Void then
											write (parent_field, escaped_string (s), open_string_field, close_string_field, tab_count, f)
										else
											ar ?= obj
											if ar /= Void then
												process_array (parent_field, ar, tab_count, f)
											else
												process_reference (parent_field, obj, tab_count, f)
											end
										end
									end
								end
							end
						end
					end
				end
			end	
		end
	
	process_array (name: STRING; ar: ARRAY [ANY]; tab_count: INTEGER; f: TEXT_WRITER) is
			-- 	Write array field `ar' named `name' in `f' tabulated with `tab_count' tabs.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
			non_void_reference: ar /= Void
			valid_tab_count: tab_count >= 0
			non_void_file: f /= Void
		local
			integer_array: ARRAY [INTEGER]
			real_array: ARRAY [REAL]
			double_array: ARRAY [DOUBLE]
			character_array: ARRAY [CHARACTER]
			pointer_array: ARRAY [POINTER]
			boolean_array: ARRAY [BOOLEAN]
			type_attribute: SYSTEM_STRING
			i: INTEGER
		do
			integer_array ?= ar
			if integer_array /= Void then
				type_attribute := Integer_node
			else
				real_array ?= ar
				if real_array /= Void then
					type_attribute := Real_node
				else
					double_array ?= ar
					if double_array /= Void then
						type_attribute := Double_node
					else
						character_array ?= ar
						if character_array /= Void then
							type_attribute := Character_node
						else
							boolean_array ?= ar
							if boolean_array /= Void then
								type_attribute := Boolean_node
							else
								pointer_array ?= ar
								if pointer_array /= Void then
									type_attribute := Pointer_node
								else
									from
										i := ar.lower
									until
										i > ar.upper or type_attribute /= Void
									loop
										if ar.item (i) /= Void then
											type_attribute := ar.item (i).generating_type.to_cil											
										end
										i := i + 1
									end
									if type_attribute = Void then
										type_attribute := None_node										
									end
								end
							end
						end
					end
				end
			end
			write_tabs (f, tab_count)
			f.write_string (Open_array_field)
			f.write_string (name.to_cil)
			f.write_string (Quote_space)
			f.write_string (Array_lower_bound_xml_attribute)
			f.write_string (Equal_quote)
			f.write_int32 (ar.lower)
			f.write_string (Quote_space)
			f.write_string (Array_count_xml_attribute)
			f.write_string (Equal_quote)
			f.write_int32 (ar.count)
			f.write_string (Quote_space)
			f.write_string (Type_xml_attribute)
			f.write_string (Equal_quote)
			f.write_string (type_attribute)
			f.write_string (End_element)
			f.write_string (New_line)
			from
				i := ar.lower
			until
				i > ar.count + ar.lower - 1
			loop
				if ar.item (i) /= Void then
					internal_serialize (i.out, ar.item (i), tab_count + 1, f)				
				end
				i := i + 1
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
		local
			i, nb, dtype: INTEGER
		do
			if serialized_references.contains (obj) then
				last_error := Cycle_error
				last_error_context := "Field " + obj.generating_type + " with value " + obj.out
			else
				serialized_references.add (obj, obj)
				dtype := dynamic_type (obj)
				write_tabs (f, tab_count)
				f.write_string (Open_reference_field)
				f.write_string (parent_field.to_cil)
				f.write_string (Quote_space)
				f.write_string (Type_xml_attribute)
				f.write_string (Equal_quote)
				f.write_string (obj.generating_type.to_cil)
				f.write_string (End_element)
				f.write_string (New_line)
				from
					i := 2
					nb := field_count_of_type (dtype)
				until
					i > nb
				loop
					internal_serialize (field_name_of_type (i, dtype), field_of_type (i, obj, dtype), tab_count + 1, f)						
					i := i + 1
				end
				write_tabs (f, tab_count)
				f.write_string (Close_reference_field)
				f.write_string (New_line)
			end
		end

	Xml_header: SYSTEM_STRING is
		once
			Result := ("<?xml version=%"1.0%"?>%N").to_cil	
		end
	
	serialized_references: HASHTABLE
			-- Serialized object references
	
	write (name: STRING; a: ANY; prefix_text, suffix: SYSTEM_STRING; tab_count: INTEGER; f: TEXT_WRITER) is
			-- Write `a' with name `name' in `f' in between `prefix' and `suffix' after `tab_count' tabs.
		require
			non_void_object: a /= void
			non_void_name: name /= void
			non_void_prefix_text: prefix_text /= void
			non_void_suffix_text: suffix /= void
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
			variant
				i
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
				if c < ' ' or c > '%/127/' then
					buffer.append_string ("&#")
					buffer.append_integer (c.code)
				else
					buffer.append_character (c)
				end
			end
		end

		
invariant
	error_message_if_failed: not successful implies last_error_context /= Void
	no_message_if_successful: successful implies last_error_context = Void

end -- class EIFFEL_XML_SERIALIZER
