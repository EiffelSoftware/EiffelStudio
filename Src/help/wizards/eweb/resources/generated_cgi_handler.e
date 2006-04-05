indexing
	description: "Class which initiates the connection."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David Solal"
	date: "$Date$"
	revision: "$Revision$"

class 
	GENERATED_CGI_HANDLER

inherit 
	CGI_INTERFACE
	
creation
	make

feature -- Execution

	execute is
			-- Script Execution 
		local
			script: SCRIPT
			s: STRING
		do
			if field_defined("form_type") then 
				s := text_field_value("form_type")
				if s.is_equal("contactinfo") then
					Create {CONTACT_INFO}script.make(Current)
				elseif s.is_equal("productpurchase") then
					Create {PRODUCT_PURCHASE}script.make(Current)
				elseif s.is_equal("payment") then
					Create {PAYMENT_INFO}script.make(Current)
				elseif s.is_equal("toolspurchase") then
					Create {TOOLS_PURCHASE}script.make(Current)
				elseif s.is_equal("thanks_purchase") then
					Create {THANKS}script.make(Current)
				else
					raise_error("form_type Value not recognized")
				end
				if script /= Void then
					script.load_resources
					script.check_fields
					script.process
					script.prepare_reply
					script.reply_browser
				end
			else
				raise_error("Form not recognized")
			end
		end

feature -- Access

	debug_mode: BOOLEAN is TRUE;
		-- Is Current Application being currently debugged?

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
end -- class GENERATED_CGI_HANDLER
