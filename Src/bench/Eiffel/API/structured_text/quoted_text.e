indexing

	description: 
		"Text within comments that have been `quoted'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class QUOTED_TEXT

inherit
	FEATURE_TEXT
		rename
			make as feature_text_make
		redefine
			append_to
		end

	CLASS_NAME_TEXT
		rename
			make as class_text_make
		redefine
			append_to
		end

	CLUSTER_NAME_TEXT
		rename
			make as cluster_text_make
		redefine
			append_to
		end

	DOCUMENTATION_FACILITIES
		export
			{NONE} all
		end

create

	make

feature -- Initialization

	make (text: like image) is
			-- Initialize image_without_quotes with `text'.
		require
			valid_text: text /= Void
		do
			image_without_quotes := text
			image := text.twin
			image.precede ('`')
			image.extend ('%'')
			e_feature := feature_by_name (text)
			if e_feature = Void then
				if (create {IDENTIFIER_CHECKER}).is_valid_upper (text) then
					class_i := class_by_name (text)
				end
				if class_i = Void then
					cluster_i := cluster_by_name (text)
				end
			end
		ensure
			image_without_quotes = text
		end

feature -- Properties

	image_without_quotes: STRING
			-- Used by documentation generation.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append quoted text to `text'.
		do
			if e_feature /= Void then
				text.process_feature_text (Current)
			elseif class_i /= Void then
				text.process_class_name_text (Current)
			elseif cluster_i /= Void then
				text.process_cluster_name_text (Current)
			else
				text.process_quoted_text (Current)
			end
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

end -- class QUOTED_TEXT
