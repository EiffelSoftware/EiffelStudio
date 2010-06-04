note

	description:
		"Command to display once routines of `current_class'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ONCES

inherit
	E_CLASS_FORMAT_CMD
		redefine
			display_feature,
			criterion
		end

create
	make, default_create

feature -- Access

	criterion: QL_CRITERION
			-- Criterion used in current command
		local
			l_factory: like feature_criterion_factory
		do
			l_factory := feature_criterion_factory
			Result := l_factory.simple_criterion_with_index (l_factory.c_is_once) or
					 l_factory.simple_criterion_with_index (l_factory.c_is_constant)
		end

feature -- Output

	display_feature (f: E_FEATURE; a_text_formatter: TEXT_FORMATTER)
		local
			const: E_CONSTANT;
			ec: CLASS_I;
			str: STRING
		do
			f.append_signature (a_text_formatter);
			if f.is_constant then
				a_text_formatter.add_space
				a_text_formatter.process_keyword_text (ti_is_keyword, Void)
				a_text_formatter.add_space
				const ?= f;	--| Cannot fail
--				ec := const.type.associated_class.lace_class
				if ec = eiffel_system.character_class then
					str := "'"
				elseif ec = eiffel_system.string_class then
					str := "%""
				else
					str := ""
				end;
				if const.is_unique then
					a_text_formatter.add ("unique (");
					a_text_formatter.add (str);
					a_text_formatter.add (const.value_32);
					a_text_formatter.add (str);
					a_text_formatter.add_char (')')
				else
					a_text_formatter.add (str);
					a_text_formatter.add (const.value_32);
					a_text_formatter.add (str);
				end
			end
		end;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class E_SHOW_ONCES
