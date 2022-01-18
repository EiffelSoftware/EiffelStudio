note
	description: "Default implementation for a verification error."

class
	E2B_DEFAULT_VERIFICATION_ERROR

inherit

	E2B_VERIFICATION_ERROR

	SHARED_WORKBENCH

create
	make

feature -- Access

	message: STRING_32
			-- Message to be displayed.

	boogie_error: E2B_BOOGIE_PROCEDURE_ERROR
			-- Boogie error associated with this error.

feature -- Element change

	set_message (a_message: STRING_32)
			-- Set `message' to `a_message'.
		do
			message := a_message
			build_components
		end

	set_boogie_error (a_error: E2B_BOOGIE_PROCEDURE_ERROR)
			-- Set `boogie_error' to `a_error'.
		do
			boogie_error := a_error
		end

	set_line_number (a_line: INTEGER)
			-- Set `context_line_number' to `a_line'.
		do
			context_line_number := a_line
		end

feature -- Display

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- Single line description of this error.
		do
			across components as i loop
				if i[1] = '$' then
					process_placeholder (a_formatter, i.out)
				else
					a_formatter.add (i)
				end
			end
		end

feature {NONE} -- Implementation

	components: LINKED_LIST [STRING_32]
			-- Components of `message'.

	build_components
			-- Build components list.
		local
			l_current, l_next: INTEGER
			i: INTEGER
		do
			from
				create components.make
				l_current := 1
				l_next := message.index_of ('$', l_current)
			until
				l_next = 0
			loop
				if l_next - 1 >= l_current then
					components.extend (message.substring (l_current, l_next - 1))
				end
				from
					i := l_next + 1
				until
					i > message.count or not (message[i].is_alpha_numeric or message[i] = '_')
				loop
					i := i + 1
				end
				components.extend (message.substring (l_next, i - 1))
				l_current := i
				l_next := message.index_of ('$', l_current)
			end
			if l_current <= message.count then
				components.extend (message.substring (l_current, message.count))
			end
		end

	process_placeholder (a_formatter: TEXT_FORMATTER; a_placeholder: STRING)
			-- Add `a_placeholder' to `a_formatter'.
		local
			l_cid, l_rid, l_fid: INTEGER
			l_feature: FEATURE_I
			l_attributes: like boogie_error.attributes
		do
			if a_placeholder ~ "$tag" then
				if boogie_error.has_related_location then
					a_formatter.add_comment (safe_related_value ("tag"))
				else
					a_formatter.add_comment (safe_value ("tag"))
				end
			elseif a_placeholder ~ "$called_feature" then
				if boogie_error.is_postcondition_violation then
					l_attributes := boogie_error.related_attributes
				else
					l_attributes := boogie_error.attributes
				end
				if l_attributes.has_key ("cid") and l_attributes.has_key ("rid") then
					l_cid := l_attributes["cid"].to_integer
					l_rid := l_attributes["rid"].to_integer
					l_feature := system.class_of_id (l_cid).feature_of_rout_id (l_rid)
					a_formatter.add_char ('{')
					a_formatter.add_class (system.class_of_id (l_cid).original_class)
					a_formatter.add_char ('}')
					a_formatter.add_char ('.')
					a_formatter.add_feature (l_feature.api_feature (l_cid), l_feature.feature_name_32)
				elseif l_attributes.has_key ("cid") and l_attributes.has_key ("fid") then
					l_cid := l_attributes["cid"].to_integer
					l_fid := l_attributes["fid"].to_integer
					l_feature := system.class_of_id (l_cid).feature_of_feature_id (l_fid)
					a_formatter.add_char ('{')
					a_formatter.add_class (system.class_of_id (l_cid).original_class)
					a_formatter.add_char ('}')
					a_formatter.add_char ('.')
					a_formatter.add_feature (l_feature.api_feature (l_cid), l_feature.feature_name_32)
				else
					a_formatter.add_comment ("?called_feature")
				end
			elseif a_placeholder ~ "$explicit_value" then
				if boogie_error.is_postcondition_violation then
					a_formatter.add_comment (boogie_error.related_attributes["default"])
				else
					a_formatter.add_comment (boogie_error.attributes["default"])
				end
			elseif a_placeholder ~ "$type" then
				if boogie_error.has_related_location then
					a_formatter.add_comment (safe_related_value ("type"))
				else
					a_formatter.add_comment (safe_value ("type"))
				end
			elseif a_placeholder ~ "$variant" then
				a_formatter.add (boogie_error.attributes["varid"])
			else
				a_formatter.add_comment (a_placeholder)
			end
		end

	safe_value (a_key: STRING): STRING
			-- Safe attribute value `a_key'.
		do
			if boogie_error.attributes.has_key (a_key) then
				Result := boogie_error.attributes[a_key]
			else
				Result := "?" + a_key
			end
		end

	safe_related_value (a_key: STRING): STRING
			-- Safe attribute value `a_key'.
		require
			has_related: boogie_error.has_related_location
		do
			if boogie_error.related_attributes.has_key (a_key) then
				Result := boogie_error.related_attributes[a_key]
			else
				Result := "?" + a_key
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2015 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
