<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<%@ page language="Eiffel"%>

<html>
	<head>
		<link rel="stylesheet" href="default.css">
		<title>Validation Sample</title>

		<script runat="server">
			indexing
				description: "Uses both client-side and server-side ASP.NET validator controls"
				precompile_definition_file: "$ISE_CODEDOM\Samples\code_behind\ace.ace"
		</script>

		<script runat="server">
			validate_button_click (sender: SYSTEM_OBJECT; e: EVENT_ARGS) is
					-- Check whether page is valid and display corresponding message.
				do
					if page.is_valid then
						output_label.set_text ("Page is Valid!")
					else
						output_label.set_text ("Page is InValid! :-(")
					end
				end

			server_validate (sender: SYSTEM_OBJECT; value: WEB_SERVER_VALIDATE_EVENT_ARGS) is
					-- Validate page content.
				local
					l_value: STRING
				do
					l_value := value.value
					if l_value.is_integer then
						value.set_is_valid (l_value.to_integer \\ 2 = 0)
					end
				end
		</script>
	</head>
	<body>
		<h3>Validation</h3>
		<form runat="server" ID="main_form">
			<p>
				<asp:Label runat="server"
					Text="Enter an even number:"
					ID="output_label"
				/>
			</p>
			<p>	
				<asp:TextBox runat="server" ID="text_box" />
				
				<asp:RequiredFieldValidator runat="server"
					ControlToValidate="text_box"
					ErrorMessage="Please enter a number"
					Display="Dynamic"
					ID="required_field_validator"
				/>

				<asp:CustomValidator runat="server"
					ControlToValidate="text_box"
					OnServerValidate="server_validate"
					Display="Static"
					Text="Not an even number!"
					ID="custom_validator"
				/>
			</p>
			<p>
				<asp:Button runat="server"
					Text="Validate" 
					OnClick="validate_button_click"  
					ID="validate_button"
				/>
			</p>
		</form>
	</body>
</html>

<!--
--+--------------------------------------------------------------------
--| Eiffel for ASP.NET 5.6
--| Copyright (c) 2005-2006 Eiffel Software
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
-->
