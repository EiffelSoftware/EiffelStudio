indexing
	description: "Abstract notion of value during the execution of the application in the dotnet world."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_ABSTRACT_DEBUG_VALUE

inherit
	ABSTRACT_DEBUG_VALUE

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

	ICOR_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end	
		
	EIFNET_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end			

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			is_equal			
		end		

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER		
		export
			{NONE} all
		undefine
			is_equal
		end	

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		undefine
			is_equal			
		end	
		
	SHARED_DEBUG_VALUE_KEEPER
		export
			{NONE} all
		undefine
			is_equal			
		end
		
feature {NONE} -- Init

	init_dotnet_data (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is
			-- Init data regarding to dotnet specific values
		do
			icd_referenced_value := a_referenced_value
			icd_value := a_prepared_value
			icd_frame := f
			create icd_value_info.make_from_prepared_value (icd_referenced_value, a_prepared_value)
		end

	register_dotnet_data is
			-- Register this object to estudio system
		do
			if address /= Void then
				debug ("debugger_eifnet_data")
					print (generating_type + ".register_dotnet_data : " + address)
					print ("%N")
				end
				Debug_value_keeper.keep_dotnet_value (Current)				
			end
		end		

feature {NONE} -- Special childrens

	children_from_external_type: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Children list from a Reference which is an external type
			-- (ie: a dotnet type, not pure Eiffel)
		local
			l_object_value: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_class_token: INTEGER			
			l_icd_module: ICOR_DEBUG_MODULE
			l_md_import: MD_IMPORT
			l_tokens: DS_ARRAYED_LIST [INTEGER]
			l_tokens_array: ARRAY [INTEGER]
			
			l_tokens_cursor: DS_LINEAR_CURSOR [INTEGER]
			l_tokens_count: INTEGER
			l_enum_hdl: INTEGER
			
			l_att_token: INTEGER
			l_att_icd_debug_value: ICOR_DEBUG_VALUE
			l_att_debug_value: ABSTRACT_DEBUG_VALUE
			l_att_name: STRING
		do
			if icd_value_info.has_object_interface then
				l_object_value := icd_value_info.interface_debug_object_value			
			end
			
			if l_object_value /= Void then
				l_icd_class := l_object_value.get_class
				
				if l_icd_class /= Void then
					l_class_token := l_icd_class.get_token
					
					l_icd_module := l_icd_class.get_module
					l_md_import := l_icd_module.interface_md_import

						--| Get "direct" Fields
					l_enum_hdl := 0
					l_tokens_array := l_md_import.enum_fields ($l_enum_hdl, l_class_token, 10)
					l_tokens_count := l_md_import.count_enum (l_enum_hdl)
					if l_tokens_count > 0 then
						create l_tokens.make_from_array (l_tokens_array)
						if l_tokens_count > l_tokens_array.count then
								-- We need to retrieve the rest of the data
							l_tokens_array := l_md_import.enum_fields ($l_enum_hdl, l_class_token, l_tokens_count - 10)
--							l_tokens.fill (l_tokens_array)
							l_tokens.extend_last (create {DS_ARRAYED_LIST [INTEGER]}.make_from_array (l_tokens_array))
						end
					end
					l_md_import.close_enum (l_enum_hdl)
				
-- FIXME JFIAT: 2004-01-14 : Check with User's preference limit.
-- FIXME JFIAT: 2004-01-14 : do we get all inherited fields too ?
	
					
					if l_tokens /=  Void then
						create {DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make (l_tokens.count)
						from
							l_tokens_cursor := l_tokens.new_cursor
							l_tokens_cursor.start
						until
							l_tokens_cursor.after
						loop
							l_att_token := l_tokens_cursor.item
							l_att_name := l_md_import.get_field_props (l_att_token)							
							
							l_att_icd_debug_value := l_object_value.get_field_value (l_icd_class, l_att_token)
							if l_att_icd_debug_value /= Void then
								l_att_debug_value := debug_value_from_icdv (l_att_icd_debug_value)
								if l_att_debug_value /= Void then
									l_att_debug_value.set_name (l_att_name)
									Result.put_last (l_att_debug_value)
								end
							end
							l_tokens_cursor.forth
						end
					end
				end
			end
		end		

feature -- Properties

	icd_frame: ICOR_DEBUG_FRAME


	icd_referenced_value: ICOR_DEBUG_VALUE
			-- Original ICorDebugValue from Debugger
			-- not dereferenced !
			-- may be useful to ICorDebugEval::CallFunction ...
			
	icd_value: ICOR_DEBUG_VALUE
			-- Value of object.
			-- unreferenced, unboxed ...

	icd_value_info: EIFNET_DEBUG_VALUE_INFO
			-- Value info of object.
	
end
