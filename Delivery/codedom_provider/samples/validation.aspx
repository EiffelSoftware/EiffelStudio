<HTML>
	<HEAD>
		<SCRIPT LANGUAGE="Eiffel" RUNAT="server">
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
					l_num: INTEGER
					l_retried: BOOLEAN
				do
						-- Only execute if no exception was raised
					if not l_retried then
							-- We use .NET System.Int32's `Parse' function.
							-- We could also store `value.value' in an Eiffel string and then
							-- use `{STRING}.to_integer' (after checking `{STRING}.is_integer')
						l_num := feature {DOTNET_INTEGER}.from_string (value.value)
						value.set_is_valid (l_num \\ 2 = 0)
					end
				rescue
						-- We need the rescue clause because `{DOTNET_INTEGER}.from_string'
						-- will raise an exception if the argument does not correspond to
						-- an integer value.
					l_retried := True
					value.set_is_valid (False)
					retry
				end
		</SCRIPT>
	</HEAD>
	<BODY>
		<H3><FONT FACE="Verdana">Validation</FONT></H3>
		<FORM RUNAT="server">
			<ASP:Label Id=output_label RUNAT="server" Text="Enter an even number:" Font-Name="Verdana" Font-Size="10pt" /><br>
			<P>	
				<ASP:TextBox ID=text_box RUNAT="server" />
				
				<ASP:RequiredFieldValidator Id="required_field_validator" RUNAT="server"
					ControlToValidate="text_box"
					ErrorMessage="Please enter a number"
					Display="Dynamic"
					Font-Name="verdana" Font-Size="10pt">
				</ASP:RequiredFieldValidator>

				<ASP:CustomValidator Id="custom_validator" RUNAT="server"
					ControlToValidate="text_box"
					OnServerValidate="server_validate"
					Display="Static"
					Font-Name="verdana" Font-Size="10pt">
					Not an even number!
				</ASP:CustomValidator>
			</P>
			<P>
				<ASP:Button text="Validate" onclick="validate_button_click" RUNAT="server" />
			</P>
		</FORM>
	</BODY>
</HTML>
