indexing
	description: "Class which initiates the connection."
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

	debug_mode: BOOLEAN is TRUE
		-- Is Current Application being currently debugged?

end -- class GENERATED_CGI_HANDLER
