indexing
	description: "Predefined custom attributes blobls."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_CUSTOM_ATTRIBUTES

feature -- Predefined custom attributes

	not_cls_compliant_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not CLS compliant attribute
		once
			create Result.make
			Result.put_boolean (False)
			Result.put_integer_16 (0)
		end

	not_com_visible_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for not COM Visible attribute.
		once
			create Result.make
			Result.put_boolean (False)
			Result.put_integer_16 (0)
		end

	debugger_step_through_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for `System.Diagnostics.DebuggerStepThroughAttribute' attribute.
		once
			create Result.make
			Result.put_integer_16 (0)
		end

	debugger_hidden_ca: MD_CUSTOM_ATTRIBUTE is
			-- Blob for `System.Diagnostics.DebuggerHiddenAttribute' attribute.
		once
			create Result.make
			Result.put_integer_16 (0)
		end

end -- class IL_PREDEFINED_CUSTOM_ATTRIBUTES
