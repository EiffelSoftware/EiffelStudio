indexing
	description: "[
		A service for logging messages in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	LOGGER_S

inherit
	SERVICE_I

	USABLE_I

inherit {NONE}
	SHARED_ENVIRONMENT_CATEGORIES
		export
			{NONE} all
		end

	SHARED_PRIORITY_LEVELS
		export
			{NONE} all
		end

feature -- Access

	log_cache_length: INTEGER_32 assign set_log_cache_length
			-- Length of sustained logged item cache.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Element change

	set_log_cache_length (a_length: like log_cache_length)
			-- Sets the upper limit on the length of log cache.
			-- See `log_cache_length' for more details.
			--
			-- `a_length': Length of logger cache.
		require
			is_interface_usable: is_interface_usable
			reasonable_a_length: a_length >= 10
		deferred
		ensure
			log_cache_length_set: log_cache_length = a_length
		end

feature -- Extension

	put_message (a_msg: !STRING_32; a_cat: NATURAL_8)
			-- Logs a message.
			--
			-- `a_msg': Message text to log.
			-- `a_cat': A message category, see {ENVIRONMENT_CATEGORIES}.
		require
			is_interface_usable: is_interface_usable
			not_a_msg_is_empty: not a_msg.is_empty
			a_cat_is_empty_is_valid_category: is_valid_category (a_cat)
		do
			put_message_with_severity (a_msg, a_cat, {PRIORITY_LEVELS}.normal)
		end

	put_message_with_severity (a_msg: !STRING_32; a_cat: NATURAL_8; a_level: INTEGER_8)
			-- Logs a message specifiying a serverity level.
			--
			-- `a_msg': Message text to log.
			-- `a_cat': A message category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_level': A serverity level for the message, See {PRIORITY_LEVELS}.
		require
			is_interface_usable: is_interface_usable
			not_a_msg_is_empty: not a_msg.is_empty
			a_cat_is_empty_is_valid_category: is_valid_category (a_cat)
			a_level_is_valid_severity_level: is_valid_severity_level (a_level)
		deferred
		end

feature -- Removal

	clear_log
			-- Clear any cached log data.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Events

	message_logged_events: !EVENT_TYPE [TUPLE [message: !STRING_32; category: NATURAL_8; level: INTEGER_8]]
			-- Events called when a message has been logged.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Query

	frozen is_valid_category (a_cat: NATURAL_8): BOOLEAN
			-- Determines if `a_cat' is a valid logger category.
			--
			-- `a_cat': A category identifier to validate.
			-- `Result': True to indicate the category is valid; False otherwise.
		do
			Result := categories.is_valid_category (a_cat)
		end

	frozen is_valid_severity_level (a_level: INTEGER_8): BOOLEAN
			-- Determines if `a_level' is a valid severity level.
			--
			-- `a_level': A severity level.
			-- `Result': True to indicate the level of severity is valid; False otherwise.
		do
			Result := priorities.is_valid_priority_level (a_level)
		end

invariant
	reasonable_log_cache_length: log_cache_length >= 10

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
