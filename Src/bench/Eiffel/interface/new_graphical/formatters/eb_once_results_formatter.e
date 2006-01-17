indexing
	description: "Command to display results (if any) of once %
		%functions relevant to a given object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ONCE_RESULTS_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header
		end

	SHARED_APPLICATION_EXECUTION

create

	make

feature -- Properties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showonces 
		end
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showoncefunc
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showoncefunc
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Oncefunc_of
		end

	post_fix: STRING is "onc"

	criterium (f: E_FEATURE): BOOLEAN is
			-- `f' is a once function and `f' is written in a descendant of ANY
			-- or the object is a direct instance of a parent of ANY
		require
			f_exists: f /= Void
		do
			Result := f.is_once and f.is_function
		end

	create_structured_text (object: OBJECT_STONE): STRUCTURED_TEXT is
		local
			once_func_list: SORTED_TWO_WAY_LIST [E_FEATURE]
			once_request: ONCE_REQUEST
			arguments: E_FEATURE_ARGUMENTS
			e_feature: E_FEATURE
			dynamic_class: CLASS_C
			type_name: STRING
			status: APPLICATION_STATUS	
			cs: CLASSC_STONE
			wd: EV_WARNING_DIALOG			
		do
			status := Application.status
			if status = void then
				create wd.make_with_text (Warning_messages.w_System_not_running)
				wd.show_modal
			elseif not status.is_stopped then
				create wd.make_with_text (Warning_messages.w_System_not_stopped)
				wd.show_modal
			else
				create Result.make
				dynamic_class := object.dynamic_class
				once_func_list := dynamic_class.once_functions
				create once_request.make
				type_name := clone (dynamic_class.name)
				type_name.to_upper
				create cs.make (dynamic_class)
				Result.add_classi (dynamic_class.lace_class, type_name)
				Result.add_string (" [")
				Result.add_address (object.object_address, object.name, dynamic_class)
				Result.add_char (']')
				Result.add_new_line
				Result.add_new_line
				from
					once_func_list.start
				until
					once_func_list.after
				loop
					Result.add_indent
					e_feature := once_func_list.item
					e_feature.append_name (Result)
					arguments := e_feature.arguments
					if arguments /= Void then
						Result.add_string (" (")
						from
							arguments.start
						until
							arguments.after
						loop
							Result.add_string (arguments.argument_names.i_th (arguments.index))
							Result.add_string (": ")
							arguments.item.actual_type.append_to (Result)
							arguments.forth
							if not arguments.after then
								Result.add_string (" ")
							end
						end
						Result.add_char (')')
					end
					Result.add_string (": ")
					if once_request.already_called (e_feature) then
						once_request.once_result (e_feature).append_type_and_value (Result)
					else
						e_feature.type.append_to (Result)
						Result.add_indent
						Result.add_string ("Not yet called")
					end
					Result.add_new_line
					once_func_list.forth
				end
			end
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Finding values of once functions...")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_ONCE_RESULTS_FORMATTER
