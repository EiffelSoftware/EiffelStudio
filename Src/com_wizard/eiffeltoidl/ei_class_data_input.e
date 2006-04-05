indexing
	description: "Input class information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_CLASS_DATA_INPUT

inherit
	EI_DATA_INPUT

	WIZARD_ERRORS
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			class_not_found := True
		end

feature -- Status report

	class_not_found: BOOLEAN
			-- Whether class in project.

feature -- Basic operations

	input_from_file (a_file_name: STRING) is
			-- Input features from text file `a_file_name'.
		local
			l_features: ARRAYED_LIST [STRING]
			l_name, l_description, l_last: STRING
			l_parser: EI_FEATURE_PARSER
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_file_name)
				if l_file.exists then
					l_file.open_read				
					from
						l_file.start
					until
						l_file.end_of_file
					loop
						l_file.read_line
						l_last := l_file.last_string
						if not l_last.is_empty then
							if l_last.substring_index (Class_header_indicator, 1) > 0 then
								class_not_found := False  
								l_file.read_line
								l_last := l_file.last_string
								l_name := l_last.twin
								l_name.left_adjust
								l_name.right_adjust
								create eiffel_class.make (l_name)
								from
								until
									l_file.end_of_file
								loop
									l_file.read_line
									l_last := l_file.last_string
									if not l_last.is_empty then
										if l_last.substring_index (Feature_indicator, 1) > 0 then
											if l_features /= Void and not l_features.is_empty then
												create l_parser
												l_parser.parse_routine (l_features)
												if l_parser.succeed then
													eiffel_class.add_feature (l_parser.parsed_feature)
												end
												l_features := Void
											end
			
											create l_features.make (20)
											l_features.extend (l_last.twin)
										elseif l_last.substring_index ("--", 1) = 1 then
											l_features.extend (l_last.twin)
										end
									end
								end
								if l_features /= Void and not l_features.is_empty then
									create l_parser
									l_parser.parse_routine (l_features)
									if l_parser.succeed then
										eiffel_class.add_feature (l_parser.parsed_feature)
									end
								end
							elseif l_last.substring_index (Description_indicator, 1) = 1 then
								l_description := parsed_description (l_last.twin)
							end
						end
					end
					l_file.close
		
					if not class_not_found then
						if eiffel_class /= Void and l_description /= Void and not l_description.is_empty then
							eiffel_class.set_description (l_description)
						end
						parse_eiffel_type
					end
				end
			end
		rescue
			l_retried := True
			environment.set_abort (Idl_generation_error)
		end

feature {NONE} -- Implementation

	parse_eiffel_type is
			-- Parse through the feature list to set the 'like' type to appropriate type.
		require
			valid_class: eiffel_class /= Void
		local
			l_feature: EI_FEATURE
			parameter_list: LIST [EI_PARAMETER]
		do
			-- Put type name to 'like ' type.
			if not eiffel_class.features.is_empty then
				from
					eiffel_class.features.start
				until
					eiffel_class.features.off
				loop
					l_feature := eiffel_class.features.item_for_iteration
					if l_feature.result_type.is_equal (Current_type) then
						l_feature.set_result_type (eiffel_class.name)
					elseif eiffel_class.features.has (l_feature.result_type) then
						l_feature.set_result_type (eiffel_class.features.item (l_feature.result_type).result_type)
					end

					parameter_list := eiffel_class.features.item_for_iteration.parameters
	
					-- Check parameter for 'like' type
					if not parameter_list.is_empty then
						from
							parameter_list.start
						until
							parameter_list.after
						loop
							if parameter_list.item.type.is_equal (Current_type) then
								parameter_list.item.set_type (eiffel_class.name)
							elseif eiffel_class.features.has (parameter_list.item.type) then
								parameter_list.item.set_type (eiffel_class.features.item (parameter_list.item.type).result_type)
							end

							parameter_list.forth
						end
					end
					eiffel_class.features.forth
				end
			end
		end

	parsed_description (desc: STRING): STRING is
			-- Description parsed from 'desc'
		require
			non_void_input: desc /= Void
			valid_desc : not desc.is_empty
		local
			s_pos, e_pos: INTEGER
		do
			s_pos := desc.index_of (Double_quote_character, 1) + 1
			e_pos := desc.last_index_of (Double_quote_character, desc.count) - 1

			if s_pos > e_pos then
				Result := ""
			else
				Result := desc.substring (s_pos, e_pos)
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
end -- class EI_CLASS_DATA_INPUT

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

