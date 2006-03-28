indexing
	description: "Make project modifications."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_PROJECT_TEXT_MODIFICATION

inherit
	ERF_TEXT_MODIFICATION
		redefine
			load_text,
			save_text
		end

	SHARED_WORKBENCH

	EB_SAVE_FILE
		export
			{NONE} all
		end

	CONF_ACCESS

feature -- Highlevel element change

	change_root_class (a_class: STRING) is
			-- Change root class from current target to `a_class'.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
			target: universe.target /= Void
		local
			l_root: CONF_ROOT
		do
			l_root := universe.target.root
			if l_root /= Void then
				l_root.set_class_name (a_class)
			end
			rebuild_text
		end

	change_root_feature (a_feature: STRING) is
			-- Change root feature from current target to `a_featre'.
		require
			a_feature_ok: a_feature /= Void implies not a_feature.is_empty
			a_feature_lower: a_feature /= Void implies a_feature.is_equal (a_feature.as_lower)
			target: universe.target /= Void
		local
			l_root: CONF_ROOT
		do
			l_root := universe.target.root
			if l_root /= Void then
				l_root.set_feature_name (a_feature)
			end
			rebuild_text
		end

feature -- Element change

	load_text is
			-- Load the text.
		local
			l_print: CONF_PRINT_VISITOR
		do
			lace.load
			create l_print.make
			lace.conf_system.process (l_print)
			check
				no_error: not l_print.is_error
			end
			text := l_print.text
		end

	save_text is
			-- Save the text.
		do
			save (lace.file_name, text)
		end

feature {NONE} -- Implementation

	rebuild_text is
			-- Rebuild text from configuration information
		require
			text_managed: text_managed
		local
			l_print: CONF_PRINT_VISITOR
		do
			create l_print.make
			lace.conf_system.process (l_print)
			check
				no_error: not l_print.is_error
			end
			set_changed_text (l_print.text)
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

end
