indexing
	description: "name and other conversion routines for jvm code generation"
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_NAME_CONVERTER

inherit
	SHARED_JVM_CLASS_REPOSITORY
	JVM_CONSTANTS
			
feature {NONE} -- Initialization
feature {NONE}
			
	rename_type (a: STRING): STRING is
			-- Rename type names as they come from Eiffel into jvm type names
			-- Note: does not embed object types into L;, shorten
			-- basic types to one letter abbrevs or shorten array names
		do
			Result := clone (a)
			hack_rename (Result)
						--	 Result.replace_substring_all (".", "/")
			Result := java_to_jvm_name (Result)
		end
			
	hack_rename (a: STRING) is
			-- dirty hack to rename occurrences of "System.Object" to "java/lang/Object"
			-- This is needed because of "System.Object" is hardcoded in
			-- the compiler (this will be removed at some point and then
			-- this hack can go away as well)
		do
			a.replace_substring_all ("System.Object", "java/lang/Object")
		end
			
	eiffel_external_parameters_to_jvm_parameters (params: ARRAY [STRING]): ARRAY [STRING] is
			-- converts the parameter type names as specified in the 
			-- eiffel external clause to jvm type names (the ones with a 
			-- starting "L" and a closing ";"
		local
			i : INTEGER
		do
			if
				params /= Void
			then
				from
					create Result.make (params.lower, params.upper)
					i := params.lower
				until
					i > params.upper
				loop
					Result.put (java_to_jvm_name (params.item (i)), i)
					i := i + 1
				end
			end
		ensure
			params_not_void_implies_result_not_void: params /= Void implies Result /= Void
			same_size: params /= Void implies params.count = Result.count
		end
	
	eiffel_external_parameter_names_to_jvm_parameters (params: ARRAY [STRING]): STRING is
			-- takes an array of parameter type names as specified in 
			-- eiffel source code in the java external signature clause 
			-- and converts them to their jvm equivalent in form of a 
			-- concatenated string
			-- Note: this feature is about parameters and not return types
		require
			params_not_void: params /= Void
		local
			i: INTEGER
		do
			from
				i := params.lower
				create Result.make (params.count)
			until
				i > params.upper
			loop
				Result.append (java_to_jvm_name (params.item (i)))
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			result_count: Result.count >= params.count
		end
							
	eiffel_external_signature_to_jvm_signature (params: ARRAY [STRING]; return_type: STRING): STRING is
			-- converts the eiffel external signature type names as 
			-- found in the eiffel class text in the external signature 
			-- clause to a type description as demanded by the JVM
		do
			Result := clone ("(")
			if
				params /= Void
			then
				Result.append (eiffel_external_parameter_names_to_jvm_parameters (params))
			end
			result.append (")")
			if
				return_type /= Void
			then
				Result.append (java_to_jvm_name (return_type))
			else
				Result.append ("V")
			end
		end
			
	java_to_jvm_name (in: STRING): STRING is
			-- converts a java type name into a name as requested in many
			-- places in the JVM class file. That is object types start
			-- are of the form Lpackage/name/ClassName;
			-- Native types are represented by one letter acronyms and
			-- arrays begin with one or more "[".
		require
			in_not_void: in /= Void
		local
			i, n: INTEGER
		do
			in.replace_substring_all (".", "/")
			n := in.occurrences ('[')
			if
				n > 0
			then
				in.head (in.index_of ('[', 1) - 1)
			end
							
			Result := convert_non_array (in)
							
			from
				i := 1
			until
				i > n
			loop
				Result.prepend ("[")
				i := i + 1
			end
		end
			
	convert_non_array (in: STRING): STRING is
			-- if `in' is a name for a native java name (like int,
			-- short, ...) it will return it's JVM short name (I, S, ...)
			-- otherwise `Result' will be of the form L<in>;
		require
			in_not_void: in /= Void
		do
			if
				in.is_equal ("byte")
			then
				Result := "B"
			elseif
				in.is_equal ("char")
			then
				Result := "C"
			elseif
				in.is_equal ("double")
			then
				Result := "D"
			elseif
				in.is_equal ("float")
			then
				Result := "F"
			elseif
				in.is_equal ("int")
			then
				Result := "I"
			elseif
				in.is_equal ("long")
			then
				Result := "J"
			elseif
				in.is_equal ("short")
			then
				Result := "S"
			elseif
				in.is_equal ("boolean")
			then
				Result := "Z"
			elseif
				in.is_equal ("void")
			then
				Result := "V"
			else
				Result := "L" + in + ";"
			end
		ensure
			result_not_void: Result /= Void
			byte_conversion: in.is_equal ("byte") implies Result.is_equal ("B")
			char_conversion: in.is_equal ("char") implies Result.is_equal ("C")
			double_conversion: in.is_equal ("double") implies Result.is_equal ("D")
			float_conversion: in.is_equal ("float") implies Result.is_equal ("F")
			int_conversion: in.is_equal ("int") implies Result.is_equal ("I")
			long_conversion: in.is_equal ("long") implies Result.is_equal ("J")
			short_conversion: in.is_equal ("short") implies Result.is_equal ("S")
			boolean_conversion: in.is_equal ("boolean") implies Result.is_equal ("Z")
			void_conversion: in.is_equal ("void") implies Result.is_equal ("V")
			no_conversion: not (in.is_equal ("byte") or
									  in.is_equal ("char") or
									  in.is_equal ("double") or
									  in.is_equal ("float") or
									  in.is_equal ("int") or
									  in.is_equal ("long") or
									  in.is_equal ("short") or
									  in.is_equal ("void") or
									  in.is_equal ("boolean")) implies Result.is_equal ("L" + in + ";")
		end
			
	jvm_type_descriptor_to_jvm_type_names (s: STRING): ARRAY [STRING] is		
			-- takes a string of concatenated jvm type names (as in "I", 
			-- "[I" or "Ljava/lang/String;" and gives you back an array of 
			-- strings filled with the type names that make the string `s' up.
			-- so simply speaking it splits the string `s'
		require
			s_not_void: s /= Void
		local
			s_pos: INTEGER
						-- current position in `s'
			j: INTEGER
						-- temporary cursor position in `s'
			c: CHARACTER
						-- character at s.item (s_pos)
			current_type: STRING
						-- current type
		do
			
			from
				s_pos := 1
				create Result.make (1,0)
			until
				s_pos > s.count
			loop
				c := s.item (s_pos)
				inspect
					c
				when '[' then
					from
						j := s_pos
					until
						s.item (j) = 'L' or
						s.item (j) = 'B' or
						s.item (j) = 'C' or
						s.item (j) = 'D' or
						s.item (j) = 'F' or
						s.item (j) = 'I' or
						s.item (j) = 'J' or
						s.item (j) = 'S' or
						s.item (j) = 'Z'
					loop
						j := j + 1
					end
					if
						s.item (j) = 'L'
					then
						current_type := s.substring (s_pos, s.index_of (';', j + 1))
						s_pos := j + current_type.count
					else
						current_type := s.substring (j, s_pos)
						s_pos := j + 1
					end
				when 'L' then
					-- type is a complex type
					-- ends with a semi collon
					current_type := s.substring (s_pos, s.index_of (';', s_pos + 1))
					s_pos := s_pos + current_type.count
				else
					-- type is a native value type 
					-- and thus is only one character wide
					current_type := c.out
					s_pos := s_pos + 1
				end
				Result.force (current_type, Result.count + 1)
			end
		ensure
			result_not_void: Result /= Void
		end
	
	jvm_type_descriptors_to_jvm_type_ids (s: STRING): ARRAY [INTEGER] is
			-- takes a string of concatenated jvm type names (as in "I", "[I" or "Ljava/lang/String;")
			-- and gives you an array of the corresponding jvm type 
			-- ids back
		require
			s_not_void: s /= Void
		local
			c: CHARACTER
			i: INTEGER
		do
			from
				i := 1
				create Result.make (1, 0)
			variant
				pos: s.count + 1 - i
			until
				i > s.count
			loop
				c := s.item (i)
				inspect
					c
				when '[' then
					Result.force (object_type, Result.count + 1)
					i := i + 1
								-- eat other brackets
					from
					until
						s.item (i) /= '['
					loop
						i := i + 1
					end
					-- eat generic type
					if
						s.item (i) = 'L'
					then
						i := s.index_of (';', i) + 1
					else
						i := i + 1
					end
					check
						not_out_of_bounds: i /= 0
					end
				when 'L' then
					Result.force (object_type, Result.count + 1)
					i := i + 1
					i := s.index_of (';', i) + 1
					check
						not_out_of_bounds: i /= 0
					end
				when 'B' then
					Result.force (byte_type, Result.count + 1)
					i := i + 1
				when 'C' then
					Result.force (char_type, Result.count + 1)
					i := i + 1
				when 'D' then
					Result.force (double_type, Result.count + 1)
					i := i + 1
				when 'F' then
					Result.force (float_type, Result.count + 1)
					i := i + 1
				when 'I' then
					Result.force (int_type, Result.count + 1)
					i := i + 1
				when 'J' then
					Result.force (long_type, Result.count + 1)
					i := i + 1
				when 'S' then
					Result.force (short_type, Result.count + 1)
					i := i + 1
				when 'Z' then
					Result.force (bool_type, Result.count + 1)
					i := i + 1
				when 'V' then
					Result.force (void_type, Result.count + 1)
					i := i + 1
				else
					check
						dead_end: False
					end
				end
			end
		end
			
			
feature
	eiffel_type_id_to_jvm_type_id (eiffel: INTEGER) : INTEGER is
			-- takes an eiffel type id (as supplied by the parser front
			-- end) and returns it's JVM type id. Please note that while
			-- eiffel type ids are a bidirectional match to a type JVM
			-- type ids are not. (There is a unique type id for each basic type
			-- and one common id for all the rest)
			-- See JVM_CONSTANTS *_type for details
		do
			Result := repository.item (eiffel).jvm_type_id
		end
			
end -- class JVM_NAME_CONVERTER






